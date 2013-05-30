-- LegacyConfigurator class. Presents the user with an interface to set the tier and rank of legacies, as well as display costs
-- Size: 350x256
import "Turbine.UI";

import "Equendil.UI.IconButton";

-- Context menu for tier selection
local TierMenu = class( Turbine.UI.Window );
function TierMenu:Constructor()
	Turbine.UI.Window.Constructor( self );

	self.TierSelected = nil; -- Event
	
	self.currentTier = 0;
	self.items = {};
	
	self:SetVisible( false ); -- we're hidden until further notice
	self:SetSize(120, 140 );
	self:SetMouseVisible( true );
	self:SetBackColor( Turbine.UI.Color( 1,0,0,0 ) );
	self:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	
	-- borders around the control
	self.borders = Equendil.UI.DecoratedContainer( Equendil.UI.Decoration.SimpleGreyOutline );
	self.borders:SetParent( self );
	self.borders:SetMouseVisible( false );
	self.borders:SetSize( 120, 140 );

	-- checkmark to display the current tier in the menu
	self.checkmark = Turbine.UI.Control();
	self.checkmark:SetParent( self );
	self.checkmark:SetBackground( Equendil.UI.Icon.CheckMarkGreen );
	self.checkmark:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.checkmark:SetSize( 16, 16 );
	self.checkmark:SetLeft( 10 );
	self.checkmark:SetMouseVisible( false );
	
	-- List of tiers.
	for i = 1, 6 do
		local item = Turbine.UI.Control();
		item:SetParent( self );
		item:SetSize( 80, 20 );
		item:SetBackColor( Equendil.UI.Color.Black );
		
		item.tierIcon = Turbine.UI.Control();
		item.tierIcon:SetParent( item );
		item.tierIcon:SetBackground( Equendil.LIP.Icon.LegacyTierSmall[i] );
		item.tierIcon:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		item.tierIcon:SetSize( 16, 16 );
		item.tierIcon:SetPosition( 0, 2 );
		item.tierIcon:SetMouseVisible( false );
		
		item.label = Turbine.UI.Label();
		item.label:SetParent( item );
		item.label:SetFont( Turbine.UI.Lotro.Font.Verdana14 );
		item.label:SetTextAlignment (Turbine.UI.ContentAlignment.MiddleLeft );
		item.label:SetForeColor( Equendil.UI.Color.TurbineWhite );
		item.label:SetText( L["Tier "] .. tostring( i ) );
		item.label:SetSize( 60, 20 );
		item.label:SetLeft( 20 );
		item.label:SetMouseVisible( false );
		
		item:SetMouseVisible( true );
		item:SetPosition( 30, 10 + ( ( i -1 ) * 20 ) );
	
		-- menu item highlighting
		item.MouseEnter = function( sender, args ) item:SetBackColor( Turbine.UI.Color( 1, 0.3, 0.3, 0.3 ) ) end
		item.MouseLeave = function( sender, args ) item:SetBackColor( Equendil.UI.Color.Black ) end

		-- setup a callback for selection
		item.MouseUp = function( sender, args )
			self:SetVisible( false ); -- item selected, hide the menu
			Equendil.Utils.Event.Fire( self.TierSelected, i ); -- notify
		end
		
		self.items[i] = item;
	end
	
	-- Hide menu on loss of focus
	self.FocusLost = function( sender, args ) self:SetVisible( false ) end 
end

-- show the manu with <currentTier> selected. Selection will be notified through <callback>
function TierMenu:Show( currentTier, callback )
	self.currentTier = currentTier;
	self.TierSelected = callback;

	-- move the checkmark in front of the relevant item (note: +2 to center the 16x16 icon)
	self.checkmark:SetTop( 10 + 2 + ( ( currentTier - 1 ) * 20 ) ); 

	self:SetPosition( Turbine.UI.Display:GetMousePosition() ); -- open the menu at the mouse pointer
	self:SetVisible( true );
	self:Activate(); -- Bring to front
	self:Focus(); -- Note: apparently the window won't take focus if not activated first
