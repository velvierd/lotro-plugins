
import "TurbinePlugins.Examples.ExampleListItem";

ExamplesRunner = class( Turbine.UI.Lotro.Window );

function ExamplesRunner:Constructor()
	Turbine.UI.Lotro.Window.Constructor( self );

	self:SetText( "Examples Runner" );
	self:SetSize( 300, 350 );
	
	self.startButton = Turbine.UI.Lotro.GoldButton();
	self.startButton:SetParent( self );
	self.startButton:SetPosition( 20, 40 );
	self.startButton:SetSize( 75, 22 );
	self.startButton:SetText( "Start" );

	self.startButton.Click = function( sender, args )
		self.examplesList:GetItem( self.selectedIndex ):GetExample():Start();
	end

	self.stopButton  = Turbine.UI.Lotro.GoldButton();
	self.stopButton:SetParent( self );
	self.stopButton:SetPosition( 105, 40 );
	self.stopButton:SetSize( 75, 22 );
	self.stopButton:SetText( "Stop" );

	self.stopButton.Click = function( sender, args )
		self.examplesList:GetItem( self.selectedIndex ):GetExample():Stop();
	end

	self.exampleListVerticalScrollbar = Turbine.UI.Lotro.ScrollBar();
	self.exampleListVerticalScrollbar:SetOrientation( Turbine.UI.Orientation.Vertical );
	self.exampleListVerticalScrollbar:SetParent( self );

	self.examplesList = Turbine.UI.ListBox();
	self.examplesList:SetParent( self );
	self.examplesList:SetPosition( 20, 67 );
	self.examplesList:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0.2 ) );
	self.examplesList:SetVerticalScrollBar( self.exampleListVerticalScrollbar );

	for key, value in pairs( examples ) do
		local exampleListItem = ExampleListItem( value );
		self.examplesList:AddItem( exampleListItem );
	end

	self.selectedIndex = -1;

	self.examplesList.SelectedIndexChanged = function( sender, args )
		if ( self.selectedIndex ~= -1 ) then
			self.examplesList:GetItem( self.selectedIndex ):SetSelected( false );
		end

		self.selectedIndex = self.examplesList:GetSelectedIndex();

		if ( self.selectedIndex ~= -1 ) then
			self.examplesList:GetItem( self.selectedIndex ):SetSelected( true );
		end
	end
	
	self:Layout();
end

function ExamplesRunner:Layout()
	local width, height = self:GetSize();

	local listWidth = width - 48;
	local listHeight = height - 93;

	self.examplesList:SetSize( listWidth, listHeight );
	
	self.exampleListVerticalScrollbar:SetPosition( width - 25, 67 );
	self.exampleListVerticalScrollbar:SetSize( 10, listHeight );

	local i;

	for i = 1, self.examplesList:GetItemCount() do
		local exampleListItem = self.examplesList:GetItem( i );
		exampleListItem:SetSize( listWidth, 20 );
	end
end

function ExamplesRunner:SizeChanged()
	self:Layout();
end
