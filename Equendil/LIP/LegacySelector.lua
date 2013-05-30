-- LegacySelector class. Presents a compact list of legacies for multi-selection. Displays total cost of a legacy at max tier & rank as an indicator of "cheapness"
-- Size: 350x256
import "Turbine.UI";

import "Equendil.UI.Resources";
import "Equendil.LIP.Legacy";

-- items used in the listbox
local LegacyItem = class( Turbine.UI.Control );
function LegacyItem:Constructor( legacy )
	Turbine.UI.Control.Constructor( self );

	self.legacy = legacy;
	self.isSelected = false;
	
	self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	self:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self:SetSize( 340, 16 );

	self.iconType = Turbine.UI.Control();
	self.iconType:SetParent( self );
	self.iconType:SetSize( 16, 16 );
	self.iconType:SetPosition( 0, 0 );
	self.iconType:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.iconType:SetMouseVisible( false );
	
	self.labelName = Turbine.UI.Label();
	self.labelName:SetParent( self );
	self.labelName:SetSize( 260, 16 );
	self.labelName:SetPosition( 20, 0 );
	self.labelName:SetFont( L.Font.SelectorLegacies );
	self.labelName:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelName:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.labelName:SetMouseVisible( false );

	self.iconCost = Turbine.UI.Control();
	self.iconCost:SetParent( self );
	self.iconCost:SetSize( 16, 16 );
	self.iconCost:SetPosition( 290, 0 );
	self.iconCost:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.iconCost:SetBackground( Equendil.LIP.Icon.CostSmall );
	self.iconCost:SetMouseVisible( false );
	
	self.labelTotalCost = Turbine.UI.Label();
	self.labelTotalCost:SetParent( self );
	self.labelTotalCost:SetSize( 30,16 );
	self.labelTotalCost:SetPosition( 310, 0 );
	self.labelTotalCost:SetFont( L.Font.SelectorLegacies );
	self.labelTotalCost:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelTotalCost:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.labelTotalCost:SetMouseVisible( false );
	
	self:SetMouseVisible( true );
	self.MouseClick = function( sender, args ) self:ToggleSelection() end
	
	self:SetSelection( legacy:IsActive() );
	
	self:Update();
end

function LegacyItem:Update()
	if self.legacy:GetType() == Equendil.LIP.Type.Major then
		self.iconType:SetBackground( Equendil.LIP.Icon.LegacyMajor );
	else
		self.iconType:SetBackground( Equendil.LIP.Icon.LegacyMinor );
	end
	
	self.labelName:SetText( self.legacy:GetName() );
	local totalCost = self.legacy:GetTotalCostOf( self.legacy:GetMaxTier(), self.legacy:GetMaxRank() );
	self.labelTotalCost:SetText( tostring( totalCost ) );
end

function LegacyItem:SetWidth( width )
	Turbine.UI.Control.SetWidth( self, width );
	self.labelName:SetWidth( width - 80 );
	self.iconCost:SetLeft( width - 50 );
	self.labelTotalCost:SetLeft( width - 30 );
end

function LegacyItem:ToggleSelection()
	self.isSelected = not self.isSelected;
	if self.isSelected then
		self:SetBackColor( Turbine.UI.Color( 0.2, 1, 1, 1 ) );
	else
		self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	end
	self.legacy:SetActive( self.isSelected );
end

function LegacyItem:SetSelection( value )
	self.isSelected = value;
	if self.isSelected then
		self:SetBackColor( Turbine.UI.Color( 0.2, 1, 1, 1 ) );
	else
		self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	end
end

function LegacyItem:IsSelected()
	return self.isSelected;
end

function LegacyItem:GetLegacy()
	return self.legacy;
end

LegacySelector = class( Turbine.UI.Control );
function LegacySelector:Constructor()
	Turbine.UI.Control.Constructor( self );
	
	self.legacyItems = {};
	
	self:SetSize( 350, 256 );
	
	-- standard scrollbar & listbox, items will handled their own selection
	self.scrollbar = Turbine.UI.Lotro.ScrollBar();
	self.scrollbar:SetOrientation( Turbine.UI.Orientation.Vertical );
	self.scrollbar:SetParent( self );
	self.scrollbar:SetPosition( 340, 0 );
	self.scrollbar:SetSize( 10, 256 );
	
	self.legacyList = Turbine.UI.ListBox();
    self.legacyList:SetParent( self );
    self.legacyList:SetBackColor( Turbine.UI.Color( 0.1, 0, 0, 0 ) );
    self.legacyList:SetPosition( 0, 0 );
    self.legacyList:SetSize( 340, 256 );
	self.legacyList:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.legacyList:SetVerticalScrollBar( self.scrollbar );
	self.legacyList:SetMouseVisible( false );
end

function LegacySelector:SetSize( width, height )
	Turbine.UI.Window.SetSize( self, width, height );
	self:_DoLayout();
end

function LegacySelector:SetWidth( width )
	Turbine.UI.Window.SetWidth( self, width );
	self:_DoLayout();
end

function LegacySelector:SetHeight( height )
	Turbine.UI.Window.SetHeight( self, height );
	self:_DoLayout();
end

function LegacySelector:_DoLayout()
	if self.legacyList == nil then return end -- not initialized
	
	local width, height = self:GetSize();
	
	self.scrollbar:SetLeft( width - 10 );
	self.scrollbar:SetHeight( height );
	self.legacyList:SetSize( width - 10 , height );
	for _,legacyItem in pairs( self.legacyItems ) do
		legacyItem:SetWidth( width - 10 );
	end
end

function LegacySelector:AddLegacy( legacy )
	local legacyItem = LegacyItem( legacy );
	table.insert( self.legacyItems, 1, legacyItem );
	self.legacyList:AddItem( legacyItem );
end

function LegacySelector:RemoveLegacy( legacy )
	-- not needed, UNIMPLEMENTED
end

function LegacySelector:Clear()
	self.legacyList:ClearItems();
	self.legacies = {};
end

function LegacySelector:GetSelectedLegacies()
	local selectedLegacies = {};
	for k, v in pairs( self.legacyItems ) do
		if v.IsSelected() then
			table.insert( selectedLegacies, 1, v.GetLegacy() );
		end
	end
	
	return selectedLegacies;
end
