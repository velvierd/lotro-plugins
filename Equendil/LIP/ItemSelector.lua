-- ItemSelector: Presents the user with a choice of legendary items available to a given class
-- 310x100

import "Turbine.UI";

import "Equendil.UI.Resources";
import "Equendil.UI.IconButton";
import "Equendil.UI.LotroIcon";
import "Equendil.UI.CommonControls";

-- Event: Selected(n) where n is the nth legendary item of a given class in Equendil.LIP.ClassesInfo
ItemSelector = class( Turbine.UI.Control );
function ItemSelector:Constructor()
	Turbine.UI.Control.Constructor( self );
	
	self:SetSize( 310, 100 );
	
	self.buttons = {};
	
	self.Selected = Equendil.Utils.Event(); -- event
	self.classIndex = 0;
	
	-- invite an action
	self.label = Equendil.UI.CommonControl.LabelFieldHeading();
	self.label:SetParent( self );
	self.label:SetSize( 80, 32 );
	self.label:SetFont( Turbine.UI.Lotro.Font.TrajanPro18 );
	self.label:SetText( L["Pick type:"] );
	
	-- create icons that'll display legendary item types on a neutral background
	for i = 1, 6 do
		self.buttons[i] = Equendil.UI.LotroIcon();
		self.buttons[i]:SetParent( self );
		self.buttons[i]:SetBackdrop( Equendil.UI.Icon.GreyBackground );
		self.buttons[i]:SetSize( 32, 32 );
		self.buttons[i]:SetLeft( ( ( i - 1 ) * 40 ) + 80 );
		
		-- contextual 'help'
		self.buttons[i].Hovering = function( flag )
			if flag and self.classIndex ~= 0 and Equendil.LIP.ClassesInfo[self.classIndex].legendaryItems[i] ~= nil then
				self.labelLI:SetText( Equendil.LIP.ClassesInfo[self.classIndex].legendaryItems[i].name );
			else
				self.labelLI:SetText( "" );
			end
		end
		
		-- Legendary item selected
		self.buttons[i].Clicked = function( sender, args ) 
			self.Selected( i ); -- dispatch event
		end
			
		-- label for contextual 'help'
		self.labelLI = Turbine.UI.Label();
		self.labelLI:SetParent( self );
--		self.labelLI:SetSize( 100, 32 );
		self.labelLI:SetSize( 230, 32 );
--		self.labelLI:SetPosition( 210, 0 );
		self.labelLI:SetPosition( 80, 40 );
		self.labelLI:SetFont( Turbine.UI.Lotro.Font.TrajanPro14 );
		self.labelLI:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
		self.labelLI:SetForeColor( Equendil.UI.Color.TurbineWhite );
		self.labelLI:SetMouseVisible( false );
		self.labelLI:SetText( "" );
	end
end

-- Set which class the control is working on, classIndex is an index in Equendil.LIP.ClassesInfo
function ItemSelector:Set( classIndex )
	self.classIndex = classIndex;
	
	-- make all icons invisible first
	for i = 1, 6 do	
		self.buttons[i]:SetVisible( false ); 
	end
	
	-- setup icon for each available legendary item, may not be all six of them
	for k, v in ipairs( Equendil.LIP.ClassesInfo[classIndex].iconLegKeys ) do
		self.buttons[k].shadow:SetBackground( Equendil.LIP.Icon.LIShadow[v][2] );
		self.buttons[k].icon:SetBackground( Equendil.LIP.Icon.LI[v][2] );
		self.buttons[k]:SetVisible( true );
	end
end