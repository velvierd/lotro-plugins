-- Legendary item control. Interface to display and manipulate name, level, age of a legendary item
-- Size: 706*63

import "Turbine.UI";

import "Equendil.UI.Resources";
import "Equendil.UI.IconButton";
import "Equendil.UI.LotroIcon";
import "Equendil.UI.TextBox";

local IconStarLit = 0x4112665A;
local IconStarDim = 0x4112665B;
local CrystalBackground = 0x4112895E;

LegendaryItemControl = class( Turbine.UI.Control );
function LegendaryItemControl:Constructor()
	Turbine.UI.Control.Constructor( self );

	-- Event fired when the 'close item' button is clicked
	self.CloseRequest = Equendil.Utils.Event();
	self.ExpHover = Equendil.Utils.Event(); -- Fires when the mouser pointer is hovering the level
	
	self.legendaryItem = nil;
	self.iconKey = nil;
	
	self:SetSize( 706, 70 );
	
	-- icon of the item
	self.iconItem = Equendil.UI.LotroIcon();
	self.iconItem:SetParent( self );
	self.iconItem:SetSize( 32, 32 );
	self.iconItem:SetPosition( 27, 15 );
	self.iconItem:SetHighlightable( false );

	-- button to delete the item
	self.buttonDelete = Equendil.UI.ButtonCloseRed();
	self.buttonDelete:SetParent( self );
	self.buttonDelete:SetPosition( 400, 0 );
	self.buttonDelete:SetStretchMode( 1 );
--	self.buttonDelete:SetSize( 40, 40 );
	
	-- item name
	self.textboxItemName = Equendil.UI.TextBox();
	self.textboxItemName:SetParent( self );
	self.textboxItemName:SetSize( 285, 20 );
	self.textboxItemName:SetPosition( 75, 0 );
	self.textboxItemName:SetFont( Turbine.UI.Lotro.Font.TrajanPro16 );
	self.textboxItemName:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.textboxItemName:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.textboxItemName:SetMultiline( false );

	-- crystals 
	self.crystalsControl = Turbine.UI.Control();
	self.crystalsControl:SetParent( self );
	self.crystalsControl:SetSize( 132, 21 );
	self.crystalsControl:SetPosition( 22, 49 );
	self.crystalsControl:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.crystalsControl:SetBackground( CrystalBackground );
	
	self.crystalsLabel = Turbine.UI.Label();
	self.crystalsLabel:SetParent( self.crystalsControl );
	self.crystalsLabel:SetSize( 65, 14 );
	self.crystalsLabel:SetPosition( 15, 5 );
	self.crystalsLabel:SetFont( Turbine.UI.Lotro.Font.TrajanPro14 );
	self.crystalsLabel:SetFontStyle (Turbine.UI.FontStyle.Outline );
	self.crystalsLabel:SetForeColor( Turbine.UI.Color( 1, 0.9,0.9,0.4 ) );
	self.crystalsLabel:SetText( L["Upgrades:"] );
	self.crystalsLabel:SetMouseVisible(false);
	
	self.crystals = {};
	for i = 1, 3 do 
		self.crystals[i] = Turbine.UI.Control();
		self.crystals[i]:SetParent( self.crystalsControl );
		self.crystals[i]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.crystals[i]:SetBackground( IconStarDim );
		self.crystals[i]:SetPosition( ( 80 + (i-1) * 16 ), 4 );
		self.crystals[i]:SetSize( 15, 15 );
		self.crystals[i]:SetMouseVisible(false);
	end
	
	-- level to use slider
	local levelIndicator = { topLeft = 0x410E82A3, top = 0x410E82A4, topRight = 0x410E82A5 };
	self.backgroundLevel = Equendil.UI.DecoratedContainer( levelIndicator );
	self.backgroundLevel:SetParent( self );
	self.backgroundLevel:SetSize( 260, 25 );
	self.backgroundLevel:SetPosition(159,47);

	self.labelLevel = Turbine.UI.Label();
	self.labelLevel:SetParent( self.backgroundLevel );
	self.labelLevel:SetSize(40,25);
	self.labelLevel:SetPosition( 4, 0 );
	self.labelLevel:SetFont( Turbine.UI.Lotro.Font.TrajanPro14 );
	self.labelLevel:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	self.labelLevel:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.labelLevel:SetForeColor( Turbine.UI.Color( 1, 0.9, 0.9, 0.4 ) );

	self.scrollbarLevel = Turbine.UI.Lotro.ScrollBar();
	self.scrollbarLevel:SetParent( self.backgroundLevel );
	self.scrollbarLevel:SetSize(210, 10 );
	self.scrollbarLevel:SetPosition( 47, 8 );
	self.scrollbarLevel:SetMinimum( 1 );
	self.scrollbarLevel:SetMaximum( 70 );
	self.scrollbarLevel:SetSmallChange( 1 );
	self.scrollbarLevel:SetLargeChange( 10 );
	self.scrollbarLevel:SetOrientation( Turbine.UI.Orientation.Horizontal );
	
	-- level / age description & buttons
	self.labelLevelAge = Turbine.UI.Label();
	self.labelLevelAge:SetParent( self );
	self.labelLevelAge:SetSize( 190, 20 );
	self.labelLevelAge:SetPosition( 120, 25 );
	self.labelLevelAge:SetFont( Turbine.UI.Lotro.Font.TrajanPro14 );
	self.labelLevelAge:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelLevelAge:SetForeColor( Turbine.UI.Color( 1, 0.7, 0.7, 0.7 ) );
	self.labelLevelAge:SetMultiline( false );
	
	self.buttonPreviousLevel = Equendil.UI.ButtonArrowLeft16();
	self.buttonPreviousLevel:SetParent( self );
	self.buttonPreviousLevel:SetPosition( 80, 28 );
	
	self.buttonNextLevel = Equendil.UI.ButtonArrowRight16();
	self.buttonNextLevel:SetParent( self );
	self.buttonNextLevel:SetPosition( 100, 28 );
	
	self.buttonAge = {};
	for i = 1, 3 do 
		self.buttonAge[i] = Equendil.UI.LotroIcon();
		self.buttonAge[i]:SetParent( self );
		self.buttonAge[i]:SetBackdrop( Equendil.LIP.Icon.LIBackground[4 - i] );
		self.buttonAge[i]:SetPosition( 320 + ( (i-1) * 22 ), 26 );
		self.buttonAge[i].Clicked = function( sender, args ) self.legendaryItem:SetAge( 4 - i ); end
		self.buttonAge[i]:SetStretchMode(1);
		self.buttonAge[i]:SetSize( 20, 20 );
		self.buttonAge[i]:SetHighlightable( true );
	end

	-- actions
	self.crystalsControl.MouseUp = function( sender, args ) 
		self.legendaryItem:SetCrystals( ( self.legendaryItem:GetCrystals() + 1 ) % 4 ); 
	end
	
	self.buttonDelete.Clicked = function( button ) self.CloseRequest() end	
	
	self.scrollbarLevel.ValueChanged = function( sender, args ) 
		if self.legendaryItem ~= nil then
			self.legendaryItem:SetLevel( self.scrollbarLevel:GetValue() );
		end
	end
	
	self.buttonPreviousLevel.Clicked = function( button ) 
		if self.legendaryItem:GetLevelToUse() > 51 then
			self.legendaryItem:SetLevelToUse( self.legendaryItem:GetLevelToUse() - 1 );
		end
	end

	self.buttonNextLevel.Clicked = function( button ) 
		if self.legendaryItem:GetLevelToUse() < 85 then
			self.legendaryItem:SetLevelToUse( self.legendaryItem:GetLevelToUse() + 1 );
		end
	end
	
	self.textboxItemName.TextChanged = function()
		if self.legendaryItem ~= nil then
			self.legendaryItem.Changed:Remove( self.actionLegendaryItemChanged );
			self.legendaryItem:SetName( self.textboxItemName:GetText() );
			self.legendaryItem.Changed:Add( self.actionLegendaryItemChanged );
		end
	end
	
	self.labelLevel.MouseEnter = function( sender, args ) self.ExpHover( self.legendaryItem ) end
	self.labelLevel.MouseLeave = function( sender, args ) self.ExpHover( nil ) end
	
	self.actionLegendaryItemChanged = function() self:Update() end;
