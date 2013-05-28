import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

EffectTrigger = class();

function EffectTrigger:Constructor(values)
    self.name = values.name; -- the name of the trigger
	self.type = values.type; -- the type of trigger (buff/debuff/pot)
	self.template = values.template; -- is there a template
	self.blacklist = values.blacklist; -- should this effect be ignored if it matches
    
    -- effect values
    self.category = values.category; -- effect category, can be nil for all
    self.curable = values.curable; -- is the effect curable
    self.match = values.match; -- name match string
	self.target = values.target; -- target match string
	self.minDuration = values.minDuration; -- 0 for disabled
	self.maxDuration = values.maxDuration; -- 0 for disabled
    if (self.match == "") then
        self.match = nil;
    end
-- PulseDiver
--    if (self.match ~= nil) then
--    	self.match = self.match:lower(); -- store patterns in lowercase
--    end
    if (self.target == "") then
        self.target = nil;
    end
    if (self.target ~= nil) then
    	self.target = self.target:lower(); -- store patterns in lowercase
    end
end

function EffectTrigger:GetName()
	if (self.blacklist) then
		return self.name .. L[" (blacklist)"];
	end
	return self.name;
end

function EffectTrigger:MatchesEffect(effect, target)
	local debuff = effect:IsDebuff();
	local caEffect = effect.GetType ~= nil and effect:GetType():GetName() == "CombatAnalysisEffect";
	
	if (self.type == EffectTriggerType.MobDebuff and (not debuff or not caEffect)) then
		return false;
	elseif (self.type == EffectTriggerType.MobCrowdControl and (debuff or not caEffect)) then
		return false;
    elseif (self.type == EffectTriggerType.Debuff and (not debuff or caEffect)) then
        return false;
    elseif (self.type == EffectTriggerType.Buff and (debuff or caEffect)) then
        return false;
    elseif (self.category ~= nil and self.category ~= effect:GetCategory()) then
        return false;
    elseif (self.curable ~= nil and (self.curable and debuff and (not effect:IsCurable()))) then
        return false;
		
--	  PulseDiver
--	elseif (self.match ~= nil and string.match(effect:GetName():lower(), self.match) == nil) then
	elseif (self.match ~= nil and string.match(string.lower(effect:GetName()), string.lower(self.match)) == nil) then
        return false;
   elseif (self.target ~= nil and string.find(target:GetName():lower(), self.target == Target.Me and PengorosPlugins.Utils.PlayerManager.GetPlayer():GetName():lower() or self.target, 1, true) == nil) then		
--    elseif (self.target ~= nil and string.find(string.lower(target:GetName()), self.target == Target.Me and PengorosPlugins.Utils.PlayerManager.GetPlayer():GetName() or self.target, 1, true) == nil) then
        return false;
    elseif (self.minDuration ~= 0 and effect:GetDuration() < self.minDuration) then
    	return false;
    elseif (self.maxDuration ~= 0 and effect:GetDuration() > self.maxDuration) then
    	return false;
    end
    
	-- it is a match if we get here
    return true;
end

function EffectTrigger:MatchesPot(pot)
	if (self.category ~= nil and self.category ~= pot:GetCategory()) then
		return false;
	end;
	
	return true;
end