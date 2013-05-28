import "Turbine.Gameplay";
import "Turbine.UI";
import "PengorosPlugins.BuffBars";

EffectWindow = class(Turbine.UI.Window);

-- invisible window hack
EffectWindow.InvisibleColor = Turbine.UI.Color(0, 0, 0, 0);

function EffectWindow:Constructor(settings)
    Turbine.UI.Window.Constructor(self);
    
    self.settings = settings;
    self.locked = PengorosPlugins.Utils.KeyManager.IsLocked();
    self.hidden = PengorosPlugins.Utils.KeyManager.IsHidden();
    self:SetPosition(self.settings.posX, self.settings.posY);
    self:SetSize(0, 0);
    self:SetBackColor(self.settings:GetBackColor());
    
    -- figure out what triggers we have
	local showDebuffBar = false;
	local showBuffBar = false;
	local showCoolDownBar = false;
	local showMobDebuffBar = false;
	local showMobCCBar = false;
	local barMap = {};
    for i = 1, table.getn(settings.triggers), 1 do
    	local trigger = settings.triggers[i];
    	if (not showDebuffBar and trigger.type == EffectTriggerType.Debuff) then
    		showDebuffBar = true;
    	elseif (not showBuffBar and trigger.type == EffectTriggerType.Buff) then
    		showBuffBar = true;
    	elseif (not showCoolDownBar and trigger.type == EffectTriggerType.CoolDown) then
    		showCoolDownBar = true;
    	elseif (not showMobDebuffBar and trigger.type == EffectTriggerType.MobDebuff) then
    		showMobDebuffBar = true;
    	elseif (not showMobCCBar and trigger.type == EffectTriggerType.MobCrowdControl) then
    		showMobCCBar = true;
    	end
    end
    
    -- debuff list
    if (showDebuffBar) then
        self.debuffsEffectsList = EffectList(EffectTriggerType.Debuff, self.settings);
        self.debuffsEffectsList:SetParent(self);
        self.debuffsEffectsList.ItemAdded = function(sender, args)
            self:Layout();
        end
        self.debuffsEffectsList.ItemRemoved = function(sender, args)
            self:Layout();
        end
        barMap[EffectBar.Debuff] = self.debuffsEffectsList;
    end

    -- buff list
    if (showBuffBar) then
        self.buffsEffectsList = EffectList(EffectTriggerType.Buff, self.settings);
        self.buffsEffectsList:SetParent(self);
        self.buffsEffectsList.ItemAdded = function(sender, args)
            self:Layout();
        end
        self.buffsEffectsList.ItemRemoved = function(sender, args)
            self:Layout();
        end
        barMap[EffectBar.Buff] = self.buffsEffectsList;
    end
    
    -- cool down list
    if (showCoolDownBar) then
        self.coolDownList = CoolDownList(self.settings);
        self.coolDownList:SetParent(self);
        self.coolDownList.ItemAdded = function(sender, args)
            self:Layout();
        end
        self.coolDownList.ItemRemoved = function(sender, args)
            self:Layout();
        end
        barMap[EffectBar.CoolDown] = self.coolDownList;
    end
    
    -- mob debuff list
    if (showMobDebuffBar) then
        self.mobDebuffsEffectsList = EffectList(EffectTriggerType.MobDebuff, self.settings);
        self.mobDebuffsEffectsList:SetParent(self);
        self.mobDebuffsEffectsList.ItemAdded = function(sender, args)
            self:Layout();
        end
        self.mobDebuffsEffectsList.ItemRemoved = function(sender, args)
            self:Layout();
        end
        barMap[EffectBar.MobDebuff] = self.mobDebuffsEffectsList;
    end
    
    -- mob cc list
    if (showMobCCBar) then
        self.mobCCEffectsList = EffectList(EffectTriggerType.MobCrowdControl, self.settings);
        self.mobCCEffectsList:SetParent(self);
        self.mobCCEffectsList.ItemAdded = function(sender, args)
            self:Layout();
        end
        self.mobCCEffectsList.ItemRemoved = function(sender, args)
            self:Layout();
        end
        barMap[EffectBar.MobCC] = self.mobCCEffectsList;
    end
    
    -- layout order
	self.bars = {};
	for i = 1, table.getn(self.settings.barOrder) do
		local bar = barMap[self.settings.barOrder[i]];
		if (bar ~= nil) then
			table.insert(self.bars, bar);
		end
	end
    
    -- add a context menu to show the options
    local contextMenu = Turbine.UI.ContextMenu();
    local menuItems = contextMenu:GetItems();
    menuItems:Add(Turbine.UI.MenuItem(L["Options"]));

    menuItems:Get(1).Click = function(sender, args)
        if (type(self.settings.showOptions) == "function") then
            self.settings.showOptions();
        else
        	Turbine.PluginManager.ShowOptions(Plugins.BuffBars);
        end
    end
    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            contextMenu:ShowMenu();
        end
    end
    
    -- listen for events
    PengorosPlugins.Utils.KeyManager.AddListener(self);
    PengorosPlugins.Utils.PlayerManager.AddListener(self);
    
    -- movement listeners
    self.DragEnd = function(sender)
        local left, top = self:GetPosition();
        self.settings.posX = left;
        self.settings.posY = top;
        if (self.settings.fillBottomToTop) then
            self.settings.posY = self.settings.posY + self:GetHeight();
        end
        if (type(self.settings.saveSettings) == "function") then
            self.settings.saveSettings();
        else
            Settings.Save();
        end
    end
    
    -- check for the window being offscreen
    self.settings.posX = math.min(math.max(self.settings.posX, 0), Turbine.UI.Display:GetWidth() - self.settings.barWidth);
    if (self.settings.fillBottomToTop) then
        self.settings.posY = math.min(math.max(self.settings.posY, self.settings.barHeight), Turbine.UI.Display:GetHeight());
    else
        self.settings.posY = math.min(math.max(self.settings.posY, 0), Turbine.UI.Display:GetHeight() - self.settings.barHeight);
    end
    
    -- setup the initial state
    self:Layout();
    self:UpdateVisibility();
    if (not self.locked) then
        self:UiLocked(self.locked);
    end
