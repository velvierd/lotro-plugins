import "Turbine.UI";
import "Turbine.UI.Lotro";

CoolDownItem = class(Turbine.UI.Control);

function CoolDownItem:Constructor(pot, settings)
    Turbine.UI.Control.Constructor(self);
    
    self.settings = settings;
    self.flashPeriod = 2;
    self.lastFlash = 0;
    self.flash = false;
    --self:SetMouseVisible(false);
    
    -- image
    self.iconBackground = Turbine.UI.Control();
    self.icon = Turbine.UI.Control();
    self.icon:SetParent(self.iconBackground);
    self.icon:SetSize(32, 32);
    self.icon:SetBackground(pot.imageId);
    self.icon:SetStretchMode(1);
    self.iconBackground:SetParent(self);
    self.iconBackground:SetSize(32, 32);
    self.iconBackground:SetBackground(pot.backgroundImageId);
    self.iconBackground:SetStretchMode(1);

    self.remaining = Turbine.UI.Control();
    self.remaining:SetParent(self);
    self.remaining:SetMouseVisible(false);
        
    self.elapsed = Turbine.UI.Control();
    self.elapsed:SetParent(self);
    self.elapsed:SetMouseVisible(false);

    self.name = Turbine.UI.Label();
    self.name:SetForeColor(Turbine.UI.Color(1, 1, 1, 1));
    self.name:SetOutlineColor(Turbine.UI.Color(1, 0, 0, 0));
    self.name:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.name:SetFont(self.settings.font);
    self.name:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.name:SetZOrder(100);
    self.name:SetParent(self);
    self.name:SetMouseVisible(false);
    self.name:SetVisible(self.settings.showEffectName);

    self.timer = Turbine.UI.Label();
    self.timer:SetForeColor(Turbine.UI.Color(1, 1, 1, 1));
    self.timer:SetOutlineColor(Turbine.UI.Color(1, 0, 0, 0));
    self.timer:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.timer:SetFont(self.settings.font);
    self.timer:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
    self.timer:SetZOrder(100);
    self.timer:SetParent(self);
    self.timer:SetMouseVisible(false);
    self.timer:SetVisible(self.settings.showEffectTimer);

    -- add a context menu to show the options
    local i;
    local contextMenu = Turbine.UI.ContextMenu();
    local menuItems = contextMenu:GetItems();
    menuItems:Add(Turbine.UI.MenuItem(L["Blacklist"]));
    menuItems:Add(Turbine.UI.MenuItem(L["Reset"]));
    menuItems:Add(Turbine.UI.MenuItem(L["Options"]));
    
    menuItems:Get(1).Click = function(sender, args)
        self.Blacklist();
    end;
    menuItems:Get(2).Click = function(sender, args)
        self:ResetPot();
    end;
    menuItems:Get(3).Click = function(sender, args)
    	Turbine.PluginManager.ShowOptions(Plugins.BuffBars);
    end;

    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            contextMenu:ShowMenu();
        end
    end
    
    self:SetPot(pot);
end

function CoolDownItem:Destroy()
    self:SetVisible(false);
    self:SetWantsUpdates(false);
    self.MouseClick = nil;
end

function CoolDownItem:SetPot(pot)
    self.pot = pot;
    self.name:SetText(pot:GetName());
    self.timer:SetText("");

    -- set the color based on the pot type
    self.remainingColor = self.settings:GetRemainingColor(pot:GetCategory());
    self.elapsedColor = self.settings:GetElapsedColor(pot:GetCategory());
    
    -- flash color
    self.flashRemainingColor = self.settings:GetRemainingColor(Colors.Flash);
    self.flashElapsedColor = self.settings:GetElapsedColor(Colors.Flash);
    
    self.elapsed:SetBackColor(self.elapsedColor);
    self.remaining:SetBackColor(self.remainingColor);

    self.startTime = pot:GetStartTime();
    self.duration = pot:GetDuration();
    self.endTime = (self.startTime + self.duration);

    if (Turbine.Engine.GetGameTime() < self.endTime) then
        self:SetWantsUpdates(true);
    end
end

function CoolDownItem:GetPot()
    return self.pot;
end

function CoolDownItem:ResetPot()
    -- reset the pot to get rid of the bar
    self.pot:Reset();
end

