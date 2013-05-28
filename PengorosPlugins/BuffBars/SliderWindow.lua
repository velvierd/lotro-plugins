import "Turbine.Gameplay";
import "Turbine.UI";
import "PengorosPlugins.BuffBars";

SliderWindow = class(Turbine.UI.Window);

function SliderWindow:Constructor(settings)
    Turbine.UI.Window.Constructor(self);

    self.settings = settings;
    self.effects = {};
    self.cooldowns = {};
    self.locked = PengorosPlugins.Utils.KeyManager.IsLocked();
    self.hidden = PengorosPlugins.Utils.KeyManager.IsHidden();
    
    local width, height = self:SwapIfVertical(self.settings.barWidth, self.settings.barHeight);
    self:SetSize(width, height);
    self:SetBackColor(self.settings:GetBorderColor());
    
    self.inner = Turbine.UI.Control();
    self.inner:SetParent(self);
    self.inner:SetBackColor(self.settings:GetBackColor());
    self.inner:SetPosition(2, 2);
    self.inner:SetSize(width - 4, height - 4);
    
    -- add labels
    local minutes = math.floor(self.settings.timeMax / 60);
    for i = 5, minutes, 5 do
        self:AddLabel(i * 60);
    end
    
    if (minutes > 5 and math.fmod(minutes, 5)) ~= 0 then
        self:AddLabel(minutes * 60);
    elseif (minutes < 1 and self.settings.timeMax ~= 30) then
        self:AddLabel(self.settings.timeMax);
    end
    
    for i = 1, math.min(minutes, 5) do
        self:AddLabel(i * 60);
    end
    
    local default = {1, 10, 30};
    for i = 1, table.getn(default) do
        local time = default[i];
        if (i <= self.settings.timeMax) then
            self:AddLabel(time);
        end
    end
    
    -- hook effect events
    PengorosPlugins.Utils.KeyManager.AddListener(self);
    PengorosPlugins.Utils.EffectManager.AddListener(self);
    PengorosPlugins.Utils.CoolDownManager.AddListener(self);

    -- get the list of triggers we care about
    self.triggers = {};
    self.cooldownTriggers = {};
    for i = 1, table.getn(settings.triggers), 1 do
        if (settings.triggers[i].type == EffectTriggerType.CoolDown) then
               table.insert(self.cooldownTriggers, settings.triggers[i]);
           else
               table.insert(self.triggers, settings.triggers[i]);
        end
    end

    -- movement listeners
    self.DragEnd = function(sender)
        local left, top = self:GetPosition();
        self.settings.posX = left;
        self.settings.posY = top;
        Settings.Save();
    end
    
    -- check for the window being offscreen
    self.settings.posX, self.settings.posY = PengorosPlugins.Utils.ValidatePosition(self.settings.posX, self.settings.posY, width, height);    
    self:SetPosition(self.settings.posX, self.settings.posY);    
    
    -- add a context menu to show the options
    local contextMenu = Turbine.UI.ContextMenu();
    local menuItems = contextMenu:GetItems();
    menuItems:Add(Turbine.UI.MenuItem(L["Options"]));

    menuItems:Get(1).Click = function(sender, args)
    	Turbine.PluginManager.ShowOptions(Plugins.BuffBars);
    end;
    self.inner.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            contextMenu:ShowMenu();
        end
    end
    
    -- setup the initial state
    self:UpdateVisibility();
    if (not self.locked) then
        self:UiLocked(self.locked);
    end

    -- setup the initial state
    local effects = PengorosPlugins.Utils.EffectManager.GetEffects();
    local target = PengorosPlugins.Utils.PlayerManager.GetPlayer();
    for i = 1, effects:GetCount() do
        self:EffectAdded(effects:Get(i), target);
    end
    
    -- setup the initial state
    local pots = PengorosPlugins.Utils.CoolDownManager.GetPots();
    for i = 1, table.getn(pots) do
        self:PotAdded(pots[i]);
    end
