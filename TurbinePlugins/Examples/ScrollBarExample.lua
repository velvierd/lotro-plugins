
ScrollBarExample = class( Example );

function ScrollBarExample:GetName()
	return "ScrollBar";
end

function ScrollBarExample:IsRunning()
	return ( self.window ~= nil );
end

function ScrollBarExample:Start()
	-- Don't create multiple windows.
	if ( self.window ~= nil ) then
		return;
	end

	-- Create a test window to display a status icon.
	self.window = Turbine.UI.Lotro.Window();
	self.window:SetPosition( 100, 100 );
	self.window:SetSize( 300, 160 );
	self.window:SetText( "ScrollBar Example" );
	self.window:SetVisible( true );

	self.window.Closed = function( sender, args )
		self:Stop();
	end

	local color = Turbine.UI.Control();
	color:SetParent( self.window );
	color:SetPosition( 20, 40 );
	color:SetSize( 40, 40 );

	local redScrollBar = Turbine.UI.Lotro.ScrollBar();
	redScrollBar:SetParent( self.window );
	redScrollBar:SetPosition( 20, 90 );
	redScrollBar:SetSize( 240, 10 );
	redScrollBar:SetMinimum( 0 );
	redScrollBar:SetMaximum( 255 );
	redScrollBar:SetValue( 0 );

	local greenScrollBar = Turbine.UI.Lotro.ScrollBar();
	greenScrollBar:SetParent( self.window );
	greenScrollBar:SetPosition( 20, 110 );
	greenScrollBar:SetSize( 240, 10 );
	greenScrollBar:SetMinimum( 0 );
	greenScrollBar:SetMaximum( 255 );
	greenScrollBar:SetValue( 0 );

	local blueScrollBar = Turbine.UI.Lotro.ScrollBar();
	blueScrollBar:SetParent( self.window );
	blueScrollBar:SetPosition( 20, 130 );
	blueScrollBar:SetSize( 240, 10 );
	blueScrollBar:SetMinimum( 0 );
	blueScrollBar:SetMaximum( 255 );
	blueScrollBar:SetValue( 0 );

	self.UpdateColor = function( sender, args )
		color:SetBackColor( Turbine.UI.Color( 1, redScrollBar:GetValue() / 255, greenScrollBar:GetValue() / 255, blueScrollBar:GetValue() / 255 ) );
	end
	
	redScrollBar.ValueChanged = self.UpdateColor;
	greenScrollBar.ValueChanged = self.UpdateColor;
	blueScrollBar.ValueChanged = self.UpdateColor;

	local opacityScrollBar = Turbine.UI.Lotro.ScrollBar();
	opacityScrollBar:SetParent( self.window );
	opacityScrollBar:SetPosition( 270, 40 );
	opacityScrollBar:SetSize( 10, 100 );
	opacityScrollBar:SetMinimum( 0 );
	opacityScrollBar:SetMaximum( 200 );
	opacityScrollBar:SetValue( 0 );
	opacityScrollBar:SetOrientation( Turbine.UI.Orientation.Vertical );

	opacityScrollBar.ValueChanged = function( sender, args )
		self.window:SetOpacity( ( 55 + ( 200 - opacityScrollBar:GetValue() ) ) / 255 );
	end

	Example.Start( self );
end

function ScrollBarExample:Stop()
	-- Free the window which will free its child controls.
	self.window = nil;

	Example.Stop( self );
end

-- Register an instance of this example.
RegisterExample( ScrollBarExample() );
