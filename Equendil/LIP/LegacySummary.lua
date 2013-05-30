-- LegacySummary: detail view of a legacy at all ranks and current tier. Current rank is highlighted
-- Size: 235x200

import "Turbine.UI";

-- items used in the listbox. Rank/Cost/Modifier
local RankItem = class( Turbine.UI.Control );
function RankItem:Constructor( legacy, rank )
	Turbine.UI.Control.Constructor( self );

	self.legacy = legacy;
	self.rank = rank;
	
	self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	self:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self:SetSize( 235, 16 );

	self.labelRank = Turbine.UI.Label();
	self.labelRank:SetParent( self );
	self.labelRank:SetSize( 20, 16 );
	self.labelRank:SetPosition( 0, 0 );
	self.labelRank:SetFont( L.Font.RightPanelList );
	self.labelRank:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelRank:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.labelRank:SetMouseVisible( false );

	self.iconCost = Turbine.UI.Control();
	self.iconCost:SetParent( self );
	self.iconCost:SetSize( 16, 16 );
	self.iconCost:SetPosition( 20, 0 );
	self.iconCost:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.iconCost:SetBackground( Equendil.LIP.Icon.CostSmall );
	self.iconCost:SetMouseVisible( false );
	
	self.labelCost = Turbine.UI.Label();
	self.labelCost:SetParent( self );
	self.labelCost:SetSize( 30,16 );
	self.labelCost:SetPosition( 40, 0 );
	self.labelCost:SetFont( L.Font.RightPanelList );
	self.labelCost:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelCost:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.labelCost:SetMouseVisible( false );
	
	self.labelModifier = Turbine.UI.Label();
	self.labelModifier:SetParent( self );
	self.labelModifier:SetSize( 190, 16 );
	self.labelModifier:SetPosition( 70, 0 );
	self.labelModifier:SetFont( L.Font.RightPanelList );
	self.labelModifier:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelModifier:SetForeColor( Equendil.UI.Color.Green );
	self.labelModifier:SetMouseVisible( false );
	
	self:SetMouseVisible( false );
	
	self:Update();
end

function RankItem:Update()
	self.labelRank:SetText( L["R"] .. tostring( self.rank ) ); -- Short rank form: "R0" .... "R9"
	self.labelCost:SetText( tostring( self.legacy:GetCostOf( self.legacy:GetTier(), self.rank ) ) );
	self.labelModifier:SetText( self.legacy:GetModifierValueStringOf( self.rank ) );

	-- if the rank is the current rank of the legacy, highlight it
	if self.legacy:GetRank() == self.rank then 
		self:SetBackColor( Turbine.UI.Color( 0.5, 0.5, 0.5, 1 ) );
	else 
		self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	end

end

LegacySummary = class( Turbine.UI.Control );
function LegacySummary:Constructor()
	Turbine.UI.Control.Constructor( self );
	
	self.legacy = nil;
	self:SetSize( 235, 256 );
	self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	self:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	
	self.label = Turbine.UI.Label();
	self.label:SetParent( self );
	self.label:SetSize( 235, 40 );
	self.label:SetPosition( 0, 0 );
	self.label:SetFont( L.Font.RightPanelHeader );
	self.label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	self.label:SetForeColor( Equendil.UI.Color.White );
	self.label:SetMouseVisible( false );
	
	self.iconTier = Turbine.UI.Control();
	self.iconTier:SetParent( self );
	self.iconTier:SetSize( 16, 16 );
	self.iconTier:SetPosition( 0, 45 );
	self.iconTier:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	
	self.iconType = Turbine.UI.Control();
	self.iconType:SetParent( self );
	self.iconType:SetSize( 16, 16 );
	self.iconType:SetPosition( 0, 45 );
	self.iconType:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );

	self.labelDescription = Turbine.UI.Label();
	self.labelDescription:SetParent( self );
	self.labelDescription:SetSize( 215, 16 );
	self.labelDescription:SetPosition( 20, 45 );
	self.labelDescription:SetFont( L.Font.RightPanelHeader );
	self.labelDescription:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelDescription:SetForeColor( Equendil.UI.Color.TurbineWhite );
	self.labelDescription:SetMouseVisible( false );
