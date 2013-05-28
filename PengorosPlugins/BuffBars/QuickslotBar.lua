import "Turbine.Gameplay";
import "Turbine.UI";
import "PengorosPlugins.BuffBars";

QuickslotBar = class(Turbine.UI.Window);

function QuickslotBar:Constructor(settings)
    Turbine.UI.Window.Constructor(self);

    self.settings = settings;
    self.locked = PengorosPlugins.Utils.KeyManager.IsLocked();
    self.hidden = PengorosPlugins.Utils.KeyManager.IsHidden();
    self.triggers = {};
    self.levels = {};
    self.active = {};
    
    -- create quickslots for each trigger
    for i = 1, table.getn(self.settings.triggers), 1 do
        local trigger = self.settings.triggers[i];
        local slot = Turbine.UI.Lotro.Quickslot();
        if (trigger.triggerType == TriggerType.Effect) then
            self.triggers[trigger] = slot;
        else
            self.levels[trigger] = slot;
        end

        slot:SetParent(self);
        slot:SetPosition(0, 0);
        slot:SetSize(self.settings.quickslotSize, self.settings.quickslotSize);
        slot:SetVisible(false);
        slot.count = 0;
    end
    
    -- add listeners
    PengorosPlugins.Utils.EffectManager.AddListener(self);
    PengorosPlugins.Utils.PlayerManager.AddListener(self);
    PengorosPlugins.Utils.KeyManager.AddListener(self);
    
    -- movement listeners
    self.DragEnd = function(sender)
        local left, top = self:GetPosition();
        local width = self:GetWidth();
        self.settings.qsX = left + (width / 2);
        self.settings.qsY = top;
        Settings.Save();
    end
    
    -- check for the window being offscreen
    local width = 6 * self.settings.quickslotSize + 5 * self.settings.quickslotSpacing;
    local x = self.settings.qsX - (width / 2)
    local y = self.settings.qsY;
    x, y = PengorosPlugins.Utils.ValidatePosition(x, y, width, self.settings.quickslotSize);    
    self.settings.qsX = x + (width / 2);
    self.settings.qsY = y;

    -- setup the initial state
    self:SetBackColor(Turbine.UI.Color(0, 0, 0, 0));
    self:ResetBar();
    if (not self.locked) then
        self:UiLocked(self.locked);
    end
end

function QuickslotBar:Destroy()
    self:SetVisible(false);
    
    if (self.dragBar ~= nil) then
        self.dragBar:SetVisible(false);
        self.dragBar:SetTarget(nil);
        self.dragBar = nil;
    end
    
    PengorosPlugins.Utils.EffectManager.RemoveListener(self);
    PengorosPlugins.Utils.PlayerManager.RemoveListener(self);
    PengorosPlugins.Utils.KeyManager.RemoveListener(self);
    
    -- if we don't do this on plugin unload the client crashes
    for trigger,slot in pairs(self.triggers) do
        slot:SetShortcut(nil);
    end
    for level,slot in pairs(self.levels) do
        slot:SetShortcut(nil);
    end
end

function QuickslotBar:UpdateVisibility()
    local visible;
    if (self.hidden) then
        visible = false;
    elseif (not self.locked) then
        visible = true;
    else
        visible = table.getn(self.active) > 0;
        if (visible) then
            if (self.settings.visibleType == WindowVisibility.InCombat) then
                visible = PengorosPlugins.Utils.PlayerManager.GetPlayer():IsInCombat();
            elseif (self.settings.visibleType == WindowVisibility.OutOfCombat) then
                visible = not PengorosPlugins.Utils.PlayerManager.GetPlayer():IsInCombat();
            elseif (self.settings.visibleType == WindowVisibility.OnMount) then
                visible = PengorosPlugins.Utils.PlayerManager.GetPlayer():IsMounted();
            elseif (self.settings.visibleType == WindowVisibility.OnCombatMount) then
                visible = PengorosPlugins.Utils.PlayerManager.GetPlayer():IsOnCombatMount();
            elseif (self.settings.visibleType == WindowVisibility.NotMounted) then
                visible = not PengorosPlugins.Utils.PlayerManager.GetPlayer():IsMounted();
            else -- self.settings.visibleType == WindowVisibility.Always
                visible = true;
            end
        end
    end
    self:SetVisible(visible);
