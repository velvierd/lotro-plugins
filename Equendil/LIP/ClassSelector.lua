--[[
ClassSelector : Presents a series of class icons for selection. Horizontal layout
Size: 600x69
 	
 Defaults to the first class on creation
--]]

-- classList is a table, required field: 'icon' which is the id of a 48x48 resource to display
-- Event: ClassSelected( n ) where n is an index in classList. Fired on selection of a class.
ClassSelector = class( Turbine.UI.Control );
function ClassSelector:Constructor( classList )
	Turbine.UI.Control.Constructor( self );
	
	self.ClassSelected = Equendil.Utils.Event();
	
	self:SetSize( 600, 69 );
	self:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	
	-- borders around the control
	self.borders = Equendil.UI.DecoratedContainer( Equendil.UI.Decoration.RoundSilver );
	self.borders:SetParent( self );
	self.borders:SetSize( 600, 69 );
	
	-- class buttons 
	self.buttonClass = {};
	for i, v in ipairs( classList ) do
		local button = Turbine.UI.Control();
		button:SetParent( self );
		button:SetPosition( 25 + (i-1) * ( 48 + 15 ), 10 );
		button:SetSize( 48, 48 );
		button:SetBackground( v.icon );
		button:SetBlendMode( Turbine.UI.BlendMode.Overlay );
		button:SetBackColorBlendMode( Turbine.UI.BlendMode.Color );
		
		-- setup callbacks for visual feedback and actual selection
		button.MouseEnter = function( sender, args ) button:SetBackColor( Turbine.UI.Color( 0.4,1,1,1 ) ) end
		button.MouseLeave = function( sender, args ) button:SetBackColor( Turbine.UI.Color( 0, 1, 1, 1 ) ) end
		button.MouseDown = function( sender, args )	button:SetBackColor( Turbine.UI.Color( 1, 1, 1, 1 ) ) end
		button.MouseUp = function( sender, args ) self:Select( i ); end
		
		self.buttonClass[i] = button;
	end
	
	-- "cursor" highlighting the current selected class
	self.cursor = Turbine.UI.Control();
	self.cursor:SetParent( self );
	self.cursor:SetSize( 71, 69 );
	self.cursor:SetBackground( 0x41007EBE ); -- portrait outline used here, does the trick well enough
	self.cursor:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	-- self.cursor:SetOpacity( 0.5 );
	
	self:Select(1);
end

-- selects a class, where "index" is the index of the class selected
function ClassSelector:Select( index )
	self.cursor:SetLeft( 26 + ( (index - 1) * ( 48 + 15 ) ) - ( (71-48 )  / 2 ) );
	self.ClassSelected( index );
end