end


-- items used in the listbox
local LegacyItem = class( Turbine.UI.Control );
function LegacyItem:Constructor( legacy, contextMenu )
	Turbine.UI.Control.Constructor( self );
	
	self.legacy = legacy;
	self.contextMenu = contextMenu;

	self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	self:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self:SetSize( 540, 42 ); -- oversized on purpose, more will display if parent control is resized

	-- helper function to make & init a label
	local newLabel = function( width, height, left, top, color )
		local label = Turbine.UI.Label();
		label:SetParent( self );
		label:SetSize( width, height );
		label:SetPosition( left, top );
		label:SetForeColor( color );
		label:SetFont( L.Font.ConfiguratorLegacies );
		label:SetFontStyle( Turbine.UI.FontStyle.Outline );
		label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
		label:SetMultiline(false);
		return label;
	end
	
	-- helper function to make a small "cost" icon
	local newCostIcon = function( left, top )
		local control = Turbine.UI.Control();
		control:SetParent( self );
		control:SetSize( 15, 15 );
		control:SetPosition( left, top );
		control:SetBackground( Equendil.LIP.Icon.CostSmall );
		control:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		return control;
	end

	-- large tier icon
	self.iconTier = Turbine.UI.Control();
	self.iconTier:SetParent( self );
	self.iconTier:SetSize( 32, 32 );
	self.iconTier:SetPosition( 0 , 4 );
	self.iconTier:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.iconTier:SetBackColorBlendMode( Turbine.UI.BlendMode.Color );
	-- TODO: stratching seems to be causing some weird stuff
	-- self.iconTier:SetStretchMode(1) 

	self.iconType = Turbine.UI.Control();
	self.iconType:SetParent( self );
	self.iconType:SetSize( 32, 32 );
	self.iconType:SetPosition( 0, 4 );
	self.iconType:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.iconType:SetMouseVisible( false );

	-- first row: legacy value/text
	self.labelModifier = newLabel( 500, 16, 40, 4, Equendil.UI.Color.White );

	-- second row elements: rank, rank buttons, cost of next rank, total cost
	self.labelRank = newLabel( 40, 16, 40, 20, Equendil.UI.Color.TurbineLightYellow );
	self.labelRank:SetText( L["Rank:"] );
	self.labelRankValue = newLabel( 15,16, 80, 20, Equendil.UI.Color.TurbineWhite );
	
	self.buttonPreviousRank = Equendil.UI.ButtonArrowLeft16();
	self.buttonPreviousRank:SetParent( self );
	self.buttonPreviousRank:SetPosition( 90, 20 );

	self.buttonNextRank = Equendil.UI.ButtonArrowRight16();
	self.buttonNextRank:SetParent( self );
	self.buttonNextRank:SetPosition( 106, 20 );

	self.buttonMaxRank = Equendil.UI.ButtonFastForward16();
	self.buttonMaxRank:SetParent( self );
	self.buttonMaxRank:SetPosition( 122, 20 );
	
--	self.labelNextCost = newLabel( 35, 16, 150, 20, Equendil.UI.Color.TurbineLightYellow );
--	self.labelNextCost:SetText( L["Next:"] );
--	self.iconNextCost = newCostIcon( 185, 20 );
--	self.labelNextCostValue = newLabel( 35, 16, 205, 20, Equendil.UI.Color.White );

--	self.labelTotalCost = newLabel( 40, 16, 235, 20, Equendil.UI.Color.TurbineLightYellow );
--	self.labelTotalCost = newLabel( 80, 16, 195, 20, Equendil.UI.Color.TurbineLightYellow );
--	self.labelTotalCost:SetText( L["Spent:"] );
--	self.labelTotalCost:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );
	self.iconCost = newCostIcon( 220, 20 );
	self.labelCost = newLabel( 100, 16, 240, 20, Equendil.UI.Color.White );
