import "Turbine.UI";

FrameTimer = class(Turbine.UI.Control);

function FrameTimer:Constructor(frames)
    Turbine.UI.Control.Constructor(self);
    self:SetVisible(false);
    self.frames = frames;
    self.count = 0;
end

function FrameTimer:Update()
	-- signal listeners
	if (type(self.Signal) == "function") then
	    self:Signal({frame=self.count});
	end

	-- increment counter
	self.count = (self.count + 1) % self.frames;
end

function FrameTimer:Start()
	self.count = 0;
    self:SetWantsUpdates(true);
end

function FrameTimer:Stop()
    self:SetWantsUpdates(false);
end
