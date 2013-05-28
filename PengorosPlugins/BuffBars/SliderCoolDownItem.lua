import "Turbine.UI";
import "Turbine.UI.Lotro";
import "PengorosPlugins.BuffBars";

SliderCoolDownItem = class(Turbine.UI.Control);

-- these two methods should allow a CD slider item
-- http://forums.lotro.com/showthread.php?383438-Background-Resizing
-- http://forums.lotro.com/showthread.php?369771-Item-GetIconImageId
-- https://docs.google.com/spreadsheet/ccc?key=0Akb6O_l2a3G4dDJUaXoyeFdlLXk1a3hPYnR6UXZBQ1E#gid=0

function SliderCoolDownItem:Constructor(parent, pot, settings)
    Turbine.UI.Control.Constructor(self);

    -- vars
    self.settings = settings;
    self.pot = pot;
    self.lastRemaining = -1;
    self.startTime = pot:GetStartTime();
    self.duration = pot:GetDuration();
    self.endTime = (self.startTime + self.duration);
    
    -- image
    self.image = Turbine.UI.Control();
    self.image:SetParent(self);
    self.image:SetSize(32, 32);
    self.image:SetBackground(pot.imageId);
    self.image:SetStretchMode(1);
    self.image:SetSize(self.settings.barHeight, self.settings.barHeight);
    
    local gameTime = Turbine.Engine.GetGameTime();
    self:SetParent(parent);
    self:SetSize(32, 32);
    self:SetBackground(pot.backgroundImageId);
    self:SetStretchMode(1);
    self:SetSize(self.settings.barHeight, self.settings.barHeight);
    if (gameTime < self.endTime) then
        self:SetWantsUpdates(true);
    end
    -- hidden window
    self.window = Turbine.UI.Window();
    self.window:SetParent(parent);
    self.window:SetSize(self.settings.barHeight, self.settings.barHeight);
    self.window:SetVisible(true);
    
    self:SetPosition(parent:CalculatePosition(self.endTime - gameTime));
    
    -- label
    if (self.settings.showEffectTimer) then
        self.timer = Turbine.UI.Label();
        self.timer:SetParent(self.window);
        self.timer:SetMouseVisible(false);
        self.timer:SetSize(self.settings.barHeight, self.settings.barHeight);
        self.timer:SetPosition(0, 0);
        self.timer:SetForeColor(self.settings:GetFontColor());
        self.timer:SetOutlineColor(self.settings:GetFontOutlineColor());
        self.timer:SetFontStyle(Turbine.UI.FontStyle.Outline);
        self.timer:SetFont(self.settings.font);
        self.timer:SetTextAlignment(Turbine.UI.ContentAlignment.BottomCenter);
    end
    
    -- add a context menu to show the options
    local contextMenu = Turbine.UI.ContextMenu();
    local menuItems = contextMenu:GetItems();
    menuItems:Add(Turbine.UI.MenuItem(L["Blacklist"]));
    menuItems:Add(Turbine.UI.MenuItem(L["Options"]));
    
    menuItems:Get(1).Click = function(sender, args)
        self.Blacklist();
    end
    menuItems:Get(2).Click = function(sender, args)
    	Turbine.PluginManager.ShowOptions(Plugins.BuffBars);
    end

    self.window.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            contextMenu:ShowMenu();
        end
    end
end

function SliderCoolDownItem:GetPot()
	return self.pot;
end

function SliderCoolDownItem:Destroy()
    self:SetWantsUpdates(false);
    self:SetVisible(false);
    self.window:SetVisible(false);
    self.window.MouseClick = nil;
end

function SliderCoolDownItem:SetPosition(x, y)
    self.window:SetPosition(x, y);
    Turbine.UI.Lotro.EffectDisplay.SetPosition(self, x, y);
end

function SliderCoolDownItem:Update(args)
    local gameTime = Turbine.Engine.GetGameTime();

    -- update the text if needed
    local remaining = math.max(0, self.endTime - gameTime);
    local iRemaining = math.floor(remaining);
    if (self.timer ~= nil and iRemaining ~= self.lastRemaining) then
        local format;
        if (self.settings.displayFormat == TimeDisplayFormat.Truncated) then
            format = PengorosPlugins.Utils.TimeFormat.TRUNCATED;
        elseif (self.settings.displayFormat == TimeDisplayFormat.Clock) then
            format = PengorosPlugins.Utils.TimeFormat.CLOCK;
        else
            format = PengorosPlugins.Utils.TimeFormat.LITERAL;
        end
        self.timer:SetText(format(iRemaining));
        self.lastRemaining = iRemaining;
    end
    
    -- set the new position
    self:SetPosition(self.window:GetParent():CalculatePosition(remaining));
    
    if (gameTime > self.endTime) then
        self:SetWantsUpdates(false);
    end        
end
