
BlendModeExample = class( Example );

function BlendModeExample:GetName()
	return "BlendMode";
end

function BlendModeExample:IsRunning()
	return ( self.window ~= nil );
end

function BlendModeExample:Start()
	-- Don't create multiple windows.
	if ( self.window ~= nil ) then
		return;
	end

	-- Create a test window to display a status icon.
	self.window = Turbine.UI.Lotro.Window();
	self.window:SetPosition( 100, 100 );
	self.window:SetSize( 440, 500 );
	self.window:SetVisible( true );
	self.window:SetText( "BlendMode Example" );

	self.window.Closed = function( sender, args )
		self:Stop();
	end

	self.color = Turbine.UI.Color( 1, 1, 0, 0 );

	local alphaScrollBar = Turbine.UI.Lotro.ScrollBar();
	alphaScrollBar:SetParent( self.window );
	alphaScrollBar:SetPosition( 150, 45 );
	alphaScrollBar:SetSize( 270, 10 );
	alphaScrollBar:SetMinimum( 0 );
	alphaScrollBar:SetMaximum( 255 );
	alphaScrollBar:SetValue( 255 );

	alphaScrollBar.ValueChanged = function( sender, args )
		self.color.A = alphaScrollBar:GetValue() / 255;
		self:Recolor();
	end

	local changeColorButton = Turbine.UI.Lotro.Button();
	changeColorButton:SetParent( self.window );
	changeColorButton:SetPosition( 20, 40 );
	changeColorButton:SetSize( 120, 20 );
	changeColorButton:SetText( "Random Color" );

	changeColorButton.Click = function( sender, args )
		self.color.R = math.random();
		self.color.G = math.random();
		self.color.B = math.random();
		self:Recolor();
	end

	local background = Turbine.UI.Control();
	background:SetParent( self.window );
	background:SetBackground( "TurbinePlugins/Examples/Resources/Clouds.tga" );
	background:SetPosition( 20, 70 );
	background:SetZOrder( 10 );
	background:SetSize( 400, 400 );

	local i;

	-- Display the permutations of blend modes and back color
	-- blend modes.
	for i = 0, 63 do
		local row = math.floor( i / 8 );
		local x = 25 + i * 50 - ( row * 8 * 50 );
		local y = 75 + row * 50 ;
		local blendMode = i % 8;
		local backColorBlendMode = row;

		local icon = Turbine.UI.Control();
		icon:SetParent( self.window );
		icon:SetBackground( "TurbinePlugins/Examples/Resources/StatusIcon2.tga" );
		icon:SetPosition( x, y );
		icon:SetZOrder( 20 );
		icon:SetSize( 40, 40 );
		icon:SetBackColor( self.color );
		icon:SetBlendMode( blendMode );
		icon:SetBackColorBlendMode( backColorBlendMode );
		icon.colorize = true;
	end

	Example.Start( self );
end

function BlendModeExample:Recolor()
	local i;
	local controls = self.window:GetControls();

	for i = 1, controls:GetCount() do
		local control = controls:Get( i );
		
		if ( control.colorize ~= nil ) then
			control:SetBackColor( self.color );
		end
	end
end

function BlendModeExample:Stop()
	-- Free the window which will free its child controls.
	self.window = nil;

	Example.Stop( self );
end

-- Register an instance of this example.
RegisterExample( BlendModeExample() );
