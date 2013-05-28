
CheckBoxExample = class( Example );

function CheckBoxExample:GetName()
	return "CheckBox";
end

function CheckBoxExample:IsRunning()
	return ( self.window ~= nil );
end

function CheckBoxExample:Start()
	-- Don't create multiple windows.
	if ( self.window ~= nil ) then
		return;
	end

	-- Create a test window to display a status icon.
	self.window = Turbine.UI.Lotro.Window();
	self.window:SetPosition( 200, 200 );
	self.window:SetSize( 400, 220 );
	self.window:SetText( "CheckBox Example" );
	self.window:SetVisible( true );

	self.window.Closed = function( sender, args )
		self:Stop();
	end

	-- Create a status icon and add it to the window.
	local checkbox = Turbine.UI.Lotro.CheckBox();
	checkbox:SetParent( self.window );
	checkbox:SetMultiline( true );
	checkbox:SetPosition( 20, 40 );
	checkbox:SetSize( 360, 140 );
	checkbox:SetBackColor( Turbine.UI.Color( 1, 0.2, 0.2, 0.5 ) );
	checkbox:SetTextAlignment( Turbine.UI.CheckBox.TopLeft );
	checkbox:SetText( "The quick brown fox jumps over the lazy dog." );

	local switchTextAlignmentButton = Turbine.UI.Lotro.Button();
	switchTextAlignmentButton:SetParent( self.window );
	switchTextAlignmentButton:SetPosition( 20, 185 );
	switchTextAlignmentButton:SetSize( 150, 20 );
	switchTextAlignmentButton:SetText( "Text Alignment" );

	switchTextAlignmentButton.Click = function( sender, args )
		-- Cycle through the content alignment on each click.
		checkbox:SetTextAlignment( ( checkbox:GetTextAlignment() % 9 ) + 1 );

		local oldWidth, oldHeight = checkbox:GetSize();
		checkbox:SetSize( 1, 1 );
		checkbox:SetSize( oldWidth, oldHeight );
	end

	local switchCheckAlignmentButton = Turbine.UI.Lotro.Button();
	switchCheckAlignmentButton:SetParent( self.window );
	switchCheckAlignmentButton:SetPosition( 180, 185 );
	switchCheckAlignmentButton:SetSize( 150, 20 );
	switchCheckAlignmentButton:SetText( "Check Alignment" );

	switchCheckAlignmentButton.Click = function( sender, args )
		-- Cycle through the content alignment on each click.
		checkbox:SetCheckAlignment( ( checkbox:GetCheckAlignment() % 9 ) + 1 );
	end
	
	Example.Start( self );
end

function CheckBoxExample:Stop()
	-- Free the window which will free its child controls.
	self.window = nil;

	Example.Stop( self );
end

-- Register an instance of this example.
RegisterExample( CheckBoxExample() );