--[[
	self.labelTier = Turbine.UI.Label();
	self.labelTier:SetParent( self );
	self.labelTier:SetSize( 50, 16 );
	self.labelTier:SetPosition( 60, 20 );
	self.labelTier:SetFont( L.Font.RightPanelHeader );
	self.labelTier:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelTier:SetForeColor( Equendil.UI.Color.TurbineWhite );
	self.labelTier:SetMouseVisible( false );
	--]]
	self.rankList = Turbine.UI.ListBox();
    self.rankList:SetParent( self );
    self.rankList:SetPosition( 0, 65 );
    self.rankList:SetSize( 340, 256 );
	self.rankList:SetVerticalScrollBar( self.scrollbar );
	self.rankList:SetMouseVisible( false );
	
	self.actionLegacyChanged = function() self:Update() end
end

function LegacySummary:Set( legacy )
	if self.legacy ~= nil then
		self.legacy.Changed:Remove( self.actionLegacyChanged );
	end
	
	self.legacy = legacy;

	if self.legacy ~= nil then
		self.legacy.Changed:Add( self.actionLegacyChanged );
	end
	
	self:Update();
end


local LegacyTypeIconAssoc = {
	[Equendil.LIP.Type.DPS] = Equendil.LIP.Icon.LegacyDefaultSmall.DPS,
	[Equendil.LIP.Type.TacticalDamageRating] = Equendil.LIP.Icon.LegacyDefaultSmall.TacticalDamageRating,
	[Equendil.LIP.Type.TacticalHealingRating] = Equendil.LIP.Icon.LegacyDefaultSmall.TacticalHealingRating,
	[Equendil.LIP.Type.IncomingHealingRating] = Equendil.LIP.Icon.LegacyDefaultSmall.IncomingHealingRating,
	[Equendil.LIP.Type.ShieldUse] = Equendil.LIP.Icon.LegacyDefaultSmall.ShieldUse,
	[Equendil.LIP.Type.FuryBonusContributionRating] = Equendil.LIP.Icon.LegacyDefaultSmall.FuryBonusContributionRating,
}

function LegacySummary:Update()
	self.rankList:ClearItems();

	if self.legacy == nil then 
		self.label:SetText("");
		self.labelDescription:SetText("");
--		self.labelTier:SetText("");
		self.iconType:SetVisible( false );
		self.iconTier:SetVisible( false );
		return 
	end

	self.label:SetText( self.legacy:GetName() );

	self.iconTier:SetVisible( true );	
	if self.legacy:IsDefault() then
		self.iconTier:SetBackground( LegacyTypeIconAssoc[self.legacy:GetType()] );
		self.iconType:SetVisible( false );
		self.labelDescription:SetText( "" );
--		self.labelTier:SetText( "" );
	else
		self.iconTier:SetBackground( Equendil.LIP.Icon.LegacyTierSmall[self.legacy:GetTier()]);
		local legacyType = "";
		if self.legacy:GetType() == Equendil.LIP.Type.Major then
			legacyType = L["Major"];
			self.iconType:SetBackground( Equendil.LIP.Icon.LegacyMajor );
		else
			legacyType = L["Minor"];
			self.iconType:SetBackground( Equendil.LIP.Icon.LegacyMinor );
		end

		self.labelDescription:SetText( string.format( L["%s Tier %d"], legacyType, self.legacy:GetTier() ) );
		
--		self.labelTier:SetText( L["Tier "] .. tostring( self.legacy:GetTier() ) );
		self.iconType:SetVisible( true );
--[[		if self.legacy:GetType() == Equendil.LIP.Type.Major then
			self.labelType:SetText( L["Major"] );
			self.iconType:SetBackground( Equendil.UI.Icon.LegacyMajor );
		else
			self.labelType:SetText( L["Minor"] );
			self.iconType:SetBackground( Equendil.UI.Icon.LegacyMinor );
		end--]]
	end	
	
	for i = 1, self.legacy:GetMaxRank() do 
		self.rankList:AddItem( RankItem( self.legacy, i ) );
	end
end