end

function EffectWindow:Destroy()
    self:SetVisible(false);
    self.MouseClick = nil;
    
    if (self.dragBar ~= nil) then
        self.dragBar:SetVisible(false);
        self.dragBar:SetTarget(nil);
        self.dragBar = nil;
        self.SizeChanged = nil;
    end
    
    PengorosPlugins.Utils.KeyManager.RemoveListener(self);
    PengorosPlugins.Utils.PlayerManager.RemoveListener(self);
    
    local i;
    for i = 1, table.getn(self.bars) do
        self.bars[i]:Destroy();
    end
end

function EffectWindow:UpdateVisibility()
    local visible;
    if (self.hidden) then
        visible = false;
    elseif (not self.locked) then
        visible = true;
    else
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
    self:SetVisible(visible);
end

function EffectWindow:InCombatChanged(inCombat)
    self:UpdateVisibility();
end

function EffectWindow:MountChanged(mounted, combat)
    self:UpdateVisibility();
end

function EffectWindow:UiLocked(locked)
    self.locked = locked;
    if (not self.locked) then
        self.dragBar = PengorosPlugins.UI.DragBar(self, "BuffBars: "..self.settings.name);
        self.dragBar:SetBarOnTop(not self.settings.fillBottomToTop);
        self.dragBar:SetBarVisible(not self.hidden);
        self.dragBar:SetDraggable(true);
        self.SizeChanged = function(sender, args)
            self.dragBar:Layout();
        end
    else
        if (self.dragBar ~= nil) then
            self.dragBar:SetDraggable(false);
            self.dragBar:SetTarget(nil);
            self.dragBar = nil;
        end
        self.SizeChanged = nil;
    end

    -- force a layout
    self:Layout();
    self:UpdateVisibility();
end

function EffectWindow:UiHidden(hidden)
    self.hidden = hidden;
    if (self.dragBar ~= nil) then
        self.dragBar:SetVisible(not hidden);
    end
    self:UpdateVisibility();
end

function EffectWindow:Layout()
    -- layout the bars
    local windowHeight = 0;
    local i;
    local barAdded = false;
    for i = 1, table.getn(self.bars) do
        local bar = self.bars[i];
        local height = bar:GetItemCount() * self.settings.barHeight;

        -- add a spacer if necessary
        if (barAdded and height > 0) then
            windowHeight = windowHeight + self.settings.barHeight;
        end
        
        bar:SetPosition(0, windowHeight);
        bar:SetSize(self.settings.barWidth, height);
        bar:SetVisible(height > 0);
        windowHeight = windowHeight + height;
        if (barAdded == false) then
            barAdded = height > 0;        
        end
    end

    if (self.settings.fillBottomToTop) then
        self:SetPosition(self.settings.posX, self.settings.posY - (windowHeight == 0 and self.settings.barHeight or windowHeight));
    else
        self:SetPosition(self.settings.posX, self.settings.posY);
    end
    -- hack for the invisible window bug
    if (windowHeight == 0) then
        self:SetSize(self.settings.barWidth, (self.locked and 1 or self.settings.barHeight));
        self:SetBackColor(EffectWindow.InvisibleColor);
    else
        self:SetSize(self.settings.barWidth, windowHeight);
        self:SetBackColor(self.settings:GetBackColor());
    end
end