--	self.labelTotalCostValue = newLabel( 30, 16, 295, 20, Equendil.UI.Color.White );

	-- ACTIONS	
	
	-- icon tier highlightning 
	self.iconTier.MouseEnter = function( sender, args ) self.iconTier:SetBackColor( Turbine.UI.Color( 0.5, 1, 1, 1 ) ) end;
	self.iconTier.MouseLeave = function( sender, args ) self.iconTier:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) ) end;
	
	self.iconTier.MouseDown = function( sender, args ) 
		if args.Button == Turbine.UI.MouseButton.Left then
			self.iconTier:SetBackColor( Turbine.UI.Color( 0.8, 0.8, 0.8, 1 ) ); -- graphical feedback
		end
	end
	
	-- icon tier actions
	self.iconTier.MouseUp = function( sender, args ) 
		if args.Button == Turbine.UI.MouseButton.Left then
			self.iconTier:SetBackColor( Turbine.UI.Color( 0.5, 1, 1, 1 ) ); -- graphical feedback
			self:_CycleTiers(); -- cycle across tiers on left click
		elseif args.Button == Turbine.UI.MouseButton.Right then
			self:_TierMenu(); -- open context menu on right click
		end
	end

	-- decrease rank
	self.buttonPreviousRank.Clicked = function( button ) 
		if self.legacy:GetRank() > 1 then
			self.legacy:SetRank( self.legacy:GetRank() - 1 );
		end 
	end
	
	-- increase rank
	self.buttonNextRank.Clicked = function( button )
		if self.legacy:GetRank() < self.legacy:GetMaxRank() then
			self.legacy:SetRank( self.legacy:GetRank() + 1 );
		end
	end
	
	-- set to max rank
	self.buttonMaxRank.Clicked = function( button )
		if self.legacy:GetRank() < self.legacy:GetMaxRank() then
			self.legacy:SetRank( self.legacy:GetMaxRank() );
		end
	end
	
	self:Update();

	self.actionLegacyChanged = function() self:Update() end
	self.legacy.Changed:Add( self.actionLegacyChanged );
end

-- table associating default legacy types with their icon representation
local LegacyTypeIconAssoc = {
	[Equendil.LIP.Type.DPS] = Equendil.LIP.Icon.LegacyDefaultBig.DPS,
	[Equendil.LIP.Type.TacticalDamageRating] = Equendil.LIP.Icon.LegacyDefaultBig.TacticalDamageRating,
	[Equendil.LIP.Type.TacticalHealingRating] = Equendil.LIP.Icon.LegacyDefaultBig.TacticalHealingRating,
	[Equendil.LIP.Type.IncomingHealingRating] = Equendil.LIP.Icon.LegacyDefaultBig.IncomingHealingRating,
	[Equendil.LIP.Type.ShieldUse] = Equendil.LIP.Icon.LegacyDefaultBig.ShieldUse,
	[Equendil.LIP.Type.FuryBonusContributionRating] = Equendil.LIP.Icon.LegacyDefaultBig.FuryBonusContributionRating,
}

-- update values of individual controls
function LegacyItem:Update()
	-- tier icon
	if not self.legacy:IsDefault() then
		self.iconTier:SetBackground( Equendil.LIP.Icon.LegacyTierBig[self.legacy:GetTier()]);
	else
		self.iconTier:SetBackground( LegacyTypeIconAssoc[self.legacy:GetType()] );
	end

	-- overlay type icon
	if not self.legacy:IsDefault() then
		if self.legacy:GetType() == Equendil.LIP.Type.Major then
			self.iconType:SetBackground( Equendil.LIP.Icon.LegacyTierMajor );
		else
			self.iconType:SetBackground( Equendil.LIP.Icon.LegacyTierMinor );
		end
	end
	
	-- current rank
	self.labelRankValue:SetText( tostring( self.legacy:GetRank() ) );
	
	-- modifier description
	self.labelModifier:SetText( self.legacy:GetCurrentModifierString() );
	
	-- cost of next rank
	local nextCost = nil;
	if self.legacy:GetRank() == self.legacy:GetMaxRank() then
		nextCost = L["Max"];
	else
		nextCost = "+"..tostring( self.legacy:GetCostOf( self.legacy:GetTier(), self.legacy:GetRank() + 1 ) );
	end

	self.labelCost:SetText( string.format( "%d (%s)", self.legacy:GetTotalCurrentCost(), nextCost ) );
