import "Turbine.UI";

import "Equendil.Utils";

-- An icon button that mimics Turbine's own icons (background + shadow + icon + highlight)
LotroIcon = class( Turbine.UI.Control );
function LotroIcon:Constructor()
	Turbine.UI.Control.Constructor( self );
	
	self.Clicked = Equendil.Utils.Event();
	self.Hovering = Equendil.Utils.Event(); -- Hovering( true/false)
	
	self.highlightable = false;
	
	self:SetSize( 32, 32 );
	self:SetBlendMode( Turbine.UI.BlendMode.Normal );

	local newControl = function() 
		local control = Turbine.UI.Control();
		control:SetParent( self );
		control:SetSize( 32, 32 );
		control:SetMouseVisible( false );
		control:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		return control;
	end
	
	self.shadow = newControl();
	
	self.icon = newControl();
	
	self.highlight = newControl();
	self.highlight:SetVisible( false );
	self.highlight:SetBackground( Equendil.UI.Icon.Highlight2 );
		
	self:SetMouseVisible( true );
	
	self.MouseLeave = function( sender, args ) 
		self.highlight:SetVisible( false ); 
		self.Hovering( false );
	end
	self.MouseUp = function( sender, args ) self.Clicked( args.Button ); end
	self.MouseEnter = function( sender, args ) 
		if self.highlightable then
			self.highlight:SetVisible( true );
		end
		self.Hovering( true );
	end
end

-- Set the background of the icon (SetBackground() already exists hence SetBackdrop(), no idea how to call the control's setbackground() method otherwise)
function LotroIcon:SetBackdrop( resource )
	self:SetBackground( resource );
end

-- Set the shadow and actual icon 
function LotroIcon:Set( shadow, icon )
	self.shadow:SetBackground( shadow );
	self.icon:SetBackground( icon );
end

-- Specify whether the icon can be highlighted
function LotroIcon:SetHighlightable( flag )
	self.highlightable = flag;
end