end

function QuickslotBar:InCombatChanged(inCombat)
    self:UpdateVisibility();
end

function QuickslotBar:MountChanged(mounted, combat)
    self:UpdateVisibility();
end

function QuickslotBar:UiLocked(locked)
    self.locked = locked;
    if (not self.locked) then
        self:ClearActive();
        
        -- add all the triggers
        for trigger,slot in pairs(self.triggers) do
            self:AddTrigger(trigger);
        end
        
        -- add all the levels
        for level,slot in pairs(self.levels) do
            self:AddLevel(level);
        end

        self.dragBar = PengorosPlugins.UI.DragBar(self, "BuffBars: "..self.settings.name);
        self.dragBar:SetBarOnTop(not self.settings.fillBottomToTop);
        self.dragBar:SetBarVisible(not self.hidden);
        self.dragBar:SetDraggable(true);
        
        self:UpdateVisibility();
    else
        if (self.dragBar ~= nil) then
            self.dragBar:SetDraggable(false);
            self.dragBar:SetTarget(nil);
            self.dragBar = nil;
        end
        
        self:SetBackColor(Turbine.UI.Color(0, 0, 0, 0));
        self:ResetBar();
    end
end

function QuickslotBar:UiHidden(hidden)
    self.hidden = hidden;
    if (self.dragBar ~= nil) then
        self.dragBar:SetVisible(not hidden);
    end
    self:UpdateVisibility();
end

function QuickslotBar:ResetBar()
    -- clear the exsiting triggers
    self:ClearActive();
    
    -- add anything that defaults to not present
    for trigger,slot in pairs(self.triggers) do
        if (not trigger:HasEffect()) then
            self:AddTrigger(trigger);
        end
    end

    -- add all the existing effects
    local i;
    local effects = PengorosPlugins.Utils.EffectManager.GetEffects();
    local target = PengorosPlugins.Utils.PlayerManager.GetPlayer();
    for i = 1, effects:GetCount() do
        self:EffectAdded(effects:Get(i), target);
    end
    
    -- check existing morale/power levels
    self:MoraleChanged(PengorosPlugins.Utils.PlayerManager.GetPlayer());
    self:PowerChanged(PengorosPlugins.Utils.PlayerManager.GetPlayer());

    -- force a layout
    self:Layout();
end

function QuickslotBar:EffectsCleared()
    -- just reset the bar on effect cleared
    self:ResetBar();
end

function QuickslotBar:EffectAdded(effect, target)
    -- don't add pots in unlocked mode
    if (not self.locked) then
        return;
    end
    
    -- don't add pots for effects that aren't on us
	if (target ~= PengorosPlugins.Utils.PlayerManager.GetPlayer()) then
		return;
	end
    
    -- see if any triggers match
    for trigger,slot in pairs(self.triggers) do
        if (trigger:MatchesEffect(effect)) then
            if (trigger:HasEffect()) then
                self:AddTrigger(trigger);
            else
                self:RemoveTrigger(trigger);
            end
        end
    end
end

function QuickslotBar:EffectRemoved(effect, target)
    -- don't add pots in unlocked mode
    if (not self.locked) then
        return;
    end
    
    -- don't add pots for effects that aren't on us
	if (target ~= PengorosPlugins.Utils.PlayerManager.GetPlayer()) then
		return;
	end
    
    -- see if any triggers match
    for trigger,slot in pairs(self.triggers) do
        if (trigger:MatchesEffect(effect)) then
            if (trigger:HasEffect()) then
                self:RemoveTrigger(trigger);
            else
                self:AddTrigger(trigger);
            end
        end
    end