end

-- Cycle across tiers. Increase if not at max rank or back to tier1 otherwise
function LegacyItem:_CycleTiers( button )
	if self.legacy:GetTier() == self.legacy:GetMaxTier() then
		self.legacy:SetTier( 1 );
	else
		self.legacy:SetTier( self.legacy:GetTier() + 1 );
	end
end

-- open the context menu for tier selection if the legacy isn't a default legacy
function LegacyItem:_TierMenu()
	if not self.legacy:IsDefault() then
		local callback = function( n )
			self.legacy:SetTier( n );
		end
		self.contextMenu:Show( self.legacy:GetTier(), callback );
	end
end

-- Main control. Presents the user with a list of active legacies for configuration.
LegacyConfigurator = class( Turbine.UI.Control );
function LegacyConfigurator:Constructor()
	Turbine.UI.Control.Constructor( self );
	
	self.LegacyHover = Equendil.Utils.Event(); -- Fires when the mouser pointer is hovering a legacy
	
	self.legendaryItem = nil;
	
	self:SetSize( 350, 256 );
	
	-- we'll use a standard list box with a scrollbar for layout here
	self.scrollbar = Turbine.UI.Lotro.ScrollBar();
	self.scrollbar:SetOrientation( Turbine.UI.Orientation.Vertical );
	self.scrollbar:SetParent( self );
	self.scrollbar:SetPosition( 340, 0 );
	self.scrollbar:SetSize( 10, 256 );
	
	self.legacyList = Turbine.UI.ListBox();
    self.legacyList:SetParent( self );
    self.legacyList:SetPosition( 0, 0 );
    self.legacyList:SetSize( 340, 256 );
	self.legacyList:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.legacyList:SetVerticalScrollBar( self.scrollbar );
	
	self.contextMenu = TierMenu();
end

function LegacyConfigurator:SetSize( width, height )
	Turbine.UI.Window.SetSize( self, width, height );
	self:_DoLayout();
end

function LegacyConfigurator:SetWidth( width )
	Turbine.UI.Window.SetWidth( self, width );
	self:_DoLayout();
end

function LegacyConfigurator:SetHeight( height )
	Turbine.UI.Window.SetHeight( self, height );
	self:_DoLayout();
end

function LegacyConfigurator:_DoLayout()
	if self.legacyList == nil then return end -- not initialized
	
	local width, height = self:GetSize();
	
	self.scrollbar:SetLeft( width - 10 );
	self.scrollbar:SetHeight( height );
	self.legacyList:SetSize( width - 10 , height );
	
end

-- attach a legendary item to the control
function LegacyConfigurator:SetLegendaryItem( item )
	self.legendaryItem = item;
	if item == nil then
		self.legacyList:ClearItems();
	else
		self:UpdateLegacies();
	end
end

-- Set all (active) legacies to max tier
function LegacyConfigurator:SetMaxTiers()
	if self.legendaryItem ~= nil then
		for k, legacy in pairs( self.legendaryItem:GetLegacies() ) do
			if legacy:IsActive() then
				legacy:SetTier( legacy:GetMaxTier() );
			end
		end
	end
end

-- Update the list of active legacies
function LegacyConfigurator:UpdateLegacies()
	local legacies = self.legendaryItem:GetLegacies();

	-- we'll simply rebuild the listbox here
	self.legacyList:ClearItems();
	for k, legacy in pairs( legacies ) do
		if legacy:IsActive() then
			local legacyItem = LegacyItem( legacy, self.contextMenu );
			legacyItem.MouseEnter = function( sender, args ) self.LegacyHover( legacy ) end
			legacyItem.MouseLeave = function( sender, args ) self.LegacyHover( nil ) end

			self.legacyList:AddItem( legacyItem );
		end
	end
end