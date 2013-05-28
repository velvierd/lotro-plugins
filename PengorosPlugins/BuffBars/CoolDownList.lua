import "Turbine.Gameplay";
import "Turbine.UI";
import "PengorosPlugins.BuffBars";

CoolDownList = class(Turbine.UI.ListBox);

function CoolDownList:Constructor(settings)
    Turbine.UI.ListBox.Constructor(self);
    
    self.settings = settings;
    self:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self:SetMaxItemsPerLine(1);
    self:SetMouseVisible(false);
    
    -- hook cool down events
    PengorosPlugins.Utils.CoolDownManager.AddListener(self);
    
    -- get the list of triggers we care about
	self.triggers = {};
    for i = 1, table.getn(settings.triggers), 1 do
    	if (settings.triggers[i].type == EffectTriggerType.CoolDown) then
   			table.insert(self.triggers, settings.triggers[i]);
    	end
    end
    
    -- setup the initial state
    local i;
    local pots = PengorosPlugins.Utils.CoolDownManager.GetPots();
    for i = 1, table.getn(pots) do
        self:PotAdded(pots[i]);
    end
end

function CoolDownList:Destroy()
    PengorosPlugins.Utils.CoolDownManager.RemoveListener(self);
end

function CoolDownList:PotAdded(pot)
	-- does this pot match any triggers
	local match = false;
    for i = 1, table.getn(self.triggers), 1 do
    	if (self.triggers[i]:MatchesPot(pot)) then
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

    -- create the cool down item
    local coolDownItem = CoolDownItem(pot, self.settings);
    coolDownItem:SetSize(self.settings.barWidth, self.settings.barHeight);
    coolDownItem.Blacklist = function()
		table.insert(self.triggers, 1, self.settings:BlacklistPot(pot));
	    Settings.Save();
        self:PotRemoved(pot);
    end
    
    -- sort methods
    if (self.settings.sortMethod == EffectBarSort.Time) then
        local coolDownEndTime = pot:GetEndTime();

        local i = 0;
        local insertAt = -1;

        for i = 1, self:GetItemCount() do
            local testPot = self:GetItem(i):GetPot();
            local testPotEndTime = testPot.startTime + testPot.duration;
            local dif = testPotEndTime - coolDownEndTime;
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
            self:AddItem(coolDownItem);
        else
            self:InsertItem(insertAt, coolDownItem);
        end
    elseif (self.settings.sortMethod == EffectBarSort.Name) then
        local coolDownName = coolDown.name;
        
        local i = 0;
        local insertAt = -1;

        for i = 1, self:GetItemCount() do
            local testPot = self:GetItem(i):GetPot();
            local testPotName = testPot.name;
            
            local dif = -1;
            if (string.lower(coolDownName) < string.lower(testPotName)) then
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
            self:AddItem(coolDownItem);
        else
            self:InsertItem(insertAt, coolDownItem);
        end
    else
        -- no sorting
        self:AddItem(coolDownItem);
    end
end

function CoolDownList:PotRemoved(pot)
    local i;

    -- remove the list item
    for i = 1, self:GetItemCount() do
        local potListItem = self:GetItem(i):GetPot();

        if (pot == potListItem) then
            local potElement = self:GetItem(i);
            potElement:Destroy();
            self:RemoveItemAt(i);
            break;
        end
    end
end
