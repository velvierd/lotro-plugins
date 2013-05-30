-- 'Legacy' class to manipulate legacies and full list of all legacies for each class

-- TODO: RoI, check all adjustable legacies, need more mod values ...

import "Equendil.Utils.WeakEvent";
import "Equendil.LIP.LegacyData";


-- Legacy class
-- TODO: callbacks may be called when values remain identical despite level/age modification, would be better not to
Legacy = class( Turbine.Object )
function Legacy:Constructor( data, item )
	Turbine.Object.Constructor( self );
	
	self.legendaryItem = item;
	self.level = item:GetLevelToUse();
	self.age = item:GetAge();
	self.crystals = item:GetCrystals();
	
	self.name = data.name;
	self.type = data.type;
	self.modifierType = data.modType;
	self.modifiers = data.mod;
	self.costs = data.cost;
	self.maxRank = data.maxRank;

	self.tier = 1; -- default to tier 1
	self.rank = 1; -- default to rank 1
	
	-- items hold a list of all possible legacies, 'active' ones represent the user's choice
	self.active = false; 
	
	-- Events. No parameters
	self.Changed = Equendil.Utils.WeakEvent(); -- fired off for any change in the legacy
	-- self.CostChanged = Equendil.Utils.WeakEvent(); -- fired off when the 'cost' of a legacy has changed
	-- self.ActiveChanged = Equendil.Utils.WeakEvent();
	
	--[[ DEBUG
	for age = 1, 3 do
		for level = 51, 75 do
			local maxRank = self:GetMaxRankLA( level, age );
			for rank = 2, maxRank do
				-- local success, value = pcall( GetModifierValueOfLA, self, level, age, rank );
				-- if not success or value == 0 then
				local value = self:GetModifierValueOfLA( level, age, rank  );
				if value == 0 or value == nil then
					-- value is 0, seems we have a problem, output an error message
					Turbine.Log:Information( "Legacy value incorrect: " .. self.name .. 
						" (lvl=" .. tostring( level ) .. 
						", age=" .. tostring( age ) .. 
						", rank=" .. tostring( rank ) .. ")" 
					);
				end
				if not self:IsDefault() then
					for tier = 1, 6 do
						-- local success, value = pcall( GetCostOfLA, self, level, age, tier, rank );
						-- if not success or value == 0 then
						local value = self:GetCostOfLA( level, age, tier, rank );
						if value == 0 or value == nil then 
							-- cost is 0 and it shouldn't output an error message
							Turbine.Log:Information( "Legacy cost incorrect: " .. self.name ..
								" (lvl=" .. tostring( level ) .. 
								", age=" .. tostring( age ) .. 
								", tier=" .. tostring( tier ) ..
								", rank=" .. tostring( rank ) .. ")" 
							);
						end
					end
				end
			end
		end
	end
	--]]
--	self.legendaryItem.Changed:Add( self.actionLegendaryItemChanged );
end

function Legacy:GetCrystals() return self.crystals end
function Legacy:SetCrystals( crystals )
	if crystals == self.crystals then return end
	self.crystals = crystals;
	if type( self.costs ) == "function" or type( self.modifiers ) == "function" or type( self.maxRank ) == "function" then
		if type( self.maxRank ) == "function" then
			self.rank = math.min( self.rank, self.maxRank( self.level, self.age ) );
		end
		-- not entirely accurate as nothing might have actually changed, but this is a good bet if values are computed
		self.Changed(); 
	end

end

function Legacy:GetLevel() return self.level end
function Legacy:SetLevel( level ) 
	if level == self.level then return end
	self.level = level;	
	if type( self.costs ) == "function" or type( self.modifiers ) == "function" or type( self.maxRank ) == "function" then
		if type( self.maxRank ) == "function" then
			self.rank = math.min( self.rank, self.maxRank( self.level, self.age ) );
		end
		-- not entirely accurate as nothing might have actually changed, but this is a good bet if values are computed
		self.Changed(); 
	end
end

function Legacy:GetAge() return self.age end
function Legacy:SetAge( age ) 
	if age == self.age then return end
	self.age = age;
	if type( self.costs ) == "function" or type( self.modifiers ) == "function" or type( self.maxRank ) == "function" then
		if type( self.maxRank ) == "function" then
			self.rank = math.min( self.rank, self.maxRank( self.level, self.age ) );
		end
		-- not entirely accurate as nothing might have actually changed, but this is a good bet if value are computed
		self.Changed(); 
	end
end

