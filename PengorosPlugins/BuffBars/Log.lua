import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

Log = class();

function Log:Constructor(settings)
    self.settings = settings;

    -- add listeners
    PengorosPlugins.Utils.EffectManager.AddListener(self);
end

function Log:Destroy()
    PengorosPlugins.Utils.EffectManager.RemoveListener(self);
end

function Log:EffectAdded(effect, target)
	local debuff = effect:IsDebuff();
	local caEffect = effect.GetType ~= nil and effect:GetType():GetName() == "CombatAnalysisEffect";
	if (caEffect) then
		if (debuff and not self.settings.showMobDebuffs) then
			return;
		elseif (not debuff and not self.settings.showMobCC) then
			return;
		end
	else
		if (debuff and not self.settings.showDebuffs) then
			return;
		elseif (not debuff and not self.settings.showBuffs) then
			return;
		end
	end

    local log = L["Effect Added: "];
    log = log .. self:FormatEffect(effect, target, false);
    Turbine.Shell.WriteLine(log);
    
    --[[
    <rgb=#FF0000>Red Text</rgb>
    <rgb=#00FF00>Green Text</rgb>
    <rgb=#0000FF>Blue Text</rgb>
    --]]
end

function Log:EffectRemoved(effect, target)
	local debuff = effect:IsDebuff();
	local caEffect = effect.GetType ~= nil and effect:GetType():GetName() == "CombatAnalysisEffect";
	if (caEffect) then
		if (debuff and not self.settings.showMobDebuffs) then
			return;
		elseif (not debuff and not self.settings.showMobCC) then
			return;
		end
	else
		if (debuff and not self.settings.showDebuffs) then
			return;
		elseif (not debuff and not self.settings.showBuffs) then
			return;
		end
	end
    
    local log = L["Effect Removed: "];
    log = log .. self:FormatEffect(effect, target, true);
    Turbine.Shell.WriteLine(log);
end

function Log:FormatEffect(effect, target, removed)
    local log = "";
    if (self.settings.logId) then
        log = ("%s, %s=%s"):format(log, L["id"], effect:GetID());
    end
    if (self.settings.logTarget) then
        log = ("%s, %s=%s"):format(log, L["target"], (target ~= nil and target:GetName() or effect:GetTargetName()));
    end
    if (self.settings.logName) then
        log = ("%s, %s=%s"):format(log, L["name"], effect:GetName());
    end
    if (self.settings.logDescription) then
        local desc = effect:GetDescription();
        if (desc == nil or string.len(desc) == 0) then
            desc = L["None"];
        end
        log = ("%s, %s=%s"):format(log, L["description"], desc);
    end
    if (self.settings.logCategory) then
        local category = effect:GetCategory();
        local catName = L["Unknown"];
        
        if (category == Turbine.Gameplay.EffectCategory.Corruption) then
            catName = L["Corruption"];
        elseif (category == Turbine.Gameplay.EffectCategory.Cry) then
            catName = L["Cry"];
        elseif (category == Turbine.Gameplay.EffectCategory.Disease) then
            catName = L["Disease"];
        elseif (category == Turbine.Gameplay.EffectCategory.Elemental) then
            catName = L["Elemental"];
        elseif (category == Turbine.Gameplay.EffectCategory.Fear) then
            catName = L["Fear"];
        elseif (category == Turbine.Gameplay.EffectCategory.Physical) then
            catName = L["Physical"];
        elseif (category == Turbine.Gameplay.EffectCategory.Poison) then
            catName = L["Poison"];
        elseif (category == Turbine.Gameplay.EffectCategory.Song) then
            catName = L["Song"];
        elseif (category == Turbine.Gameplay.EffectCategory.Wound) then
            catName = L["Wound"];
        elseif (category == Turbine.Gameplay.EffectCategory.Undefined) then
            catName = L["Undefined"];
        elseif (category == -2) then
            catName = L["Mob Debuff"];
        elseif (category == -4) then
            catName = L["Mob CC"];
        end
        
        log = ("%s, %s=%s(%d)"):format(log, L["category"], catName, category);
    end
    if (self.settings.logDuration) then
        local duration = effect:GetDuration();
        if (removed) then
            local gameTime = Turbine.Engine.GetGameTime();
            duration = math.ceil(gameTime - effect:GetStartTime());
        end
        log = ("%s, %s=%s"):format(log, L["duration"], PengorosPlugins.Utils.TimeFormat.CLOCK(duration));
    end
    if (self.settings.logCurable) then
        log = ("%s, %s=%s"):format(log, L["curable"], tostring(effect:IsCurable()));
    end
    if (self.settings.logDebuff) then
        log = ("%s, %s=%s"):format(log, L["debuff"], tostring(effect:IsDebuff()));
    end
    if (self.settings.logTime) then
	    log = ("%s, %s=%s"):format(log, L["time"], Turbine.Engine.GetGameTime());
	end
    
    if (string.len(log) > 0) then
        log = string.sub(log, 3);
    end
    
    return log;
end
