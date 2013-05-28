import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

EffectSettings = class();

function EffectSettings:Constructor(saved)
    if (saved ~= nil) then
        for i,v in pairs(saved) do
            if (i == "triggers") then
                self.triggers = {};
                local size = table.getn(v);
                for i = 1, size do
                    self.triggers[i] = EffectTrigger(v[i]);
                end
            else
                self[i] = v;
            end
        end
    else
        self:SetDefaults();
    end
end

function EffectSettings:Copy()
    return PengorosPlugins.Utils.DeepCopy(self);
end

function EffectSettings:SetDefaults()
    -- effect bars
    self.enabled = true;
    self.name = "BuffBars";
    self.posX = 10;
    self.posY = 200;
    self.barHeight = 24;
    self.barWidth = 200;
    self.scope = WindowScope.Character;
    
	-- triggers
    self.triggers = {
    	EffectTrigger({name=L["All Debuffs"], template=EffectTriggerTemplate.AllDebuffs, type=EffectTriggerType.Debuff, blacklist=false, category=nil, curable=false, match=nil, target=Target.Me, minDuration=0, maxDuration=0}),
    	EffectTrigger({name=L["All Buffs"], template=EffectTriggerTemplate.AllBuffs, type=EffectTriggerType.Buff, blacklist=false, category=nil, curable=false, match=nil, target=Target.Me, minDuration=0, maxDuration=0}),
    	EffectTrigger({name=L["All Cool Downs"], template=EffectTriggerTemplate.AllCoolDowns, type=EffectTriggerType.CoolDown, blacklist=false, category=nil}),
    	EffectTrigger({name=L["All Mob Debuffs"], template=EffectTriggerTemplate.AllMobDebuffs, type=EffectTriggerType.MobDebuff, blacklist=false, category=nil, curable=false, match=nil, target=nil, minDuration=0, maxDuration=0}),
    	EffectTrigger({name=L["All Mob CC"], template=EffectTriggerTemplate.AllMobCrowdControl, type=EffectTriggerType.MobCrowdControl, blacklist=false, category=nil, curable=false, match=nil, target=nil, minDuration=0, maxDuration=0})
    };
end

function EffectSettings:GetColor(color)
    return Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255);
end

function EffectSettings:BlacklistEffect(effect)
	local effectType;
	if (effect.GetType ~= nil and effect:GetType():GetName() == "CombatAnalysisEffect") then
		if (effect:IsDebuff()) then
			effectType = EffectTriggerType.MobDebuff;
		else
			effectType = EffectTriggerType.MobCrowdControl;
		end
	elseif (effect:IsDebuff()) then
		effectType = EffectTriggerType.Debuff;
	else
		effectType = EffectTriggerType.Buff;
	end
	
	local trigger = EffectTrigger({name=effect:GetName(), template=EffectTriggerTemplate.Custom, type=effectType, blacklist=true, category=effect:GetCategory(), curable=false, match=PengorosPlugins.Utils.EscapeMatch(effect:GetName()), minDuration=0, maxDuration=0});
	table.insert(self.triggers, 1, trigger);
	return trigger;
end

function EffectSettings:AddEffect(effect)
	local effectType;
	if (effect.GetType ~= nil and effect:GetType():GetName() == "CombatAnalysisEffect") then
		if (effect:IsDebuff()) then
			effectType = EffectTriggerType.MobDebuff;
		else
			effectType = EffectTriggerType.MobCrowdControl;
		end
	elseif (effect:IsDebuff()) then
		effectType = EffectTriggerType.Debuff;
	else
		effectType = EffectTriggerType.Buff;
	end
	
	local trigger = EffectTrigger({name=effect:GetName(), template=EffectTriggerTemplate.Custom, type=effectType, blacklist=false, category=effect:GetCategory(), curable=false, match=PengorosPlugins.Utils.EscapeMatch(effect:GetName()), minDuration=0, maxDuration=0});
	table.insert(self.triggers, 1, trigger);
	return trigger;
end

function EffectSettings:BlacklistPot(pot)
	local catName = "";
	local cat = pot:GetCategory();
	if (cat == PengorosPlugins.Utils.CoolDownCategory.Morale) then
	    catName = L["Morale Pots"];
	elseif (cat == PengorosPlugins.Utils.CoolDownCategory.Power) then
	    catName = L["Power Pots"];
	elseif (cat == PengorosPlugins.Utils.CoolDownCategory.Disease) then
	    catName = L["Disease Pots"];
	elseif (cat == PengorosPlugins.Utils.CoolDownCategory.Fear) then
	    catName = L["Fear Pots"];
	elseif (cat == PengorosPlugins.Utils.CoolDownCategory.Poison) then
	    catName = L["Poison"];
	elseif (cat == PengorosPlugins.Utils.CoolDownCategory.Wound) then
	    catName = L["Wound Pots"];
	end

	local trigger = EffectTrigger({name=catName, template=EffectTriggerTemplate.Custom, type=EffectTriggerType.CoolDown, blacklist=true, category=cat});
	table.insert(self.triggers, 1, trigger);
	return trigger;
end