end

function SliderWindow:Destroy()
    self:SetVisible(false);
    self.inner.MouseClick = nil;
    
    if (self.dragBar ~= nil) then
        self.dragBar:SetVisible(false);
        self.dragBar:SetTarget(nil);
        self.dragBar = nil;
    end
    
    PengorosPlugins.Utils.KeyManager.RemoveListener(self);
    PengorosPlugins.Utils.EffectManager.RemoveListener(self);
    PengorosPlugins.Utils.CoolDownManager.RemoveListener(self);
    
    local i;
    for i = 1, table.getn(self.effects) do
        self.effects[i]:Destroy();
    end
    self.effects = {};
    for i = 1, table.getn(self.cooldowns) do
        self.cooldowns[i]:Destroy();
    end
    self.cooldowns = {};
end

-- this function will swap the passed in vars if the bar is vertical
function SliderWindow:SwapIfVertical(x, y)
    if (self.settings.orientation < SliderOrientation.TopToBottom) then
        return x, y;
    else
        return y, x;
    end
end

function SliderWindow:AddLabel(time)
    local width, height = self:SwapIfVertical(self.settings.barWidth, self.settings.barHeight);
    local x, y = self:CalculatePosition(time);
    
    local label = Turbine.UI.Label();
    label:SetParent(self);
    label:SetMouseVisible(false);
    label:SetSize(self.settings.barHeight, self.settings.barHeight);
    label:SetPosition(x, y);
    label:SetForeColor(self.settings:GetFontColor());
    label:SetOutlineColor(self.settings:GetFontOutlineColor());
    label:SetFontStyle(Turbine.UI.FontStyle.Outline);
    label:SetFont(self.settings.font);
    local alignment, line_x, line_y;
    if (self.settings.orientation == SliderOrientation.LeftToRight) then
        alignment = Turbine.UI.ContentAlignment.MiddleRight;
        line_x = x + self.settings.barHeight;
        line_y = y;
    elseif (self.settings.orientation == SliderOrientation.RightToLeft) then
        alignment = Turbine.UI.ContentAlignment.MiddleLeft;
        line_x = x;
        line_y = y;
    elseif (self.settings.orientation == SliderOrientation.TopToBottom) then
        alignment = Turbine.UI.ContentAlignment.BottomCenter;
        line_x = x;
        line_y = y + self.settings.barHeight;
    else -- SliderOrientation.BottomToTop
        alignment = Turbine.UI.ContentAlignment.TopCenter;
        line_x = x;
        line_y = y;
    end
    label:SetTextAlignment(alignment);
        
    local format;
    if (self.settings.displayFormat == TimeDisplayFormat.Truncated) then
        format = PengorosPlugins.Utils.TimeFormat.TRUNCATED;
    elseif (self.settings.displayFormat == TimeDisplayFormat.Clock) then
        format = PengorosPlugins.Utils.TimeFormat.CLOCK;
    else
        format = PengorosPlugins.Utils.TimeFormat.LITERAL;
    end
    label:SetText(format(time));
    
    local line = Turbine.UI.Control();
    line:SetParent(self);
    line:SetBackColor(self.settings:GetBorderColor());
    line:SetSize(self:SwapIfVertical(1, self.settings.barHeight));
    line:SetPosition(line_x, line_y);
end

function SliderWindow:UpdateVisibility()
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
        elseif (self.settings.visibleType == WindowVisibility.HasEffects) then
            visible = (table.getn(self.effects) > 0 or table.getn(self.cooldowns) > 0);
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

function SliderWindow:InCombatChanged(inCombat)
    self:UpdateVisibility();
end

function SliderWindow:MountChanged(mounted, combat)
    self:UpdateVisibility();
end

