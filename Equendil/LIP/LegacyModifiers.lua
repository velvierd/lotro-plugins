-- Various rating tables & functions in use by a number of legacies

-- number of possible modifiers from lvl 51 3rd age to lvl 85 second age for adjustable modifiers
local LevelAgeAdjustRanks = 55; -- (49 up to level 85 nd age + crystals, 55 presumed for 1st ages)

-- RATING TABLES

-- Creates a table of values for Adjust.LevelRangeAge, starting from <base>, each successive value is increased by <increment>
ModifierTableRating = function( base, increment ) 
	local tab = {};
	for i = 1, LevelAgeAdjustRanks do
		tab[i] = base + ( ( i - 1 ) * increment );
	end
	
	return tab;
end

NegTable = function( tab )
	local newtab = {};
	for i = 1, #tab do
		newtab[i] = -tab[i];
	end
	return newtab;
end

-- values from lvl 51 3rd age rank 1 to lvl 75 1st age rank 12 (with star-lit crystals). 36 values total

-- Most Rating legacies use that one
ModifierTableRating207_19 = {
	207,226,245,264,283,302,321,340,359,378,
	397,416,435,454,473,492,511,530,536,544,
	552,560,568,576,584,592,600,608,616,624,
	632,640,648,656,664,672,680,688,696,704,
	712,720,728,736,744,752,760,768,776,
	784,792,800,808,816,824 -- extrapolated for level 85 1st ages
};

ModifierTableRating460_50 = {
	460,510,560,610,660,710,760,810,860,910,
	960,1010,1060,1110,1160,1210,1260,1280,1300,1320,
	1340,1360,1380,1400,1420,1440,1460,1480,
	1500,1520,1540,1560,1580,1600,1620,1640,1660, -- extrapolated
	1680,1700,1720,1740,1760,1780,1800,1820,1840, -- 1840 extrapolated
	1860,1880,1900,1920,1940,1960,1980,2000,2020 -- extrapolated for crystals & level 85 1st ages
}; 

ModifierTableRating1105_105 = { -- 36 ranks atm TODO
	1105,1210,1315,1420,1525,1630,1735,1840,1945,2050,
	2155,2260,2365,2470,2575,2680,2785,2890,2995,3036,
	3080,
	3124,3168,3212,3256,3300,3344,3388, -- extrapolated
	3432,3476,3520,3564,3608,3652,3696,3740,
	3784, -- extrapolated,
	3828,3872,3916,3960,4004,4048,4092,4136,4180,
	4224,4268,4312,4356,4400,4444,4488,4532,4576 -- extrapolated for crystals and level 85 1st ages
}; 

ModifierTableThreat = ModifierTableRating(1,1);

ModifierTableRating207_19_neg = NegTable( ModifierTableRating207_19 );
ModifierTableRating460_50_neg = NegTable( ModifierTableRating460_50 );
ModifierTableRating1105_105_neg = NegTable( ModifierTableRating1105_105 );
ModifierTableThreat_neg = NegTable( ModifierTableThreat );

-- MODIFIER VALUES OF DEFAULT LEGACIES

