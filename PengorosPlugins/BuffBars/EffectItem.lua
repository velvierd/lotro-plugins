import "Turbine.UI";
import "Turbine.UI.Lotro";
import "PengorosPlugins.BuffBars";

EffectItem = class(Turbine.UI.Control);

EffectItem.timerWidths = {};
EffectItem.timerWidths[Turbine.UI.Lotro.Font.Verdana10] = 38;
EffectItem.timerWidths[Turbine.UI.Lotro.Font.Verdana12] = 50;
EffectItem.timerWidths[Turbine.UI.Lotro.Font.Verdana14] = 58;
EffectItem.timerWidths[Turbine.UI.Lotro.Font.Verdana16] = 60;
EffectItem.timerWidths[Turbine.UI.Lotro.Font.Verdana18] = 74;
EffectItem.timerWidths[Turbine.UI.Lotro.Font.Verdana20] = 82;
EffectItem.timerWidths[Turbine.UI.Lotro.Font.Verdana22] = 82;
EffectItem.timerWidths[Turbine.UI.Lotro.Font.Verdana23] = 90;


function EffectItem:Constructor(settings, effect, target)
    Turbine.UI.Control.Constructor(self);
    
    self.flashPeriod = 2;
    self.lastFlash = 0;
    self.flash = false;
    self.settings = settings;
    
    --self:SetMouseVisible(false);
	if (effect.GetType ~= nil and effect:GetType():GetName() == "CombatAnalysisEffect") then
		self.effect = CombatAnalysisEffectDisplay();
		self.ca = true;
	else
		self.effect = Turbine.UI.Lotro.EffectDisplay();
		self.ca = false;
 	end
    self.effect:SetParent(self);
    
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
    self.name:SetVisible(self.settings.showEffectName or self.settings.showEffectTarget);

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
    local contextMenu = Turbine.UI.ContextMenu();
    local menuItems = contextMenu:GetItems();
    menuItems:Add(Turbine.UI.MenuItem(L["Blacklist"]));
    menuItems:Add(Turbine.UI.MenuItem(L["Add Trigger"]));
    menuItems:Add(Turbine.UI.MenuItem(L["Options"]));
    
    menuItems:Get(1).Click = function(sender, args)
        self.Blacklist();
    end
    menuItems:Get(2).Click = function(sender, args)
        self.AddTrigger();
    end
    menuItems:Get(3).Click = function(sender, args)
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
    
    -- set it
    self:SetEffect(effect, target);
end

function EffectItem:Destroy()
    self:SetVisible(false);
    self:SetWantsUpdates(false);
    self.MouseClick = nil;
end

function EffectItem:SetEffect(value, target)
    self.effect:SetEffect(value);
    
    -- only show the target if it isn't us
    local showTarget = self.settings.showEffectTarget and target ~= PengorosPlugins.Utils.PlayerManager:GetPlayer();
    self.name:SetVisible(self.settings.showEffectName or showTarget); -- set visible because we have the target at this point
    
    if (self.settings.showEffectName and showTarget) then
    	self.name:SetText("[" .. (target ~= nil and target:GetName() or value:GetTargetName()) .. "] " .. value:GetName());
    elseif (self.settings.showEffectName) then
    	self.name:SetText(value:GetName());
    elseif (showTarget) then
    	self.name:SetText("[" .. target:GetName() .. "]");
    end
    self.timer:SetText("");
    
    -- FIXME, this is a hack to remove party member items when the duration ends due to a bug... sigh
	if (target ~= PengorosPlugins.Utils.EffectManager.player) then
		--self.remove = target;
	end

    -- set the color based on the effect category
    local cat = value:GetCategory();
    -- fix for undefined category, remove when the cat is added to the enum
    if (cat == 256) then
        cat = Colors.Undefined;
    elseif (cat == -2) then
    	cat = Colors.MobDebuff;
    elseif (cat == -4) then
    	cat = Colors.MobCrowdControl;
    end
    self.remainingColor = self.settings:GetRemainingColor(cat);
    self.elapsedColor = self.settings:GetElapsedColor(cat);
    
    -- flash color
    self.flashRemainingColor = self.settings:GetRemainingColor(Colors.Flash);
    self.flashElapsedColor = self.settings:GetElapsedColor(Colors.Flash);

    self.elapsed:SetBackColor(self.elapsedColor);
    self.remaining:SetBackColor(self.remainingColor);

    self.startTime = value:GetStartTime();
    self.duration = value:GetDuration();
    self.endTime = (self.startTime + self.duration);

    if (Turbine.Engine.GetGameTime() < self.endTime) then
        self:SetWantsUpdates(true);
    end
end

function EffectItem:GetEffect()
    return self.effect:GetEffect();
end

function EffectItem:Update(args)
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
    if (self.duration > 86400) then
        percentComplete = 0;
        if (self.settings.showEffectDuration) then
            local time = format(math.floor(elapsedTime));
            self.timer:SetText(time);
        else
            self.timer:SetText("");
            self:SetWantsUpdates(false);
        end
    else
        local remaining = self.duration - math.ceil(elapsedTime);
        local time = format(remaining < 0 and 0 or remaining);
        self.timer:SetText(time);
        
        if (gameTime > self.endTime) then
            self:SetWantsUpdates(false);
            -- FIXME, hack for turbine party bug...
			if (self.remove ~= nil) then
				PengorosPlugins.Utils.EffectManager.RemoveEffect(self.effect:GetEffect(), self.remove);
			end
        end        
    end
 
    -- update the bar positions
    local width = self:GetWidth();
    local height = self:GetHeight();
    local offset = 0;
    if (self.settings.showEffectIcon) then
        width = width - height;
        offset = height;
    end
    local elapsedWidth = percentComplete * width;
    local remainingWidth = width - elapsedWidth;
    
    self.remaining:SetSize(remainingWidth, height-4);
    self.remaining:SetPosition(offset, 2);
    
    self.elapsed:SetSize(elapsedWidth, height-4);
    self.elapsed:SetPosition(offset + remainingWidth, 2);
    
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

function EffectItem:Flash(gameTime)
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

function EffectItem:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height);
    self:Layout();
end

function EffectItem:Layout()
    local width = self:GetWidth();
    local height = self:GetHeight();
    local timerWidth = EffectItem.timerWidths[self.settings.font];

    local offset = 0;    
    if (self.settings.showEffectIcon) then
    	if (self.ca) then
	        self.effect:SetSize(height - 4, height - 4);
	        self.effect:SetPosition(2, 2);
    	else
	        self.effect:SetSize(height, height);
	        self.effect:SetPosition(0, 0);
    	end
        offset = height;
    end
    self.effect:SetVisible(self.settings.showEffectIcon);
    
    self.remaining:SetSize(0, height);
    self.remaining:SetPosition(offset, 0);
    
    self.elapsed:SetSize(0, height);
    self.elapsed:SetPosition(offset, 0);
    
    self.name:SetSize(width - offset - timerWidth, height);
    self.name:SetPosition(offset, 0);

    self.timer:SetSize(timerWidth, height);
    self.timer:SetPosition(width - timerWidth - 3, 0);
end
