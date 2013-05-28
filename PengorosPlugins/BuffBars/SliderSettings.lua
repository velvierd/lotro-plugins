import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

SliderSettings = class(PengorosPlugins.BuffBars.EffectSettings);

function SliderSettings:Constructor(saved)
    PengorosPlugins.BuffBars.EffectSettings.Constructor(self, saved);
end

function SliderSettings:SetDefaults()
    PengorosPlugins.BuffBars.EffectSettings.SetDefaults(self);

    local displayWidth = Turbine.UI.Display:GetWidth();
    local displayHeight = Turbine.UI.Display:GetHeight();

    -- general    
    self.visibleType = WindowVisibility.HasEffects;
    self.orientation = SliderOrientation.LeftToRight;
    self.timeMax = 180;
    self.timeCompression = 0.35;
    self.posX = displayWidth / 2 - 200;
    self.posY = ((displayHeight - 300) / 2) + 300;
    self.barHeight = 36;
    self.barWidth = 400;

    -- slider ui
    self.showEffectTimer = true;
    self.displayFormat = TimeDisplayFormat.Clock;
    self.backgroundColor = {a=40, r=0, g=121, b=254};
    self.borderColor = {a=255, r=0, g=121, b=254};
    self.fontColor = {a=255, r=255, g=255, b=255};
    self.fontOutlineColor = {a=255, r=0, g=0, b=0};
    self.font = Turbine.UI.Lotro.Font.Verdana12;
end

function SliderSettings:GetBackColor()
    return self:GetColor(self.backgroundColor);
end
    
function SliderSettings:GetBorderColor()
    return self:GetColor(self.borderColor);
end

function SliderSettings:GetFontColor()
    return self:GetColor(self.fontColor);
end

function SliderSettings:GetFontOutlineColor()
    return self:GetColor(self.fontOutlineColor);
end
