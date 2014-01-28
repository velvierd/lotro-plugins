import "Turbine.UI";

PanelDivider = class(Turbine.UI.Label);

function PanelDivider:Constructor()
    Turbine.UI.Label.Constructor(self);

    self:SetFont(Turbine.UI.Lotro.Font.TrajanPro18);
    self:SetForeColor(Turbine.UI.Color(244/255, 255/255, 51/255));
    self:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self:SetOutlineColor(Turbine.UI.Color(0, 0, 0));
    self:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
end
