import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

QuickslotSettings = class();

function QuickslotSettings:Constructor(saved)
    if (saved ~= nil) then
        for i,v in pairs(saved) do
            if (i == "triggers") then
                self.triggers = {};
                local size = table.getn(v);
                for i = 1, size do
                    self.triggers[i] = Trigger(v[i]);
                end
            else
                self[i] = v;
            end
        end
    else
        self:SetDefaults();
    end
end

function QuickslotSettings:Copy()
    return PengorosPlugins.Utils.DeepCopy(self);
end

function QuickslotSettings:SetDefaults()
    local displayWidth = Turbine.UI.Display:GetWidth();
    local displayHeight = Turbine.UI.Display:GetHeight();
    
    self.enabled = true;
    self.name = "Quickslots";
    self.scope = WindowScope.Character;
    self.visibleType = WindowVisibility.Always; -- v4
    self.quickslotSize = 36;
    self.quickslotSpacing = 5;
    self.qsX = displayWidth / 2;
    self.qsY = ((displayHeight - 300) / 2) + 300;
    
    -- triggers
    self.triggers = {
        Trigger({name=L["Disease"], template=TriggerTemplate.Disease, triggerType=TriggerType.Effect, category=Turbine.Gameplay.EffectCategory.Disease, hasEffect=true, isCurable=true}),
        Trigger({name=L["Fear"], template=TriggerTemplate.Fear, triggerType=TriggerType.Effect, category=Turbine.Gameplay.EffectCategory.Fear, hasEffect=true, isCurable=true}),
        Trigger({name=L["Poison"], template=TriggerTemplate.Poison, triggerType=TriggerType.Effect, category=Turbine.Gameplay.EffectCategory.Poison, hasEffect=true, isCurable=true}),
        Trigger({name=L["Wound"], template=TriggerTemplate.Wound, triggerType=TriggerType.Effect, category=Turbine.Gameplay.EffectCategory.Wound, hasEffect=true, isCurable=true}),
        Trigger({name=L["Morale"], template=TriggerTemplate.Morale, triggerType=TriggerType.Level, level=TriggerLevel.Morale, threshold=0.3}),
        Trigger({name=L["Power"], template=TriggerTemplate.Power, triggerType=TriggerType.Level, level=TriggerLevel.Power, threshold=0.3}),
    }; -- v6
end
