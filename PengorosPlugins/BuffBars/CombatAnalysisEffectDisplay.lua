import "Turbine.UI";
import "Turbine.UI.Lotro";
import "PengorosPlugins.BuffBars";

CombatAnalysisEffectDisplay = class(Turbine.UI.Control);

function CombatAnalysisEffectDisplay:Constructor()
    Turbine.UI.Control.Constructor(self);
end

function CombatAnalysisEffectDisplay:SetEffect(effect)
	self.effect = effect;
	
    self:SetSize(16, 16);
    self:SetBackground(effect:GetIcon());
    self:SetStretchMode(1);
end

function CombatAnalysisEffectDisplay:GetEffect()
	return self.effect;
end
