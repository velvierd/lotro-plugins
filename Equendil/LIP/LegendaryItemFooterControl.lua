-- LegendaryItemFooterControl. Displays points spent and points available on a legendary item
-- Size: 300, 23 

import "Equendil.UI.DecoratedContainer";

LegendaryItemFooterControl = class( Turbine.UI.Control );
function LegendaryItemFooterControl:Constructor()
	Turbine.UI.Control.Constructor( self );

	self.legendaryItem = nil;
	
	self:SetSize( 350, 23 );
	
	-- box around the control
	local decoration = { topLeft = 0x41110D90, top = 0x41110D92, topRight = 0x41110D91 };
	self.box = Equendil.UI.DecoratedContainer( decoration );
	self.box:SetParent( self );
	self.box:SetSize( 350, 23 );

	-- helper function to create a label
	local newLabel = function( left, width, color )
		local label = Turbine.UI.Label();
		label:SetParent( self );
		label:SetSize( width, 23 );
		label:SetPosition( left, 0 );
		label:SetFont( Turbine.UI.Lotro.Font.TrajanPro16 );
		label:SetFontStyle( Turbine.UI.FontStyle.Outline );
		label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
		label:SetForeColor( color );
		label:SetMultiline( false );
		return label;
	end

	self.iconCost1 = Turbine.UI.Control();
	self.iconCost1:SetParent( self );
	self.iconCost1:SetSize( 27, 22 );
	self.iconCost1:SetPosition( 10, 0 );
	self.iconCost1:SetBackground( Equendil.LIP.Icon.CostBig );
	self.iconCost1:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );

	self.labelAvailable = newLabel( 35, 70, Equendil.UI.Color.TurbineLightYellow );
	self.labelAvailable:SetText( L["Available:"] );
	self.labelAvailable:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	
	self.labelAvailableValue = newLabel( 110, 40, Equendil.UI.Color.White );
	
	self.iconCost2 = Turbine.UI.Control();
	self.iconCost2:SetParent( self );
	self.iconCost2:SetSize( 27, 22 );
	self.iconCost2:SetPosition( 160, 0 );
	self.iconCost2:SetBackground( Equendil.LIP.Icon.CostBig );
	self.iconCost2:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );

	self.labelSpent = newLabel( 185, 95, Equendil.UI.Color.TurbineLightYellow );
	self.labelSpent:SetText( L["Spent:"] );
	self.labelSpent:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	
	self.labelSpentValue = newLabel( 290, 40, Equendil.UI.Color.White );
	
	self.actionLIChanged = function() self:Update() end;
end

function LegendaryItemFooterControl:SetItem( item, iconKey )
	if self.legendaryItem ~= nil then
		self.legendaryItem.Changed:Remove( self.actionLIChanged );
	end
		
	self.legendaryItem = item;
	
	if item ~= nil then
		item.Changed:Add( self.actionLIChanged )
		self:Update();
	end
end

function LegendaryItemFooterControl:Update()
	if self.legendaryItem ~= nil then
		self.labelSpentValue:SetText( tostring( self.legendaryItem:GetSpentPoints() ) );
		self.labelAvailableValue:SetText( tostring( self.legendaryItem:GetTotalPoints() - self.legendaryItem:GetSpentPoints() ) );
	else
		self.labelSpentValue:SetText( "0" );
		self.labelAvailableValue:SetText( "0" );
	end
end
	