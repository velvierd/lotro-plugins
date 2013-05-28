import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

LogSettings = class();

function LogSettings:Constructor(saved)
    if (saved ~= nil) then
        for i,v in pairs(saved) do
            self[i] = v;
        end
    else
        self:SetDefaults();
    end
end

function LogSettings:Copy()
    return PengorosPlugins.Utils.DeepCopy(self);
end

function LogSettings:SetDefaults()
    self.enabled = false;
    
    -- items to log
    self.logId = true;
	self.logTarget = true;
    self.logName = true;
    self.logDescription = true;
    self.logCategory = true;
    self.logDuration = true;
    self.logCurable = true;
    self.logDebuff = true;
    self.logTime = true;
    
    -- minimal filters
    self.showBuffs = true;
    self.showDebuffs = true;
    self.showMobDebuffs = true;
    self.showMobCC = true;
end