-- TACTICAL HEALING RATING
ModifierTableTacticalHealingRating = {
	{ -- Tactical Healing 1st age
		0.5,0.75,0.9,1,2,3,4,5,6,
		7,8, 									-- lvl 58+
		9,10,11,12,13,							-- lvl 60+
		14,15,16,17,18,19,20,					-- lvl 65+
		21,22,23,								-- ... +crystals
		24,25,26,27,28,29,30,31,32,--[[33--]]		-- extrapolated, for some reason, shifts values by 1, same as Tactical Damage, TODO 
		34,35.4,36.08,36.76,37.44,38.12,38.8,	-- lvl 75+
		39.48,40.16,40.84,						-- ... +crystals
		41.52,42.2,42.88,43.56,44.24,44.92,45.6,46.28,46.96,47.64,48.32, -- extrapolotion from 3rd & 2nd age progression
		-1,-1,-1,-1,-1,-1,-1,-1					-- lvl 85 extension
	},
	{ -- Tactical Healing: 2nd age
		0.5,0.75,0.9,1,2,3,4,5,6,7,
		8,9,10,11,12,							-- lvl 60+
		13,14,15,16,17,18,19,					-- lvl 65+
		20,21,22,								-- ... +crystals
		23,24,25,26,							-- extrapolated
		27,28,29,30,31,32,33,					-- lvl 75+
		34.04,34.72,35.4,36.08,36.76,37.44, 	-- ... +crystals
		38.12,38.8,39.48,40.16,40.84,41.52, 	-- extrapolated (from 3rd age progression)
		42.2,42.88,43.56,44.24,44.92,45.6,46.28, -- lvl 85+
		46.96,47.64,48.32						-- ... +crystals
	},
	{ -- Tactical Healing: 3rd age
		0.5,0.75,0.9,1,2,3,4, 					-- lvl 51+
		5,6, 									-- lvl 58 +
		7,8,9,10,11, 							-- lvl 60+
		12,13,14,15,16,17,18, 					-- lvl 65+
		19,20,21, 								-- lvl 72+
		22,23,24,25,26,27,28, 					-- lvl 75+
		29,30,31,32,32.68, 						-- lvl 75 + crystals
		-1,34.04,								-- ? TODO missing value
		34.72,35.4,36.08,36.76,37.44, 			-- lvl 80+
		38.12,38.8,39.48,40.16,40.84,41.52,42.2, -- lvl 85 +
		42.88,43.56,44.24 -- lvl 85 + crystals
	}
};

-- TACTICAL DAMAGE RATING
ModifierTableTacticalDamageRating = {
	{ -- Tactical Damage Rating: 1st age
		0.5,0.75,0.9,1,2,3,4,5,6,
		7,8,									-- lvl 58+
		9,10,11,12,13,							-- lvl 60+
		14,15,16,20.9,23,25.3,27.8,				-- lvl 65+
		30.4,33,35.6,							-- ... + crystals
		38.2,40.8,43.4,46,48.6,51.2,			-- extrapolated from 2nd & 3rd age progression
		53.8,54.93,56.06,--[[57.19--]]				-- extrapolated from 2nd & 3rd age progression, for some reason that shifts level 75 values by 1, 
		--TODO, maybe split in separate tables too ...
		58.32,59.45,60.58,61.71,62.84,63.97,65.1, -- lvl 75+
		66.23,67.36,68.49,						-- ... +crystals
		69.62,70.75,71.88,73.01,74.14,			-- extrapolated from 2nd & 3rd age progression
		75.27,76.4,77.53,78.66,79.79,80.92,		-- extrapolated from 2nd age progression
		-1,-1,-1,-1,-1,-1,-1,-1					-- lvl 85 extension
	}, { -- Tactical Damage Rating : 2rd age
		0.5,0.75,0.9,1,2,3,4,5,6,7,
		8,9,10,11,12,							-- lvl 60+
		13,14,15,17.6,19.1,20.9,23, 			-- lvl 65+
		25.3,27.8,30.4,							-- ... + crystals
		33,35.6,38.2,40.8, 						-- extrapolated from 3rd age progression
		43.4,46,48.6,51.2,53.8,54.93,56.06,		-- lvl 75+
		57.19,58.32,59.45,60.58,61.71,62.84,	-- ... + crystals
		63.97,65.1,66.23,67.36,68.49,69.62,		-- extrapolated from 3rd age progression
		70.75,71.88,73.01,74.14,75.27,76.4,77.53, -- lvl 85+
		78.66,79.79,80.92						-- ... + crystals
	}, { -- Tactical Damage Rating: 3rd age
		0.5,0.75,0.9,1, 						-- lvl 51+
		2,3,4,5,6, 								-- lvl 55+
		7,8,9,10,11,							-- lvl 60+
		12,13,14,15.1,16.3,						-- lvl 65+
		17.6,19.1,20.9,23,25.3,					-- lvl 70+
		27.8,30.4,33,35.6,38.2,40.8,43.4, 		-- lvl 75+
		46,48.6,								-- ... +crystal
		51.2,53.8,54.93,56.06,57.19,			-- lvl 76+ (& end of lvl 75 crystals)
		58.32,59.45,60.58,61.71,62.84,			-- lvl 80+
		63.97,65.1,66.23,67.36,68.49,69.62,70.75, -- lvl 85+
		71.88,73.01,74.14						-- ... +crystals
	}, 
};