function SliderWindow:UiLocked(locked)
    self.locked = locked;
    if (not self.locked) then
        self.dragBar = PengorosPlugins.UI.DragBar(self, "BuffBars: "..self.settings.name);
        self.dragBar:SetBarOnTop(not self.settings.fillBottomToTop);
        self.dragBar:SetBarVisible(not self.hidden);
        self.dragBar:SetDraggable(true);
    else
        if (self.dragBar ~= nil) then
            self.dragBar:SetDraggable(false);
            self.dragBar:SetTarget(nil);
            self.dragBar = nil;
        end
    end

    -- force a layout
    self:UpdateVisibility();
end

function SliderWindow:UiHidden(hidden)
    self.hidden = hidden;
    if (self.dragBar ~= nil) then
        self.dragBar:SetVisible(not hidden);
    end
    self:UpdateVisibility();
end

function SliderWindow:EffectAdded(effect, target)
    -- effects with no duration don't make sense here
    if (effect:GetDuration() > 86400) then
        return;
    end
    
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

    local item = SliderItem(self, effect, self.settings);
    item.Blacklist = function()
        table.insert(self.triggers, 1, self.settings:BlacklistEffect(effect));
        PengorosPlugins.BuffBars.RevertOptions();
        Settings.Save();
        self:EffectRemoved(effect, target);
    end
    item.AddTrigger = function()
        table.insert(self.triggers, 1, self.settings:AddEffect(effect));
        PengorosPlugins.BuffBars.RevertOptions();
        Settings.Save();
    end
    table.insert(self.effects, item);
    self:UpdateVisibility();
end

function SliderWindow:EffectRemoved(effect, target)
    local i;
    for i = 1, table.getn(self.effects) do
        if (self.effects[i]:GetEffect() == effect) then
            self.effects[i]:Destroy();
            table.remove(self.effects, i);
            break;
        end
    end
    self:UpdateVisibility();
end

function SliderWindow:EffectsCleared()
    local i;
    for i = 1, table.getn(self.effects) do
        self.effects[i]:Destroy();
    end
    self.effects = {};
    self:UpdateVisibility();
end

function SliderWindow:PotAdded(pot)
    -- does this pot match any triggers
    local match = false;
    for i = 1, table.getn(self.cooldownTriggers), 1 do
        if (self.cooldownTriggers[i]:MatchesPot(pot)) then
            if (self.cooldownTriggers[i].blacklist) then
                return;
            end
            match = true;
            break;
        end
    end
    if (not match) then
        return;
    end

    local item = SliderCoolDownItem(self, pot, self.settings);
    item.Blacklist = function()
        table.insert(self.cooldownTriggers, 1, self.settings:BlacklistPot(pot));
        Settings.Save();
        self:PotRemoved(pot);
    end
    table.insert(self.cooldowns, item);
    self:UpdateVisibility();
end

function SliderWindow:PotRemoved(pot)
    local i;
    for i = 1, table.getn(self.cooldowns) do
        if (self.cooldowns[i]:GetPot() == pot) then
            self.cooldowns[i]:Destroy();
            table.remove(self.cooldowns, i);
            break;
        end
    end
    self:UpdateVisibility();
end

function SliderWindow:CalculatePosition(remaining)
    if (remaining > self.settings.timeMax) then
        remaining = self.settings.timeMax;
    end

    local barWidth = self.settings.barWidth - self.settings.barHeight;    
    local x = math.pow(remaining / self.settings.timeMax, self.settings.timeCompression);
    x = x > 1 and 1 or x;
    x = x * barWidth;
    
    -- adjust the position based on the bar orientation
    if (self.settings.orientation == SliderOrientation.LeftToRight) then
        return barWidth - x, 0;
    elseif (self.settings.orientation == SliderOrientation.RightToLeft) then
        return x, 0;
    elseif (self.settings.orientation == SliderOrientation.TopToBottom) then
        return 0, barWidth - x;
    else -- SliderOrientation.BottomToTop
        return 0, x;
    end
end