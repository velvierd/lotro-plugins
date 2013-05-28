
LabelExample = class( Example );

function LabelExample:GetName()
	return "Label";
end

function LabelExample:IsRunning()
	return ( self.window ~= nil );
end

function LabelExample:Start()
	-- Don't create multiple windows.
	if ( self.window ~= nil ) then
		return;
	end

	-- Create a test window to display a status icon.
	self.window = Turbine.UI.Lotro.Window();
	self.window:SetPosition( 100, 100 );
	self.window:SetSize( 300, 160 );
	self.window:SetText( "Label Example" );
	self.window:SetVisible( true );

	self.window.Closed = function( sender, args )
		self:Stop();
	end

	-- Create a status icon and add it to the window.
	local label = Turbine.UI.Label();
	label:SetParent( self.window );
	label:SetText( "This is a label!" );
	label:SetPosition( 20, 40 );
	label:SetSize(260, 100 );
	label:SetBackColor( Turbine.UI.Color( 1, 0.2, 0.2, 0.2 ) );
	label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	
	label.MouseClick = function( sender, args )
		label:SetBackColor( Turbine.UI.Color( 1, math.random(), math.random(), math.random() ) );
	end

	Example.Start( self );
end

function LabelExample:Stop()
	-- Free the window which will free its child controls.
	self.window = nil;

	Example.Stop( self );
end

-- Register an instance of this example.
RegisterExample( LabelExample() );