-- Straight forward accessors & methods
function Legacy:GetName() return self.name end
function Legacy:GetType() return self.type end
function Legacy:GetRank() return self.rank end
function Legacy:GetTier() return self.tier end
function Legacy:GetMaxRank() return self:GetMaxRankLA( self.level, self.age ); end
--function Legacy:GetModifierOf( rank ) return self.modifiers[rank] end
--function Legacy:GetCurrentModifier() return self.modifiers[self.rank] end
function Legacy:GetCostOf( tier, rank )	return self:GetCostOfLA( self.level, self.age, tier, rank ); end
function Legacy:GetModifierStringOf(rank) return self:GetModifierValueStringOf(rank) .. self.name; end
function Legacy:GetCurrentModifierValueString()	return self:GetModifierValueStringOf( self.rank ); end
function Legacy:GetCurrentModifierString() return self:GetModifierStringOf( self.rank ) end
function Legacy:GetTotalCurrentCost() return self:GetTotalCostOf( self.tier, self.rank ); end
function Legacy:IsActive() return self.active end

function Legacy:SetActive( status ) self.active = status; self.Changed(); end

function Legacy:GetMaxTier()
	if self:IsDefault() then
		return 1;
	else
		return 6;
	end
end

-- returns how many ranks a legacy has at a given level/age
function Legacy:GetMaxRankLA( level, age )
	if type( self.maxRank ) == "number" then
		return self.maxRank;
	elseif type( self.maxRank ) == "function" then
		return self.maxRank( level, age );
	else
		return 9; -- legacies have 9 ranks by default
	end
end

-- returns the cost of a legacy at a given level, age, tier & rank
function Legacy:GetCostOfLA( level, age, tier, rank )
	if rank == 1 then return 0 end; -- rank 1 is always free
	
	-- Turbine.Log:Information( self.name );

	if type(self.costs) == "table" then
		return self.costs[tier][rank-1];
	elseif type(self.costs) == "function" then
		return self.costs( level, age, tier, rank );
	end
	
	return 0; -- default, shouldn't happen
end

-- returns the modifier value of a legacy at a given level, age & rank
function Legacy:GetModifierValueOfLA( level, age, crystals, rank )
	if type( self.modifiers ) == "table" then
		return self.modifiers[rank];
	elseif type( self.modifiers ) == "function" then
		return self.modifiers( level, age, crystals, rank );
	end
	
	return 0; -- default, shouldn't happen
end



-- set the rank of a legacy
-- not testing bounds
function Legacy:SetRank( rank ) 
	if self.rank ~= rank then
		self.rank = math.min( self:GetMaxRank(), rank );
		self.Changed();
		-- self.CostChanged();
	end
end

-- set the tier of a legacy
-- not testing bounds
function Legacy:SetTier( tier ) 
	if self.tier ~= tier then
		self.tier = tier;
		self.Changed();
		-- self.CostChanged();
	end
end

-- Get the total cost of a legacy of tier <tier> at rank <rank>
function Legacy:GetTotalCostOf( tier, rank )
	local total = 0;
	for i = 2, rank do
		total = total + self:GetCostOf( tier, i );
	end
	return total;
end

-- Returns whether a legacy is the default legacy for a legendary item (DPS, Tactical Damage Rating etc)
function Legacy:IsDefault()	
	return not ( self.type == Type.Minor or self.type == Type.Major or self.type == Type.Stat ); 
end

local ModFormat = {
	[Equendil.LIP.Modifier.Number] = "%+g ",
	[Equendil.LIP.Modifier.Percent] = "%+g%% ",
	[Equendil.LIP.Modifier.Cooldown] = "%+g ",
	[Equendil.LIP.Modifier.Resist] = "%+d ",
	[Equendil.LIP.Modifier.Mitigation] = "%+d ",
	[Equendil.LIP.Modifier.Rating] = "%+g ",
	[Equendil.LIP.Modifier.DPS] = "%g ",
	[Equendil.LIP.Modifier.Duration] = "+%g ",
	[Equendil.LIP.Modifier.Range] = "%+g "
}

function Legacy:GetModifierValueStringOf( rank )
	local modifier = self:GetModifierValueOfLA( self.level, self.age, self.crystals, rank );

	-- cooldown reducations are entered as positive values for convenience, so reversing that here
	if self.modifierType == Equendil.LIP.Modifier.Cooldown then
		modifier = -modifier;
	end
	
	if ( modifier == -1 ) and (
		( self.type == Equendil.LIP.Type.DPS ) or  
		( self.type == Equendil.LIP.Type.TacticalDamageRating ) or  
		( self.type == Equendil.LIP.Type.TacticalHealingRating ) or  
		( self.type == Equendil.LIP.Type.IncomingHealingRating ) or  
		( self.type == Equendil.LIP.Type.ShieldUse )
	) then
		return "? ";
	end
	
	
	return string.format( ModFormat[self.modifierType], modifier );
end
