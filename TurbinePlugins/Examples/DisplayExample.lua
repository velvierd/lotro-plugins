
DisplayExample = class( Example );

function DisplayExample:GetName()
	return "Display";
end

function DisplayExample:Start()
	local width, height = Turbine.UI.Display.GetSize();
	Turbine.Shell.WriteLine( "The current screen resolution is " .. width .. "x" .. height .. "." );

	Example.Start( self );
	self:Stop();
end

-- Register an instance of this example.
RegisterExample( DisplayExample() );