-- SHIELD USE RATING 
ModifierTableShieldUseRating = ModifierTableTacticalDamageRating;

-- 1H DPS
ModifierTableDPS1H = { -- DPS tables for one handed weapons
	{ -- 1H DPS lvl 51-65
		{ -- 1H DPS, 1st age lvl 51-65
			-1,-1,-1,-1,-1,-1,-1,-1,50.8,				-- lvl 51+
			52.8,54.8,56.9,58.4,60.0,					-- lvl 60+
			61.5,63.0,64.6,67.8,71.2,74.8,78.3,			-- lvl 65
			81.9,85.4,89.0,								-- ... + crystals
		},
		{ -- 1H DPS, 2nd age, lvl 51-65
			-1,-1,										-- lvl 51+
			38.5,39.4,40.6,41.7,43.8,46.0,48.3,			-- lvl 53+
			50.1,52.1,54.1,55.5,57.0,					-- lvl 60+
			58.4,59.9,61.3,64.4,67.6,71.0,74.4,			-- lvl 65
			77.8,81.2,84.5								-- ... + crystals
		}, 
		{ -- 1H DPS, 3rd age, lvl 51-65
			35.7,36.4,37.1,38.0, 
			39.0,40.1,42.1,44.2,46.5,					-- lvl 55+
			48.3,50.1,52.0,53.4,54.8,					-- lvl 60+
			56.2,57.6,59.0,62.0,65.1,68.3,71.6,			-- lvl 65
			74.9,78.1,81.4								-- ... + crystals
		}
	},
	{ -- 1H DPS, lvl 66-75
		{ -- 1H DPS, 1st age lvl 66-75
			-1,-1,-1,-1,-1,-1,-1,-1,-1,
			128.1,128.8,129.6,130.3,131.1,131.8,132.6, 	-- lvl 75
			133.3,134.1,134.8							-- ... + crystals
		},
		{ -- 1H DPS, 2nd age, lvl 66-75
			-1,-1,-1,-1,-1,-1,-1,-1,-1,
			99.6,103.2,106.8,110.3,113.9,117.4,121.0,	-- lvl 75
			124.5,128.1,128.8,129.6,130.3,131.1,		-- ... + crystals
		},
		{ -- 1H DPS - third age - lvl 66-75
			57.6,59,62,64, 								-- lvl 66+ (check first value)
			66.9,70.0,72.9,77.1,79.4,					-- lvl 70+
			83.6,87.9,91.1,94.4,97.6,100.9,104.1,		-- lvl 75
			107.4,110.6,113.9,117.1,120.4,				-- ... + crystals
		}			
	},
	{ -- 1H DPS, lvl 76+
		{ -- 1H DPS, 1st age lvl 76+
			-1,-1,										-- lvl 76+
			-1,-1,-1,-1,-1,-1,-1,-1,					-- lvl 77+					
			-1,-1,-1,-1,-1,-1,-1,						-- lvl 85
			-1,-1,-1									-- ... + crystals
		},
		{ -- 1H DPS, 2nd age lvl 76+
			-1,-1,										-- lvl 76+ 
			-1,-1,-1,-1,-1,-1,-1,-1,					-- lvl 77+
			136.3,137.1,137.8,138.6,139.3,140.1,140.8, 	-- lvl 85
			141.6,142.3,143.1							-- ... + crystals
		},
		{ -- 1H DPS, 3rd age lvl 76+
			113.9,117.1,120.4,123.6,126.9,				-- lvl 76+ (first two values from progression at lvl 66-75)
			127.3,128.8,129.6,130.3,131.1,				-- lvl 80+
			131.8,132.6,133.3,134.1,134.8,135.6,136.3,	-- lvl 85
			137.1,137.8,138.6							-- ... + crystals
		}
	}
};

