
ButtonExample = class( Example );

function ButtonExample:GetName()
	return "Button";
end

function ButtonExample:IsRunning()
	return ( self.window ~= nil );
end

function ButtonExample:Start()
	-- Don't create multiple windows.
	if ( self.window ~= nil ) then
		return;
	end

	-- Create a test window to display a status icon.
	self.window = Turbine.UI.Lotro.Window();
	self.window:SetPosition( 100, 100 );
	self.window:SetSize( 300, 160 );
	self.window:SetText( "Button Example" );
	self.window:SetVisible( true );

	self.window.Closed = function( sender, args )
		self:Stop();
	end

	self.clickCount = 0;

	-- Create a status icon and add it to the window.
	local button = Turbine.UI.Lotro.Button();
	button:SetParent( self.window );
	button:SetText( "Click me!" );
	button:SetPosition( 20, 40 );
	button:SetSize( 150, 20 );

	button.Click = function( sender, args )
		self.clickCount = self.clickCount + 1;
		Turbine.Shell.WriteLine( "You've clicked my button " .. self.clickCount .. " time(s)." );
	end

	-- Create a status icon and add it to the window.
	local disabledButton = Turbine.UI.Lotro.Button();
	disabledButton:SetParent( self.window );
	disabledButton:SetEnabled( false );
	disabledButton:SetText( "You can't click me!" );
	disabledButton:SetPosition( 20, 80 );
	disabledButton:SetSize( 150, 20 );

	Example.Start( self );
end

function ButtonExample:Stop()
	-- Free the window which will free its child controls.
	self.window = nil;

	Example.Stop( self );
end

-- Register an instance of this example.
RegisterExample( ButtonExample() );
