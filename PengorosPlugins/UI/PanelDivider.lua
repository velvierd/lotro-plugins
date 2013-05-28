import "Turbine.UI";

PanelDivider = class(Turbine.UI.Label);

function PanelDivider:Constructor()
    Turbine.UI.Label.Constructor(self);

    self:SetFont(Turbine.UI.Lotro.Font.TrajanPro18);
    self:SetForeColor(yellowGoldColor);
    self:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self:SetOutlineColor(blackColor);
    self:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self:SetBackground(panelDivider);
end