end

function LegendaryItemControl:SetItem( item, iconKey )
	-- remove action from previous item if we had one
	if self.legendaryItem ~= nil then
		self.legendaryItem.Changed:Remove( self.actionLegendaryItemChanged );
	end
		
	-- and setup the new item
	self.legendaryItem = item;
	self.iconKey = iconKey;

	self:SetVisible( item ~= nil );
	
	if item ~= nil then
		item.Changed:Add( self.actionLegendaryItemChanged )
		self:Update();
	end
end

local AgeText = { L["first"], L["second"], L["third"] };

function LegendaryItemControl:Update()
	if self.legendaryItem ~= nil then
		local age = self.legendaryItem:GetAge();
		
		self.iconItem:SetBackdrop( Equendil.LIP.Icon.LIBackground[age] );
		self.iconItem:Set( Equendil.LIP.Icon.LIShadow[self.iconKey][age], Equendil.LIP.Icon.LI[self.iconKey][age] );
	
		self.textboxItemName:SetText( self.legendaryItem:GetName() );
		self.textboxItemName:SetForeColor( Equendil.UI.Color.TurbineLI[age] );
		
		self.labelLevelAge:SetText( string.format(L["Level %d %s age"], self.legendaryItem:GetLevelToUse(), AgeText[age] ) );
		
		self.labelLevel:SetText( tostring( self.legendaryItem:GetLevel() .. "/70" ) );
		self.scrollbarLevel:SetValue( self.legendaryItem:GetLevel() ); -- could cause an infinite loop if that caused ValueChanged from the scrollbar (which it does not if it's the same value)
	
		for i = 1, 3 do 
			self.buttonAge[i]:Set( Equendil.LIP.Icon.LIShadow[self.iconKey][4-i], Equendil.LIP.Icon.LI[self.iconKey][4-i] );
		end
		
		for i = 1, 3  do 
			if self.legendaryItem:GetCrystals() >= i then
				self.crystals[i]:SetBackground( IconStarLit );
			else
				self.crystals[i]:SetBackground( IconStarDim );
			end
		end
	end
end