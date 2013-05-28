import "Turbine.Gameplay";

Pot = class();

function Pot:Constructor(name, category, duration, matches)
    self.name = name;
    self.category = category;
    self.duration = duration;
    self.matches = {};
    local i;
    for i = 1, table.getn(matches) do
        self.matches[matches[i]] = true;
    end
end

function Pot:GetName()
    return self.name;
end

function Pot:GetCategory()
    return self.category;
end

function Pot:GetDuration()
    return self.duration;
end

function Pot:GetStartTime()
    return self.startTime;
end

function Pot:GetEndTime()
    return self.startTime + self.duration;
end

function Pot:Reset()
    local gameTime = Turbine.Engine.GetGameTime();
    self.startTime = gameTime - self.duration;
end

function Pot:IsMatch(item)
    return self.matches[item];
end

function Pot:Start()
    self.startTime = Turbine.Engine.GetGameTime();
end