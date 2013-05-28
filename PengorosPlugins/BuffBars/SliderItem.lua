import "Turbine.UI";
import "Turbine.UI.Lotro";
import "PengorosPlugins.BuffBars";

SliderItem = class(Turbine.UI.Control);

function SliderItem:Constructor(parent, effect, settings)
    Turbine.UI.Control.Constructor(self);
    
    -- vars
    self.settings = settings;
    self.lastRemaining = -1;
    self.startTime = effect:GetStartTime();
    self.duration = effect:GetDuration();
    self.endTime = (self.startTime + self.duration);
    
    self:SetParent(parent);
    self:SetSize(self.settings.barHeight, self.settings.barHeight);
    local gameTime = Turbine.Engine.GetGameTime();
    self:SetPosition(parent:CalculatePosition(self.endTime - gameTime));
    if (gameTime < self.endTime) then
        self:SetWantsUpdates(true);
    end

    -- effect
	if (effect.GetType ~= nil and effect:GetType():GetName() == "CombatAnalysisEffect") then
		self.effect = CombatAnalysisEffectDisplay();
	else
		self.effect = Turbine.UI.Lotro.EffectDisplay();
 	end
    self.effect:SetParent(self);
    self.effect:SetEffect(effect);
    self.effect:SetSize(self.settings.barHeight, self.settings.barHeight);
    self.effect:SetMouseVisible(false);
    
    -- label
    if (self.settings.showEffectTimer) then
    	self.window = Turbine.UI.Window();
    	self.window:SetVisible(true);
    	self.window:SetSize(self.settings.barHeight, self.settings.barHeight);
    	self.window:SetZOrder(100);
    
        self.timer = Turbine.UI.Label();
        self.timer:SetParent(self.window);
        self.timer:SetMouseVisible(false);
        self.timer:SetPosition(0, 0);
        self.timer:SetForeColor(self.settings:GetFontColor());
        self.timer:SetOutlineColor(self.settings:GetFontOutlineColor());
        self.timer:SetFontStyle(Turbine.UI.FontStyle.Outline);
        self.timer:SetFont(self.settings.font);
        self.timer:SetTextAlignment(Turbine.UI.ContentAlignment.BottomCenter);
        self.timer:SetSize(self.settings.barHeight, self.settings.barHeight);
    end
    
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
    	Turbine.PluginManager.ShowOptions(Plugins.BuffBars);
    end

    self.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Right) then
            contextMenu:ShowMenu();
        end
    end
    if (self.window ~= nil) then
    	self.window.MouseClick = function(sender, args)
    		self.MouseClick(sender, args);
    	end
    end
end


function SliderItem:GetEffect()
	return self.effect:GetEffect();
end

function SliderItem:Destroy()
    self:SetWantsUpdates(false);
    self:SetVisible(false);
    self.MouseClick = nil;
    if (self.window ~= nil) then
    	self.window:SetVisible(false);
    	self.window.MouseClick = nil;
    end
end

function SliderItem:Update(args)
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
    self:SetPosition(self:GetParent():CalculatePosition(remaining));
    if (self.window ~= nil) then
	    self.window:SetPosition(self:GetParent():PointToScreen(self:GetPosition()));
	end
    
    if (gameTime > self.endTime) then
        self:SetWantsUpdates(false);
    end        
end