function CoolDownItem:Update(args)
    local gameTime = Turbine.Engine.GetGameTime();
    local elapsedTime = gameTime - self.startTime;
    local percentComplete = elapsedTime / self.duration;
    
    local format;
    if (self.settings.displayFormat == TimeDisplayFormat.Truncated) then
        format = PengorosPlugins.Utils.TimeFormat.TRUNCATED;
    elseif (self.settings.displayFormat == TimeDisplayFormat.Clock) then
        format = PengorosPlugins.Utils.TimeFormat.CLOCK;
    else
        format = PengorosPlugins.Utils.TimeFormat.LITERAL;
    end
    
    -- update the time
    local remaining = self.duration - math.ceil(elapsedTime);
    local time = format(remaining < 0 and 0 or remaining);
    self.timer:SetText(time);
    
    if (gameTime > self.endTime) then
        self:SetWantsUpdates(false);
    end        

    -- update the bar positions
    local width = self:GetWidth();
    local height = self:GetHeight();
    local elapsedWidth = percentComplete * width;
    local remainingWidth = width - elapsedWidth;
    
    self.remaining:SetSize(remainingWidth, height-4);
    self.remaining:SetPosition(0, 2);
    
    self.elapsed:SetSize(elapsedWidth, height-4);
    self.elapsed:SetPosition(remainingWidth, 2);
    
    -- update the flash
    if (self.settings.allowFlashing) then
        local remainingTime = self.duration - math.ceil(elapsedTime);
        if (remainingTime < self.settings.flashTime) then
            if (self.lastFlash == 0) then
                self.lastFlash = gameTime;
            end

            -- flash faster if it is almost time to expire
            if (remainingTime < (self.settings.flashTime / 2)) then
                self.flashPeriod = 0.5;
            end
            
            self:Flash(gameTime);
        end
    end
end

function CoolDownItem:Flash(gameTime)
    local elapsedFromColor = nil;
    local remainingFromColor = nil;
    local elapsedToColor = nil;
    local remainingToColor = nil;
    if (self.flash) then
        elapsedToColor = self.elapsedColor;
        remainingToColor = self.remainingColor;
        elapsedFromColor = self.flashElapsedColor;
        remainingFromColor = self.flashRemainingColor;
    else
        elapsedFromColor = self.elapsedColor;
        remainingFromColor = self.remainingColor;
        elapsedToColor = self.flashElapsedColor;
        remainingToColor = self.flashRemainingColor;
    end
    
    local elapsed = gameTime - self.lastFlash;
    local progress = elapsed / self.flashPeriod;
    local finalElapsedColor = nil;
    local finalRemainingColor = nil;
    
    if (progress > 1) then
        self.flash = not self.flash;
        self.lastFlash = gameTime;
        finalElapsedColor = elapsedToColor;
        finalRemainingColor = remainingToColor;
    else
        local q = 1 - progress;
        local ea = elapsedFromColor.A * q + elapsedToColor.A * progress;
        local er = elapsedFromColor.R * q + elapsedToColor.R * progress;
        local eg = elapsedFromColor.G * q + elapsedToColor.G * progress;
        local eb = elapsedFromColor.B * q + elapsedToColor.B * progress;
        local ra = remainingFromColor.A * q + remainingToColor.A * progress;
        local rr = remainingFromColor.R * q + remainingToColor.R * progress;
        local rg = remainingFromColor.G * q + remainingToColor.G * progress;
        local rb = remainingFromColor.B * q + remainingToColor.B * progress;
        finalElapsedColor = Turbine.UI.Color(ea, er, eg, eb);
        finalRemainingColor = Turbine.UI.Color(ra, rr, rg, rb);
    end

    self.elapsed:SetBackColor(finalElapsedColor);
    self.remaining:SetBackColor(finalRemainingColor);
end

function CoolDownItem:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height);
    self:Layout();
end

function CoolDownItem:Layout()
    local width = self:GetWidth();
    local height = self:GetHeight();
    local timerWidth = EffectItem.timerWidths[self.settings.font];

    local offset = 0;    
    if (self.settings.showEffectIcon) then
        self.iconBackground:SetSize(height, height);
        self.iconBackground:SetPosition(0, 0);
        offset = height;
    end
    self.iconBackground:SetVisible(self.settings.showEffectIcon);

    self.remaining:SetSize(0, height);
    self.remaining:SetPosition(offset, 0);
    
    self.elapsed:SetSize(0, height);
    self.elapsed:SetPosition(offset, 0);
    
    self.name:SetSize(width - offset - timerWidth, height);
    self.name:SetPosition(offset, 0);

    self.timer:SetSize(timerWidth, height);
    self.timer:SetPosition(width - timerWidth - 3, 0);
end