-- 2H DPS
ModifierTableDPS2H = { -- DPS tables for bows, crossbows, javelins & any two handed weapon
	{ -- 2H DPS 1st age
		-1,-1,											-- padding
		-1,-1,-1,-1,-1,-1,-1,-1,						-- lvl 51+
		57.6,											-- lvl 59+
		59.8,62.1,64.5,66.2,68.0,						-- lvl 60+
		69.7,71.4,73.2,76.8,80.7,84.7,88.8, 			-- lvl 65
		92.8,96.8,100.9,								-- ... + crystals
		-1,-1,-1,-1,-1,-1,-1,-1,-1,						--
		145.2,146.0,146.7,147.5,148.2,149.0,149.7,		-- lvl 75
		150.5,151.2,152.0,								-- ... + crystals
		152.7,153.5,154.2,155,155.7,156.5,				-- extrapolated from 3rd and 2nd age progression
		157.2,158.0,158.7,159.5,160.2,					-- extrapolated from 3rd and 2nd age progression
		-1,-1,-1,-1,-1,-1,-1,-1							--
	}, 
	{ -- 2H DPS 2nd age
		-1,												-- padding
		-1,-1,											-- lvl 51+
		42.4,44.7,46.0,47.3,49.6,52.1,54.7,				-- lvl 53+ (42.4 extrapolated)
		56.8,59.0,61.3,62.9,64.6,						-- lvl 60+
		66.2,67.9,69.5,73.0,76.7,80.5,84.3, 			-- lvl 65
		88.1,92.0,95.8,									-- ... +crystals
		99.6,103.5,107.3,111.2, 						-- extrapolated
		115.0,118.8,122.6,126.5,130.3,134.1,137.9,		-- lvl 75
		141.8,145.6,146.0,146.7,147.5,148.2, 			-- ... +crystals
		149.0,149.7,150.5,151.2,152,152.7,				-- extrapolated from 3rd age progression
		153.5,154.2,155,155.7,156.5,157.2,158,			-- lvl 85
		158.7,159.5,160.2								-- ... +crystals
	}, 
	{ -- 2H DPS 3rd age
		40.7,41.4,42.2,43.0,							-- lvl 51+
		44.2,45.5,47.8,50.1,52.7,						-- lvl 55+
		54.7,56.8,59.0,60.6,62.1,						-- lvl 60+
		63.7,65.3,66.9,70.3,73.8,						-- lvl 65+
		77.5,81.1,84.8,88.5,92.9,						-- lvl 70+
		95.9,99.6,103.3,107.0,110.6,114.3,118.0,		-- lvl 75
		121.7,125.4,									-- ... +1 crystal
		129.1,132.8,136.4,140.1,141.8,					-- lvl 76+ (one additional shift at 77, hence 5 values)
		145.6,146.0,146.7,147.5,148.2,					-- lvl 80+
		149.0,149.7,150.5,151.2,152,152.7,153.5,		-- lvl 85
		154.2,155.0,155.7								-- ... + crystals
	}
};

local ModifierTableFury = {
	169,338,507,676,845,1014,1183,1352,1521,1690,
	1859,2028,2197,2366,2535,2704,2873,3042,3211,3380,
	3549,3718,3887,4056,4225,4394,4563,4732,4901,5070,
	5239,5408,5577,5746,
	5915,6084,6253,6422,6591,6760 -- extrapolated for first ages
};

-- Adjust functions 

-- returns the number of "free" ranks a legacy gets at a given level & age
local AgeBonus = function( level, age )
	local bonus = 3 - age;
	if level >= 75 then
		if age == 2 then
			bonus = bonus + 4;
		elseif age == 1 then
			bonus = bonus + 9;
		end
	end
	return bonus;
end	

