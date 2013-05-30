import "Turbine.UI";

-- A basic custom three states button (normal, highlighted on mouse over, depressed when clicked)
IconButton = class( Turbine.UI.Control );
function IconButton:Constructor( icons, width, height ) -- Icons: table of 3 elements, normal icon, highlighted icon, depressed icon
	Turbine.UI.Control.Constructor( self );	

	-- click event
	self.Clicked = Equendil.Utils.Event(); -- Clicked(button) where 'button' is one of Turbine.UI.MouseButton values
	self.Hovering = Equendil.Utils.Event(); -- Hovering( flag ) is called whenever the point enters (true) or leaves (false) the button

	self.isPointerInside = false;
	
	self:SetSize( width, height );
	self:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self:SetBackground( icons[1] );
	
	self.MouseEnter = function( sender, args ) 
		self:SetBackground( icons[2] );
		self.isPointerInside = true;
		self.Hovering( true );
	end;
	
	self.MouseLeave = function( sender, args ) 
		self:SetBackground( icons[1] ) 
		self.isPointerInside = false;
		self.Hovering( false );
	end;
	
	self.MouseDown = function( sender, args ) 
		self:SetBackground( icons[3] ) 
	end;
	
	self.MouseUp = function( sender, args ) 
		self:SetBackground( icons[2] ) 
		if self.isPointerInside then
			self.Clicked( args.Button );
		end
	end
end

-- Preset buttons
function ButtonArrowLeft16() return IconButton( Equendil.UI.Icon.ArrowLeftSmall, 16, 16 ); end
function ButtonArrowRight16() return IconButton( Equendil.UI.Icon.ArrowRightSmall, 16, 16 ); end
function ButtonArrowLeft25() return IconButton( Equendil.UI.Icon.ArrowLeftBig, 25, 25 ); end
function ButtonArrowRight25() return IconButton( Equendil.UI.Icon.ArrowRightBig, 25, 25 ); end
function ButtonArrowUp20() return IconButton( Equendil.UI.Icon.ArrowUp, 20, 20 ); end
function ButtonArrowDown20() return IconButton( Equendil.UI.Icon.ArrowDown, 20, 20 ); end
function ButtonFastForward16() return IconButton( Equendil.UI.Icon.FastForwardSmall, 16, 16 ); end
function ButtonCloseRed() return IconButton( Equendil.UI.Icon.CloseRed, 16, 16 ); end

