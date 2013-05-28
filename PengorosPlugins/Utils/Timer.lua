import "Turbine.UI";

Timer = class(Turbine.UI.Control);

function Timer:Constructor(time)
    Turbine.UI.Control.Constructor(self);
    self:SetVisible(false);
    self.time = time;
end

function Timer:Update()
    local gameTime = Turbine.Engine.GetGameTime();
    local elapsed = gameTime - self.start;
    if (elapsed > self.time) then
        self:Stop();
        if (type(self.Signal) == "function") then
            self:Signal({});
        end
    end
end

function Timer:Start()
    self.start = Turbine.Engine.GetGameTime();
    self:SetWantsUpdates(true);
end

function Timer:Stop()
    self:SetWantsUpdates(false);
end
