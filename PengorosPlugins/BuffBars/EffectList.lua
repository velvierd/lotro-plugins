import "Turbine.Gameplay";
import "Turbine.UI";
import "PengorosPlugins.BuffBars";

EffectList = class(Turbine.UI.ListBox);

function EffectList:Constructor(type, settings)
    Turbine.UI.ListBox.Constructor(self);
    
    self.settings = settings;
    self:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self:SetMaxItemsPerLine(1);
    self:SetMouseVisible(false);
    
    -- hook effect events
    PengorosPlugins.Utils.EffectManager.AddListener(self);
    
    -- get the list of triggers we care about
	self.triggers = {};
    for i = 1, table.getn(settings.triggers), 1 do
    	if (settings.triggers[i].type == type) then
   			table.insert(self.triggers, settings.triggers[i]);
    	end
    end
    
    -- setup the initial state
    local i;
    local effects = PengorosPlugins.Utils.EffectManager.GetEffects();
    local target = PengorosPlugins.Utils.PlayerManager.GetPlayer();
    for i = 1, effects:GetCount() do
        self:EffectAdded(effects:Get(i), target);
    end
end

function EffectList:Destroy()
    PengorosPlugins.Utils.EffectManager.RemoveListener(self);
end

function EffectList:EffectsCleared()
    local count = self:GetItemCount();
    while (count > 0) do
        local item = self:GetItem(1);
        item:Destroy();
        self:RemoveItemAt(1);
        count = count - 1;
    end
end

function EffectList:EffectAdded(effect, target)
	-- does this effect match any triggers
	local match = false;
    for i = 1, table.getn(self.triggers), 1 do
    	if (self.triggers[i]:MatchesEffect(effect, target)) then
    		if (self.triggers[i].blacklist) then
    			return;
    		end
    		match = true;
    		break;
    	end
    end
    if (not match) then
    	return;
    end
    
    -- create the effect item
    local effectItem = EffectItem(self.settings, effect, target);
    effectItem:SetSize(self.settings.barWidth, self.settings.barHeight);
    effectItem.Blacklist = function()
	    table.insert(self.triggers, 1, self.settings:BlacklistEffect(effect));
	    PengorosPlugins.BuffBars.RevertOptions();
	    if (type(self.settings.saveSettings) == "function") then
	        self.settings.saveSettings();
	    else
	        Settings.Save();
	    end
        self:EffectRemoved(effect, target);
    end
    effectItem.AddTrigger = function()
	    table.insert(self.triggers, 1, self.settings:AddEffect(effect));
	    PengorosPlugins.BuffBars.RevertOptions();
	    if (type(self.settings.saveSettings) == "function") then
	        self.settings.saveSettings();
	    else
	        Settings.Save();
	    end
    end
    
    -- sort methods
    if (self.settings.sortMethod == EffectBarSort.Time) then
        local effectEndTime = effect:GetStartTime() + effect:GetDuration();

        local i = 0;
        local insertAt = -1;

        for i = 1, self:GetItemCount() do
            local testEffect = self:GetItem(i):GetEffect();
            local testEffectEndTime = testEffect:GetStartTime() + testEffect:GetDuration();
            local dif = testEffectEndTime - effectEndTime;
            if (not self.settings.sortAscending) then
                dif = dif * -1;
            end
            if (self.settings.fillBottomToTop) then
                dif = dif * -1;
            end
            
            if (dif >= 0) then
                insertAt = i;
                break;
            end
        end

        if (insertAt == -1) then
            self:AddItem(effectItem);
        else
            self:InsertItem(insertAt, effectItem);
        end
    elseif (self.settings.sortMethod == EffectBarSort.Name) then
        local effectName = effect:GetName();
        
        local i = 0;
        local insertAt = -1;

        for i = 1, self:GetItemCount() do
            local testEffect = self:GetItem(i):GetEffect();
            local testEffectName = testEffect:GetName();
            
            local dif = -1;
            if (string.lower(effectName) < string.lower(testEffectName)) then
                dif = 1;
            end
            if (not self.settings.sortAscending) then
                dif = dif * -1;
            end
            if (self.settings.fillBottomToTop) then
                dif = dif * -1;
            end
            
            if (dif >= 0) then
                insertAt = i;
                break;
            end
        end

        if (insertAt == -1) then
            self:AddItem(effectItem);
        else
            self:InsertItem(insertAt, effectItem);
        end
    elseif (self.settings.sortMethod == EffectBarSort.Category) then
        local category = effect:GetCategory();

        local i = 0;
        local insertAt = -1;

        for i = 1, self:GetItemCount() do
            local testEffect = self:GetItem(i):GetEffect();
            local testEffectCategory = testEffect:GetCategory();
            local dif = testEffectCategory - category;
            if (not self.settings.sortAscending) then
                dif = dif * -1;
            end
            if (self.settings.fillBottomToTop) then
                dif = dif * -1;
            end
            
            if (dif >= 0) then
                insertAt = i;
                break;
            end
        end

        if (insertAt == -1) then
            self:AddItem(effectItem);
        else
            self:InsertItem(insertAt, effectItem);
        end
    else
        -- no sorting
        self:AddItem(effectItem);
    end
end

function EffectList:EffectRemoved(effect, target)
    local i;
    
    for i = 1, self:GetItemCount() do
        local effectListItem = self:GetItem(i):GetEffect();

        if (effect == effectListItem) then
            local effectElement = self:GetItem(i);
            effectElement:Destroy();
            self:RemoveItemAt(i);
            break;
        end
    end
end