end

function QuickslotBar:MaxMoraleChanged(player)
    self:MoraleChanged(player);
end

function QuickslotBar:MoraleChanged(player)
    if (self.locked == false) then
        return;
    end
    
    local maxMorale = player:GetMaxMorale();
    local morale = player:GetMorale();
    local percent = morale / maxMorale;
    
    -- see if any levels match
    for level,slot in pairs(self.levels) do
        if (level:MatchesLevelType(TriggerLevel.Morale)) then
            if (level:MatchesLevel(percent)) then
                self:AddLevel(level);
            else
                self:RemoveLevel(level);
            end
        end
    end
end

function QuickslotBar:MaxPowerChanged(player)
    self:PowerChanged(player);
end

function QuickslotBar:PowerChanged(player)
    if (self.locked == false) then
        return;
    end
    
    local maxPower = player:GetMaxPower();
    local power = player:GetPower();
    local percent = power / maxPower;
    
    -- see if any levels match
    for level,slot in pairs(self.levels) do
        if (level:MatchesLevelType(TriggerLevel.Power)) then
            if (level:MatchesLevel(percent)) then
                self:AddLevel(level);
            else
                self:RemoveLevel(level);
            end
        end
    end
end

function QuickslotBar:AddTrigger(trigger)
    self:AddItem(trigger, self.triggers);
end

function QuickslotBar:RemoveTrigger(trigger)
    self:RemoveItem(trigger, self.triggers);
end

function QuickslotBar:AddLevel(level)
    -- levels are only added once, if the count is greater than 0 return
    if (self.levels[level].count > 0) then
        return;
    end
    
    self:AddItem(level, self.levels);
end

function QuickslotBar:RemoveLevel(level)
    -- levels are only added once, if the count is 0 return
    if (self.levels[level].count == 0) then
        return;
    end
    
    self:RemoveItem(level, self.levels);
end

function QuickslotBar:AddItem(item, list)
    -- update the slot count
    list[item].count = list[item].count + 1;

    -- if the count is one we need to set the slot visible and relayout the widget
    if (list[item].count == 1) then
        list[item]:SetVisible(true);
    
        table.insert(self.active, list[item]);
        self:Layout();
    end
end

function QuickslotBar:RemoveItem(item, list)
    -- update the slot count
    list[item].count = list[item].count - 1;

    -- if the count is 0 we need to get rid of the slot and relayout
    if (list[item].count == 0) then
        for i = 1, table.getn(self.active), 1 do
            if (self.active[i] == list[item]) then
                table.remove(self.active, i);
                break;
            end
        end
    
        -- hide the quickslot
        list[item]:SetVisible(false);
    
        -- fix the layout
        self:Layout();        
    end
end

function QuickslotBar:ClearActive()
    self.active = {};
    for trigger,slot in pairs(self.triggers) do
        pcall(function()
            slot:SetVisible(true);
            slot:SetShortcut(trigger:GetShortcut());
        end);
        slot:SetVisible(false);
        slot.count = 0;
    end
    for level,slot in pairs(self.levels) do
        pcall(function()
            slot:SetVisible(true);
            slot:SetShortcut(level:GetShortcut());
        end);
        slot:SetVisible(false);
        slot.count = 0;
    end
end

function QuickslotBar:Layout()
    local size = table.getn(self.active);
    for i = 1, size, 1 do
        self.active[i]:SetPosition((i - 1) * (self.settings.quickslotSize + self.settings.quickslotSpacing), 0);
    end

    if (size > 0) then
        local width = size * self.settings.quickslotSize + (size - 1) * self.settings.quickslotSpacing;
        self:SetSize(width, self.settings.quickslotSize);
        self:SetPosition(self.settings.qsX - (width / 2), self.settings.qsY);
    end
    self:UpdateVisibility();
end
