
ContentAlignmentExample = class( Example );

function ContentAlignmentExample:GetName()
	return "ContentAlignment";
end

function ContentAlignmentExample:IsRunning()
	return ( self.window ~= nil );
end

function ContentAlignmentExample:Start()
	-- Don't create multiple windows.
	if ( self.window ~= nil ) then
		return;
	end

	-- Create a test window to display a status icon.
	self.window = Turbine.UI.Lotro.Window();
	self.window:SetPosition( 200, 200 );
	self.window:SetSize( 400, 220 );
	self.window:SetText( "Content Alignment Example" );
	self.window:SetVisible( true );

	self.window.Closed = function( sender, args )
		self:Stop();
	end

	-- Create a status icon and add it to the window.
	local textbox = Turbine.UI.Lotro.TextBox();
	textbox:SetParent( self.window );
	textbox:SetMultiline( true );
	textbox:SetPosition( 20, 40 );
	textbox:SetSize( 360, 140 );
	textbox:SetBackColor( Turbine.UI.Color( 1, 0.2, 0.2, 0.5 ) );
	textbox:SetTextAlignment( Turbine.UI.ContentAlignment.TopLeft );
	textbox:SetText( "The quick brown fox jumps over the lazy dog." );

	local switchAlignmentButton = Turbine.UI.Lotro.Button();
	switchAlignmentButton:SetParent( self.window );
	switchAlignmentButton:SetPosition( 70, 185 );
	switchAlignmentButton:SetSize( 300, 20 );
	switchAlignmentButton:SetText( "Change Alignment" );

	switchAlignmentButton.Click = function( sender, args )
		-- Cycle through the content alignment on each click.
		textbox:SetTextAlignment( ( textbox:GetTextAlignment() % 9 ) + 1 );
	end

	Example.Start( self );
end

function ContentAlignmentExample:Stop()
	-- Free the window which will free its child controls.
	self.window = nil;

	Example.Stop( self );
end

-- Register an instance of this example.
RegisterExample( ContentAlignmentExample() );
