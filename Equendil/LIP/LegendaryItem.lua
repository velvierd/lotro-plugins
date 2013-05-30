-- LegendaryItem class, handles level, age, legacies etc.

import "Equendil.Utils.WeakEvent";

LegendaryItem = class( Turbine.Object );
function LegendaryItem:Constructor( initData )
	Turbine.Object.Constructor( self );
	
	self.name = initData.name;
	self.levelToUse = 85;
	self.age = 3;
	self.level = 70;
	self.crystals = 0;
	
	self.legacies = {}; -- list of legacies
	self.legacyLookup = {}; -- stores legacy/id associations
	self.legacyReverseLookup = {}; -- stores id/legacy associations
	
	self.Changed = Equendil.Utils.WeakEvent(); -- event called without parameters whenever a legendary item changes in any way

	self.actionChanged = function() self.Changed() end;
	
	-- helper function to create a new legacy
	local newLegacy = function( legacyData, id )
		local legacy = Equendil.LIP.Legacy( legacyData, self );
		-- legacy.CostChanged:Add( self.actionChanged );
		legacy.Changed:Add( self.actionChanged );
		table.insert( self.legacies, 1, legacy );
		self.legacyLookup[legacy] = id;
		self.legacyReverseLookup[id] = legacy;
		return legacy;
	end

	-- use a counter for IDs
	local id = 1;
	
	-- add 'default' legacy (DPS, Tactical Healing/Damage Rating, Incoming Healing Rating, Shield Use)
	newLegacy( initData.defaultLegacy, id ):SetActive(true); -- default legacy is always active
	id = id + 1;
	
	-- add regular legacies. 
	-- NOTE: legacy data in legacy.lua must *not* have the order of legacies changed in any way, or legacies removed, so IDs remain correct. 
	for _, legacyData in ipairs( initData.legacies ) do
		if legacyData.type ~= Equendil.LIP.Type.Deprecated then
			newLegacy( legacyData, id );
		end
		id = id + 1;
	end

	-- add stat legacies
	if initData.liType ~= Equendil.LIP.LIType.Bridle then -- bridles don't get stat legacies
		id = 1000; -- we want to leave some room for future addition of legacies by Turbine
		for k, v in ipairs( Equendil.LIP.LegaciesStat ) do
			newLegacy( v, id );
			id = id + 1;
		end
	end
	
	-- sort the legacies: default legacy > major legacies > minor legacies, alphabetically if of same type
	local t = { [Equendil.LIP.Type.Major] = 1, [Equendil.LIP.Type.Minor] = 2, [Equendil.LIP.Type.Stat] = 3 };
	local compare = function( legacy1, legacy2 ) -- comparison function for sorting
		-- Getting nil values sent by table.sort, so checking for those ..
		if legacy1 == nil then return true; end
		if legacy2 == nil then return false; end
		
		local type1 = legacy1:GetType();
		local type2 = legacy2:GetType();
		if type1 == type2 then
			return legacy1.name < legacy2.name;
		end

		if t[type1] == nil then return true end;
		if t[type2] == nil then return false end;
		return t[type1] < t[type2];
	end
	
	table.sort( self.legacies, compare ); 
end

-- straight forward accessors
function LegendaryItem:GetLegacies() return self.legacies; end
function LegendaryItem:GetLevel() return self.level; end
function LegendaryItem:GetLevelToUse() return self.levelToUse; end
function LegendaryItem:GetAge()	return self.age; end
function LegendaryItem:GetName() return self.name; end
function LegendaryItem:GetCrystals() return self.crystals; end
function LegendaryItem:SetLevel( level ) self.level = level; self.Changed(); end
function LegendaryItem:SetName( name ) self.name = name; self.Changed(); end
function LegendaryItem:SetCrystals( crystals )
	self.crystals = crystals;
	for _,legacy in pairs ( self.legacies ) do 
		legacy:SetCrystals( crystals );
	end
	self.Changed();
end

function LegendaryItem:SetAge( age ) 
	self.age = age;
	for _,legacy in pairs( self.legacies ) do
		legacy:SetAge( age );
	end
	self.Changed(); 
end

function LegendaryItem:SetLevelToUse( level ) 
	self.levelToUse = level; 
	for _,legacy in pairs( self.legacies ) do
		legacy:SetLevel( level );
	end
	self.Changed(); 
end

-- computes total points available on a legendary item
function LegendaryItem:GetTotalPoints()
	-- legendary items get 10 points for each level from 2 to 10, 12 points from lvl 11 to 20, 14 points from level 21 to 30,  
	-- 8/10/12 points from 31 to 70 for a 3rd/2nd/1st age
	
	-- helper function to determine number of effective levels in a range
	function levelsinrange(x, x0, x1 ) 
		if x >= x0 then
			x = math.min( x, x1 );
			return ( x - x0 + 1 );
		end
		return 0;
	end
	
	local points = levelsinrange( self.level, 2, 10 ) * 10 +
					levelsinrange( self.level, 11, 20 ) * 12 +
					levelsinrange( self.level, 21, 30 ) * 14 +
					levelsinrange( self.level, 31, 70 ) * ( 8 + 2 * ( 3 - self.age ) );
	return points;
end

-- compute spent points on a legendary item
function LegendaryItem:GetSpentPoints()
	local total = 0;
	for k, legacy in pairs( self.legacies ) do
		if legacy:IsActive() then
			total = total + legacy:GetTotalCurrentCost();
		end
	end
	return total;
end

-- Serialization

function LegendaryItem:GetData()
	local data = {};
	
	data.name = self.name;
	data.level = self.level;
	data.levelToUse = self.levelToUse;
	data.age = self.age;
	data.crystals = self.crystals;
	data.legacies = {};

	for k, legacy in pairs(self.legacies) do
		local id = self.legacyLookup[legacy];
		data.legacies[id] = {};
		data.legacies[id].rank = legacy:GetRank();
		data.legacies[id].tier = legacy:GetTier();
		data.legacies[id].active = legacy:IsActive();
	end
	
	return data;
end

function LegendaryItem:SetData( data )
	self:SetName( data.name );
	self:SetLevel( data.level );
	self:SetLevelToUse( data.levelToUse );
	self:SetAge( data.age );
	local crystals = 0;
	if data.crystals then
		crystals = data.crystals;
	end
	self:SetCrystals( crystals );
	
	-- self.name = data.name;
	-- self.level = data.level;
	-- self.levelToUse = data.levelToUse;
	-- self.age = data.age;
	
	for id, legacyData in pairs( data.legacies ) do
		local legacy = self.legacyReverseLookup[id];
		if legacy ~= nil then -- could be loading a deprecated legacy
			-- legacy.CostChanged:Remove( self.actionChanged ); -- Unregister callback temporarily so we do not repetedly dispatch our own Changed() event
			legacy.Changed:Remove( self.actionChanged );
			legacy:SetRank( legacyData.rank );
			legacy:SetTier( legacyData.tier );
			legacy:SetActive( legacyData.active );
			-- legacy.CostChanged:Add( self.actionChanged ); -- register callback again
			legacy.Changed:Add( self.actionChanged );
		end
	end
	
	self.Changed();
end