local CrystalsBonus = function( level, age, crystals )
	-- crystals add 1 virtual 'rank' to items, but for the following exceptions:
	-- level 75 2nd age LIs gain 2 'ranks' per crystal
	-- level 70 and 75 3rd age LIs gain 2 'ranks' with the first crystal, 1 'rank' with the second, another two 'ranks' with the third
	-- The same probably applies to all LIs between level 66 and 75 (TODO check)
	local bonus = crystals;
	if (level > 65) and (level <= 75) then -- TODO: check lvl 66-69 & 71-75
		if age == 2 then
			-- crystals on level 75 2nd ages give 2/2/2 'ranks'
			bonus = bonus * 2;
		elseif age == 3 then
			-- crystals on level 75 third ages give 2/1/2 'ranks'
			if crystals >= 1 then
				bonus = bonus + 1;
			end
			if crystals == 3 then
				bonus = bonus + 1;
			end
		end
	end
	return bonus;
end

local LevelBonus = function( level )
	if level == 76 then
		return 8;
	elseif level > 76 then
		return 9;
	else
		return 0;
	end
end

-- Modifiers shifted according to the default shifting mechanism
-- (most rating & threat rating legacies)

-- 'shifts' occur at certain level until 65 then every level
local LevelRangeBonus = function( level )
	if level < 54 then
		return 0;
	elseif level < 58 then
		return 1;
	elseif level < 65 then
		return 2;
	else
		return level - 65 + 3;
	end
end

ModAdjustForLevelRangeAndAge = function( modifiers )
	return function( level, age, crystals, rank )
		local bonus = LevelRangeBonus(level + CrystalsBonus( level, age, crystals )) + LevelBonus( level ) + AgeBonus( level, age );

		return modifiers[bonus + rank];
	end
end
	
-- DPS rating for 1h LIs
ModAdjustDPS1H = function( modifiers )
	return function( level, age, crystals, rank )
		if level <= 65 then
			local bonus = level - 51 + CrystalsBonus( level, age, crystals );
			return modifiers[1][age][bonus + rank];
		elseif level <= 75 then
			local bonus = level - 66 + CrystalsBonus( level, age, crystals );
			return modifiers[2][age][bonus + rank];
		else
			local bonus = level - 76 + CrystalsBonus( level, age, crystals );
			if level > 76 then
				bonus = bonus + 1; -- LIs get shifted one further point at lvl 77 for some reason
			end
			return modifiers[3][age][bonus + rank];
		end
	end
end

-- (DPS rating for 2H LIs, Tactical Damage Rating, Shield Use), Tactical Healing Rating
ModAdjustForLevelPerAge = function( modifiers )
	return function( level, age, crystals, rank )
		local bonus = level - 51 + LevelBonus( level ) + AgeBonus( level, age ) + CrystalsBonus( level, age, crystals );
		return modifiers[age][bonus + rank];
	end
end

-- (Incoming Healing Rating)
local IncHealingFunc = function( level, baseRating )
	local ratio = ((13/12)-1)/5;
	local rating = (1+((level-60)*ratio)) * baseRating;
	local ceil = math.ceil( rating );
	if	( ceil - rating ) > 0.5 then
		return math.floor( rating );
	else 
		return ceil;
	end
end

local IncHealingBaseRatings = -- ratings at level 60
{
	{720,920,1120,1320,1520,1720,1920},	-- first age
	{480,680,880,1080,1280,1480,1680}, -- second age
	{240,440,640,840,1040,1240,1440} -- third age
};

ModIncHealing = function()
	return function( level, age, crystals, rank )
		local bonus = CrystalsBonus( level, age, crystals ) + LevelBonus( level );
		-- adjust for age 'jumps' at lvl 75+
		if level >= 75 then
			if age == 2 then
				bonus = bonus + 4;
			elseif age == 1 then
				bonus = bonus + 10; -- note the +10, another 'jump' on lvl 75 first ages, see also tactical damage and tactical healing rating tables
			end
		end
		
		return IncHealingFunc( level + bonus, IncHealingBaseRatings[age][rank] );
	end
end

ModFury = function()
	return function( level, age, crystals, rank )
		local bonus = CrystalsBonus( level, age, crystals ) + LevelBonus( level );
		bonus = bonus + AgeBonus( level, age );
		-- seems this is yet another one of those ratings that don't entirely make sense from 3rd to 2nd to 1st age, shifting -1 for 2nd ages 
		if age == 2 then
			bonus = bonus - 1;
		end
		return ModifierTableFury[level - 75 + bonus + rank];
	end
end