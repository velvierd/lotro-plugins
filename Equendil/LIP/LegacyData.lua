import "Equendil.LIP.LegacyCosts";
import "Equendil.LIP.LegacyModifiers";

-- Type of a legendary item
LIType = {
	Primary = 0,
	Secondary = 1,
	Bridle = 2
};

-- Type of a legacy
Type = { 
	None = 0, 
	Minor = 1, 
	Major = 2, 
	Stat = 3,
	-- default legacies below
	DPS = 4, 
	TacticalDamageRating = 5, 
	TacticalHealingRating = 6, 
	IncomingHealingRating = 7, 
	ShieldUse = 8,
	Deprecated = 9,
	FuryBonusContributionRating = 10,
};

-- Modifier type of a legacy, mostly for conveniance in entering data as numeric values rather than strings
Modifier = { 
	None = 0, 
	Number = 1, 
	Percent = 2, 
	Cooldown = 3, 
	Resist = 4, 
	Mitigation = 5, 
	Rating = 6, 
	DPS = 7, 
	Duration = 8, 
	Range = 9
};

-- BRIDLE LEGACIES

local FuryBonusContributionRating = 
{
	name = L["Fury Bonus Contribution Rating"],
	type = Type.FuryBonusContributionRating,
	modType = Modifier.Rating,
	mod = ModFury(),
	cost = CostTableDefault,
	maxRank = 7,
};
	
local BridleLegacyRedDawnSkillDirectDamage = {
	name = L["Red Dawn Skill Direct Damage"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
	cost = CostTable36, -- checked T3,T5,T6
};

local BridleLegacyRedDawnSkillHealing = {
	name = L["Red Dawn Skill Healing"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10},
	cost = CostTable36, --  checked T3
};

local BridleLegacyRedDawnSkillPowerCost = {
	name = L["Red Dawn Skill Power Cost"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {-1,-2.125,-3.25,-4.375,-5.5,-6.625,-7.75,-8.875,-10},
	cost = CostTable36, -- checked T2,T5
};

local BridleLegacyRiddermarkSkillDirectDamage = {
	name = L["Riddermark Skill Direct Damage"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
	cost = CostTable36, -- checked T3,T4
};

local BridleLegacyRiddermarkSkillHealing = {
	name = L["Riddermark Skill Healing"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10},
	cost = CostTable36, -- checked T1,T2,T3
};
	
local BridleLegacyRiddermarkSkillPowerCost = {
	name = L["Riddermark Skill Power Cost"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {-1,-2.125,-3.25,-4.375,-5.5,-6.625,-7.75,-8.875,-10},
	cost = CostTable36, -- checked T3
};

local BridleLegacyRohirrimSkillDirectDamage = {
	name = L["Rohirrim Skill Direct Damage"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
	cost = CostTable36 -- checked T3,T5
};


local BridleLegacyRohirrimSkillHealing = {
	name = L["Rohirrim Skill Healing"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10},
	cost = CostTable36, -- checked T3, T4,T5,T6
};

local BridleLegacyRohirrimSkillPowerCost = {
	name = L["Rohirrim Skill Power Cost"],
	type = Type.Minor,
	modType = Modifier.Percent,
	mod = {-1,-2.125,-3.25,-4.375,-5.5,-6.625,-7.75,-8.875,-10},
	cost = CostTable36, -- checked T3
};

local BridleLegacyWarsteedAgility = {
	name = L["War-steed Agility"],
	type = Type.Minor,
	modType = Modifier.Number,
	mod = {8,16,24,32,41,49,57,66,74},
	cost = CostTable23, -- checked T2,T3,T4
};

local BridleLegacyWarsteedStrength = {
	name = L["War-steed Strength"],
	type = Type.Minor,
	modType = Modifier.Number,
	mod = {8,16,24,32,41,49,57,66,74},
	cost = CostTable23, -- checked T2
};

local BridleLegacyWarsteedArmour = {
	name = L["War-steed Armour"],
	type = Type.Minor,
	modType = Modifier.Number,
	mod = {50,100,150,200,250,300,350,400,450},
	cost = CostTable23, -- checked T1,T2,T5
};

local BridleLegacyWarsteedEvadeRating = {
	name = L["War-steed Evade Rating"],
	type = Type.Minor,
	modType = Modifier.Number,
	mod = {117,233,350,467,583,700,817,933,1050},
	cost = CostTable23, -- checked @ T3,T4,T5
};

local BridleLegacyMaximumWarsteedEndurance = {
	name = L["Maximum War-steed Endurance"],
	type = Type.Minor,
	modType = Modifier.Number,
	mod = {112,223,334,445,556,667,778,889,1000},
	cost = CostTable23, -- checked T4
};

local BridleLegacyMaximumWarsteedPower = {
	name = L["Maximum War-steed Power"],
	type = Type.Minor,
	modType = Modifier.Number,
	mod = {112,223,334,445,556,667,778,889,1000},
	cost = CostTable23, -- checked @ T2,T4,T6
};



local BridleLight = 
{
	name = L["Light Bridle"],
	liType = LIType.Bridle,	
	defaultLegacy = FuryBonusContributionRating,
	legacies =
	{
		{
			name = L["Class Skill Damage Over Time (Light Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
			cost = CostTable32, -- checked T1,T2, T3,T5
		},{
			name = L["Class Skill Dismount Chance (Light Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2,3,4,5},
			cost = CostTableBridle63,
			maxRank = 5
		},{
			name = L["Rider Evade Chance (Light Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2,3,4,5},
			cost = CostTableBridle63,
			maxRank = 5
		},{ -- Red Dawn
			name = L["'Wrath' Critical Chance (Light Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10},
			cost = CostTable27, -- checked T4
		},{ -- Riddermark
			name = L["'Disengaging Strikes' Dismount Chance (Light Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2,3,4,5},
			cost = CostTableBridle54,
			maxRank = 5
		},{ -- Rohirrim
			name = L["'Motivation Through Agression' Heal Chance (Light Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2,3,4,5},
			cost = CostTableBridle54,
			maxRank = 5
		},
		-- minor legacies, common to all bridle types
		BridleLegacyRedDawnSkillDirectDamage,
		BridleLegacyRedDawnSkillHealing,
		BridleLegacyRedDawnSkillPowerCost,
		BridleLegacyRiddermarkSkillDirectDamage,
		BridleLegacyRiddermarkSkillHealing,
		BridleLegacyRiddermarkSkillPowerCost,
		BridleLegacyRohirrimSkillDirectDamage,
		BridleLegacyRohirrimSkillHealing,
		BridleLegacyRohirrimSkillPowerCost,
		BridleLegacyWarsteedAgility,
		BridleLegacyWarsteedStrength,
		BridleLegacyWarsteedArmour,
		BridleLegacyWarsteedEvadeRating,
		BridleLegacyMaximumWarsteedEndurance,
		BridleLegacyMaximumWarsteedPower,
	}
}
	
local BridleMedium = 
{
	name = L["Medium Bridle"],
	liType = LIType.Bridle,	
	defaultLegacy = FuryBonusContributionRating,
	legacies =
	{
		{
			name = L["Class Skill Damage Over Time Pulses (Medium Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2,3,4,5,6,7,8,9},
			cost = CostTable63, -- checked T3
		},{
			name = L["Class Skill Slow Duration (Medium Steed)"],
			type = Type.Major,
			modType = Modifier.Duration,
			mod = {1,2,3,4,5},
			cost = CostTable63, -- checked T3 TODO double check R1 halved ?
			maxRank = 5
		},{
			name = L["Rider Parry Chance (Medium Steed"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2,3,4,5},
			cost = CostTableBridle63,
			maxRank = 5
		},{ -- Red dawn 
			name = L["'Shields Will Be Splintered' Damage (Medium Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10},
			cost = CostTable27 -- checked T4, T5
		},{ -- Riddermark
			name = L["'Strong Willed' Skill Duration (Medium Steed)"],
			type = Type.Major,
			modType = Modifier.Duration,
			mod = {1,2,3,4,5},
			cost = CostTable54, -- checked lvl 76 3rd age T3
			maxRank = 5
		},{ -- Rohirrim
			name = L["'Survivability' Damage Shield Chance (Medium Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2,3,4,5},
			cost = CostTableBridle54,
			maxRank = 5
		},
		BridleLegacyRedDawnSkillDirectDamage,
		BridleLegacyRedDawnSkillHealing,
		BridleLegacyRedDawnSkillPowerCost,
		BridleLegacyRiddermarkSkillDirectDamage,
		BridleLegacyRiddermarkSkillHealing,
		BridleLegacyRiddermarkSkillPowerCost,
		BridleLegacyRohirrimSkillDirectDamage,
		BridleLegacyRohirrimSkillHealing,
		BridleLegacyRohirrimSkillPowerCost,
		BridleLegacyWarsteedAgility,
		BridleLegacyWarsteedStrength,
		BridleLegacyWarsteedArmour,
		BridleLegacyWarsteedEvadeRating,
		BridleLegacyMaximumWarsteedEndurance,
		BridleLegacyMaximumWarsteedPower,
	}
}


local BridleHeavy = 
{
	name = L["Heavy Bridle"],
	liType = LIType.Bridle,
	defaultLegacy = FuryBonusContributionRating,
	legacies =
	{
		{
			name = L["Rider Armour Value (Heavy Steed)"],
			type = Type.Major,
			modType = Modifier.Number,
			mod = {133,266,399,532,666,799,932,1066,1199},
			cost = CostTable32 -- checked T3
		},{
			name = L["Class Skill Forced Movement Duration (Heavy Steed)"],
			type = Type.Major,
			modType = Modifier.Duration,
			mod = {1,2,3,4,5},
			cost = CostTable63, -- checked T2,T4
			maxRank = 5
		},{
			name = L["Rider Block Chance (Heavy Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2,3,4,5},
			cost = CostTableBridle63,
			maxRank = 5,
		},{ -- Red Dawn
			name = L["'Spears Will Be Shaken' Slow Duration (Heavy Steed)"],
			type = Type.Major,
			modType = Modifier.Duration,
			mod = {1,2,3,4,5,6,7,8,10},
			cost = CostTable27, -- checked at T5
		},{ -- Riddermark
			name = L["'Conservative Combatant' Power Cost (Heavy Steed)"],
			type = Type.Major,
			modType = Modifier.Percent,
			mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10},
			cost = CostTable27, -- checked T2
		},{ -- Rohirrim
			name = L["'Benevolence' Healing Rating (Heavy Steed)"],
			type = Type.Major,
			modType = Modifier.Rating,
			mod = {624,632,640,648,656,664,672,680,688},
			cost = CostTable36 -- checked T5
		},
		BridleLegacyRedDawnSkillDirectDamage,
		BridleLegacyRedDawnSkillHealing,
		BridleLegacyRedDawnSkillPowerCost,
		BridleLegacyRiddermarkSkillDirectDamage,
		BridleLegacyRiddermarkSkillHealing,
		BridleLegacyRiddermarkSkillPowerCost,
		BridleLegacyRohirrimSkillDirectDamage,
		BridleLegacyRohirrimSkillHealing,
		BridleLegacyRohirrimSkillPowerCost,
		BridleLegacyWarsteedAgility,
		BridleLegacyWarsteedStrength,
		BridleLegacyWarsteedArmour,
		BridleLegacyWarsteedEvadeRating,
		BridleLegacyMaximumWarsteedEndurance,
		BridleLegacyMaximumWarsteedPower,
	}
}
	
-- COMPLETE LISTING OF LEGACIES FOR EACH CLASS BELOW

local TacticalDamageRating = {
	name = L["Tactical Damage Rating"],
	type = Type.TacticalDamageRating,
	modType = Modifier.Rating,
	mod = ModAdjustForLevelPerAge( ModifierTableTacticalDamageRating ),
	cost = CostTableDefault,
	maxRank = 7,
};

local ShieldUseRank = {
	name = L["Shield Use Rank"],
	type = Type.ShieldUse,
	modType = Modifier.Rating,
	mod = ModAdjustForLevelPerAge( ModifierTableShieldUseRating ),
	cost = CostTableDefault,
	maxRank = 7,
};

local TacticalHealingRating = {
	name = L["Tactical Healing Rating"],
	type = Type.TacticalHealingRating,
	modType = Modifier.Rating,
	mod = ModAdjustForLevelPerAge( ModifierTableTacticalHealingRating ),
	cost = CostTableDefault,
	maxRank = 7,
};

local DPS1HRating = {
	name = L["DPS"],
	type = Type.DPS,
	modType = Modifier.Rating,
	mod = ModAdjustDPS1H( ModifierTableDPS1H ),
	cost = CostTableDefault,
	maxRank = 7,
};

local DPS2HRating = {
	name = L["DPS"],
	type = Type.DPS,
	modType = Modifier.DPS,
	mod = ModAdjustForLevelPerAge( ModifierTableDPS2H ),
	cost = CostTableDefault,
	maxRank = 7,
};

local IncomingHealingRating = {
	name = L["Incoming Healing Rating"],
	type = Type.IncomingHealingRating,
	modType = Modifier.Rating,
	mod = ModIncHealing(),
	cost = CostTableDefault,
	maxRank = 7,
};

LegaciesMinstrel = 
{
	{
		name = L["Weapon"],
		defaultLegacy = TacticalDamageRating,
		legacies = --  checked all legacies for RoR
		{
			{ 	-- RoR: "Call of Orome Damage" renamed "Oromë and Eärendil Damage"
				name = L["Oromë and Eärendil Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {2,4.2,6.5,8.7,11,13.2,15.5,17.7,20},
				cost = CostTable36
			}, {
				name = L["Story of Courage Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,4,8,11,15,19,22,26,30},
				cost = CostTable18
			},{ -- U5 changes
				name = L["Call of the Second Age Targets"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget1,
				maxRank = 5
			},{
				name = L["Call to Fate Critical Multiplier"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			},{
				name = L["Still as Death Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,19,33,48,62,76,91,105,120},
				cost = CostTable27
			},{ -- U5 changes
				name = L["Soliloquy of Spirit Pulses"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2,4,5,7,8,10,12,14},
				cost = CostTable27
			}, {
				name = L["Rally! Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {10,46,82,118,155,191,227,263,300},
				cost = CostTable27
			}, {
				name = L["Minor Ballad Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {2,5.5,9,12.5,16,19.5,23,26.5,30},
				cost = CostTable27
			}, {
				name = L["Perfect Ballad Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {2,5.5,9,12.5,16,19.5,23,26.5,30},
				cost = CostTable27
			}, {
				name = L["Piercing Cry Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {2,5.5,9,12.5,16,19.5,23,26.5,30},
				cost = CostTable27
			}, {
				name = L["Target Resist Rating (Call to War)"],
				type = Type.Major,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating460_50_neg ),
				cost = CostTable27
			}, {
				name = L["Triumphant Spirit Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {5,19.37,33.75,48.12,62.5,76.87,91.25,105.62,120}, -- RoR values
				-- mod = {5,19.4,33.8,48.1,62.5,76.9,91.3,105.6,120},
				cost = CostTable18
			}, {
				name = L["Target Resist Rating (Invocation of Elbereth)"],
				type = Type.Minor,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating460_50_neg ),
				cost = CostTable27
			}, {
				name = L["Anthem Duration"],
				type = Type.Major,
				modType = Modifier.Duration,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				-- mod = {1,2.1,3.3,4.4,5.5,6.6,7.8,8.9,10},
				cost = CostTable36,
			}, {
				name = L["Healing Threat"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable36
			}
		}
	},
	{
		name = L["Song book"],
		defaultLegacy = TacticalHealingRating,
		legacies = -- checked all legacies for RoR
		{
			{	-- RoR: "Anthem of War (Ranged Damage)"] replaced with "Hammerhand Skills Bubble Magnitude"
				name = L["Hammerhand Skills Bubble Magnitude"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,4,7,10,13,16,19,22,25},
				cost = CostTable36 -- checked @ T2, should match all
				--[[
				--RoI changes
				name = L["Anthem of War (Ranged Damage)"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable27
				--]]
			}, {
				name = L["Anthem of Composure (Resistance)"],
				type = Type.Minor,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27
			}, {
				name = L["Anthem of Composure (Tactical Mitigation)"],
				type = Type.Minor,
				modType = Modifier.Mitigation,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27
			}, { -- Ror Changes: - "Anthem of War (Melee Damage)" changed to "Anthem of War Damage (Physical)"
				name = L["Anthem of War Damage (Physical)"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {2,3,4,5,6,7,8,9,10},
				cost = CostTable27
			}, { -- RoR change: "Anthem of War (Tactical Damage)" renamed "Anthem of War Damage (Tactical)"
				name = L["Anthem of War Damage (Tactical)"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable27
			}, {
				name = L["Cry of the Chorus Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,19,33,48,62,76,91,105,120},
				cost = CostTable32
			}, {
				name = L["Chord of Salvation Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,2,3,4,5}, -- no adjust
				cost = { -- no adjust, CostTable63 truncated
					{27,41,59,81},
					{23,34,49,68},
					{18,27,39,54},
					{14,21,30,41}, -- check
					{9,14,20,27},
					{8,12,18,24}
				},
				maxRank = 5
			}, {
				name = L["Healing & Motivation Skills Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values				
				--mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable32
			}, {
				name = L["Bolster Courage Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
--				mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable36
			}, {
				name = L["Echoes of Battle Resistance Debuff"],
				type = Type.Minor,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19_neg ),
				cost = CostTable27
			}, {
				name = L["Healing Skills Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2.125,-3.25,-4.375,-5.5,-6.625,-7.75,-8.875,-10}, -- RoR values
				--mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10 },
				cost = CostTable36
			}, {
				name = L["Raise the Spirit Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				-- mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable36
			}, { -- RoR: "Song of the Dead Cooldown" renamed "Song of Subdual Cooldown"
				name = L["Song of Subdual Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,4,8,11,15,19,22,26,30 },
				cost = CostTable23
			}, {
				name = L["Target Resist Rating (Songs)"],
				type = Type.Minor,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19_neg ),
				cost = CostTable27
			}, {
				name = L["Target Resist Rating (Ballads)"],
				type = Type.Major,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating460_50_neg ),
				cost = CostTable32
			}, {
				name = L["Inspire Fellows Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				-- mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable36
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}

LegaciesBurglar = 
{
	{
		name = L["Weapon"],
		defaultLegacy = DPS1HRating, 
		legacies = -- All legacies checked for RoR
		{
			{
				name = L["Critical Response Skill Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable36
			}, {
				name = L["Feint Attack Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,6,12,17,23,28,34,39,45},
				cost = CostTable27
			}, {
				name = L["Cunning Attack Bleed Stack Chance"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {3,11,19,27,34,42,50,58,66},
				cost = CostTable32
			}, {
				name = L["Burglar Skill Bleed Damage Multiplier"],
				type = Type.Major, 
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, {
				name = L["Location is Everything Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,15,26,36,47,58,68,79,90},
				cost = CostTable18
			}, {
				name = L["Lucky Strike Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,6,12,17,23,28,34,39,45},
				cost = CostTable27
			}, { -- U5 changes: TODO check, might still have double costs
				name = L["Provoke Threat Up Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableThreat ),
				cost = CostTable23 -- checked @ T4
			}, { --U5 change
				name = L["Riddle Range"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,3,5,7,9,11,13,16,20},
				cost = CostTable36 -- checked @ T3,T4
			}, {
				name = L["Position Surprise Strike from Stealth"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable36
			}, {
				name = L["Ready and Able Cooldown"],
				type = Type.Minor, 
				modType = Modifier.Cooldown,
				mod = {10,83,157,231,305,378,452,526,600},
				cost = CostTable36 -- checked @ T2,T3
			}, {
				name = L["Small Snag Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,6,12,17,23,28,34,39,45},
				cost = CostTable27
			}, {
				name = L["Subtle Stab Critical Multiplier"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable36
			}, {
				name = L["Surprise Strike Critical Rating"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable36
			}, {
				name = L["Subtle Stab Damage Multiplier"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable32
			}, {
				name = L["Well Placed Strike Cooldown"],
				type = Type.Minor, 
				modType = Modifier.Cooldown,
				mod = {4,11,18,25,32,39,46,53,60},
				cost = CostTable18
			}, { -- U5 changes
				name = L["Trick Range"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable36 -- checked @ T1,T2
			}
		}
	},
	{
		name = L["Tools"],
		defaultLegacy = IncomingHealingRating,
		legacies = -- All legacies checked for RoR
		{
			{
				name = L["Addle Induction Multiplier"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,7.125,13.25,19.375,25.5,31.625,37.75,43.875,50}, -- RoR values
				-- mod = {1,7,13,19,26,32,38,44,50},
				cost = CostTable18
			}, {
				name = L["Clever Retort Damage and Healing"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {4,8.5,13,17.5,22,26.5,31,35.5,40},
				cost = CostTable27
			}, {
				name = L["Addle Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable27
			}, {
				name = L["Confound Countdown Duration"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable32
			}, {
				name = L["Aim Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable18
			}, {
				name = L["Gamble Chance"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {5,6.875,8.75,10.625,12.5,14.375,16.25,18.125,20}, -- RoR values
				-- mod = {5,7,9,11,13,14,16,18,20},
				cost = CostTable27
			}, {
				name = L["Hide in Plain Sight Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {7,29,50,72,93,115,136,158,180},
				cost = CostTable36
			}, {
				name = L["Healing - Mischievous Glee"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {5,10.6,16.2,21.8,27.5,33.1,38.7,44.3,50},
				cost = CostTable36
			}, {
				name = L["Off-hand Critical Chance"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ), 
				cost = CostTable32,
			}, {
				name = L["Increased Range for Reveal Weakness"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,3,5,8,10,12,15,17,20}, 
				cost = CostTable18
			}, {
				name = L["Devastating Critical Buff Duration"],
				type = Type.Major,
				modType = Modifier.Duration,
				mod = {3,6,9,13,16,19,23,26,30},
				cost = CostTable27
			}, { -- U5 changes
				name = L["Stealth Level"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3},
				maxRank = 3,
				cost = CostTableStealth,
			}, {
				name = L["Non-Enrage Tricks Duration"],
				type = Type.Major,
				modType = Modifier.Duration,
				mod = {1,2,4,6,8,9,11,13,15},
				cost = CostTable23
			}, {
				name = L["Sneak Movement Speed"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				-- mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable27
			}, { -- U5 changes
				name = L["Pulse Modifier for Glee"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable36, -- checked @ T4 & T5
			}, {
				name = L["Skills Critical Multiplier"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, {
				name = L["Positional Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}

LegaciesWarden = 
{
	{
		name = L["Melee weapon"],
		defaultLegacy = DPS1HRating, 
		legacies = -- All legacies checked for RoR
		{
			{
				name = L["Ambush Critical Multiplier"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable27
			}, {
				name = L["Boar's Rush Critical Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27
			}, { -- U6 changes: formerly "War-cry Threat Up"
				name = L["Shield Gambit Buff Duration"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = {1,2.12,3.25,4.37,5.5,6.62,7.75,8.87,10},
				cost = CostTable36 -- TODO: check (correct at T6)
			}, {
				name = L["Critical Strike Critical Multiplier"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable27
			}, { -- U6 changes: formerly "Wall of Steel Parry Rating"
				name = L["Spear Gambit Parry Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27 -- check (correct at T2 & T6)
			}, { -- U6 changes: formerly "Exultation of Battle Threat Up, Rating"
				-- RoR changes: "Fist-Spear Gambits Threat Up, Rating" renamed "Fist-Spear Gambit Threat", now expressed in percent
				name = L["Fist-Spear Gambit Threat"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {10,25,40,55,70,85,100,115,130},
				cost = CostTable36 -- matches @ T2
			}, {
				name = L["Wages of Fear Positional Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.5,7.7,8.8,10},
				cost = CostTable27
			}, {
				name = L["Hampering Javelin Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,4,6,8,9,11,13,15},
				cost = CostTable36
			}, {
				name = L["Surety of Death Damage Over Time"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27
			}, { -- U5 changes,
				name = L["Javelin Skills Max Range"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,4,6,7,9,11,13,15}, -- checked, U7
				cost = CostTable36, --
			}, { -- U6 changes: formerly "Spear of Virtue Threat Up"
				name = L["Gambit Lifetap Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27 -- check (correct at T2, T3 & T4)
			}, { -- U6 changes; formerly "Spear of Virtue Damage"
				name = L["Resolution Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10}, -- checked
				cost = CostTable27 -- TODO check - matches T2, most likely correct
			}, { -- U6 changes: formerly "Mighty Blow Damage"
				name = L["Spear Gambit Damage (Melee)"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27 -- check T2
			}, { -- U6 Changes: formerly "Onslaught Damage"
				name = L["Shield Tactics Tactical Mitigation Bonus"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27 -- check (T4)
			}, { -- U6 changes: formerly "Piercing Strike Threat Up"
				-- RoR changes: "Shield-Spear Gambit Thread Down, Rating" renamed "Shield-Spear Gambit Threat", now expressed in percentage
				name = L["Shield-Spear Gambit Threat"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {10,25,40,55,70,85,100,115,130},
				cost = CostTable23 -- check (T5), check RoR @ T2
			}, { -- U6 Changes: formerly "Power, power Attack Gambit Line"
				name = L["Power, Shield-Spear Gambit Line"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10}, -- check
				cost = CostTable18 -- TODO: mismatch @ T2 (CostTable32), double check , might not be a mismatch
			}, {
				name = L["Recklessness Attack Duration"],
				type  = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable23
			}, { -- U6 changes:formerly "Power, Fierce Resolve Gambit Line"
				name = L["Power, Fist-Spear Gambit Line"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable32 -- checked T1
			}
		}
	}, {
		name = L["Javelin"],
		defaultLegacy = DPS2HRating,
		legacies = -- All legacies checked for RoR
		{
			{ -- U6 changes: formerly "Dance of War Evade Rating"
				name = L["Fist Gambit Evade Rating Bonus"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27 -- checked T4
			}, {
				name = L["Ambush and Careful Step Induction"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {-0.3,-0.63,-0.97,-1.31,-1.65,-1.98,-2.32,-2.66,-3},
				cost = CostTable36
			}, { -- U6 changes: formerly "Celebration of Skill Healing"
				name = L["Shield Gambit Line Healing Bonus"],
				type = Type.Major, 
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR values
				cost = CostTable23 -- check (T3 & T4), RoR check @ T2
			}, { -- U6 Changes: Revised to affect ICPR in all stances.
				name = L["In Combat Power Regeneration"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = ModAdjustForLevelRangeAndAge( 
					{
						31,36.7, -- old values, maybe changed or set to two decimal places now
						42.54,48.36,54.18,59.94,65.76,71.58,77.4,83.16,88.98,94.8,100.62,
						106.38,112.2,118.02,123.84,129.6,
						135.42,141.24,147.06,152.82,158.64,164.46,170.28,176.04,181.86,
						187.68,193.5,199.26,205.08,210.9,-- extrapolated, likely correct
						216.72,222.48,228.3,234.12,239.94,245.7,251.52,257.34,263.16,268.92,274.74,
						280.56,286.38,292.14,297.96,303.78,309.6, -- up to lvl 85 2nd age + 3 crystals
						315.36,321.18,327,332.82,338.58,344.4 -- extrapolated for lvl 85 first ages
					} 
				),
				cost = CostTable36 -- checked @ T2
			}, {
				name = L["Adroit Maneuver Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable32
			}, {
				name = L["Careful Step Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {3,6,9,13,16,19,23,26,30},
				cost = CostTable36
			}, {
				name = L["Resolution Resist Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27
			}, {
				name = L["Determination Morale Regen"], -- U6 name change
				type = Type.Major,
				modType = Modifier.Number,
				mod = ModAdjustForLevelRangeAndAge(
					{
						65.34,77.58, -- two decimal places extrapolated
						89.82,102.06,114.3,126.54,138.84,151.08,163.32,175.56,
						187.8,200.1,212.34,224.58,236.82,249.06,261.36,273.6,
						285.84,298.08,310.32,322.56,334.86,347.1,359.34,371.58,383.82,
						396.06,408.36,420.6,432.84,445.08, --  extrapolated
						457.38,469.56,481.86,494.1,506.34,518.58,530.88,543.12,555.36,
						567.6,579.84,592.14,604.38,616.62,628.86,641.1,653.4, -- up to lvl 85 2nd age + crystals
						665.64,677.88,690.12,702.36,714.66,726.9 -- extrapolated for lvl 85 1st ages
					}
				),
				cost = CostTable36
			}, {
				name = L["Javelin Skills To-Hit Movement Penalty"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {-2,-3,-4,-5,-6,-7,-8,-9,-10},
				cost = CostTable27 -- checked @ T4
			}, { -- U6 changes: formerly "Forced March Power Penalty"
				name = L["Forced March Movement Bonus"],
				type = Type.Minor,
				modType = Modifier.Percent,
				--mod = {1,3,4,6,7,9,10,12,13},
				mod = {1,2.5,4,5.5,7,8.5,10,11.5,13}, -- RoR values
				cost = CostTable23 -- checked @ T4
			}, { -- U6 changes: formerly "Dark Before Dawn Power Restoration"
				name = L["Fist Gambit Critical Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				-- mod = ModAdjustForLevelRangeAndAge( ModifierTableRating460_50 ), -- doesn't currently adjust as of U7
				mod = {1360,1380,1400,1420,1440,1460,1480,1500,1520},
				cost = CostTable36 -- checked T1,T2 & T4
			}, { -- U6 changes: formerly "Power Safeguard Gambit Line"
				name = L["Power, Spear-Shield Gambit Line"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,2.125,-3.25,-4.375,-5.5,-6.625,-7.75,-8.875,-10}, -- RoR values
				-- mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable32 -- checked @ T1, T3 & T4
			}, { -- U6 changes: formerly "Restoration Morale Healed"
				name = L["Fist Gambit Buff Duration Bonus"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2.12,3.25,4.37,5.5,6.62,7.75,8.87,10},
				cost = CostTable36 -- check (T1, T2, T3 & T6)
			}, {
				name = L["Shield Mastery Block Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27
			}, { -- U6 changes: formerly "Safeguard Healing"
				name = L["Spear-Shield Damage Bonus"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27 -- checked @ T4
			}, { -- U6 Changes: formerly "Warden�s Triumph Duration"
				name = L["Defiant Challenge Cooldown Modifier"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,11.87,18.75,25.62,32.5,39.37,46.25,53.12,60},
				cost = CostTable36 -- check (correct at T1, T2 & T3)
			}, { -- RoR changes: values altered
				name = L["Heal Bonus for Conviction"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				-- mod = {1,3,5,6,8,10,12,13,15}, pre RoR
				cost = CostTable27
			}, {
				name = L["Shield Piercer Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,4,6,8,9,11,13,15},
				cost = CostTable32
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}

LegaciesLoremaster = 
{
	{
		name = L["Staff"],
		defaultLegacy = TacticalDamageRating, 
		legacies = 	-- All legacies checked for RoR
		{
			{
				name = L["Burning Ember Initial Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.8,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, { -- U5 changes
				name = L["Cracked Earth Range"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,3,5,7,9,11,13,16,20},
				cost = CostTable27,
			}, { -- U5 changes
				name = L["Burning Embers Range"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable27,
			}, {
				name = L["Ents Go To War Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable32
			}, {
				name = L["Cracked Earth Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable32
			}, {
				name = L["Fire Skills Critical Multiplier"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {3,5.7,9.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable32
			}, {
				name = L["Lightning Skills Critical Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable32
			}, {
				name = L["Gust of Wind Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable32
			}, {
				name = L["Light of the Rising Dawn Critical Multiplier"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable32
			}, {
				name = L["Lightning Storm Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable36
			}, {
				name = L["Light of the Rising Dawn Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, {
				name = L["Share the Power Increase"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable23
			}, {
				name = L["Tactical Skills Direct Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable36
			}, {
				name = L["Sticky Gourd Direct Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable32
			}, {
				name = L["Staff Strike Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable18
			}, {
				name = L["Test of Will Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, {
				name = L["Storm-lore Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable32
			}
		}
	},
	{
		name = L["Book"],
		defaultLegacy = TacticalHealingRating,
		legacies = -- All legacies checked for RoR
		{
			{ -- U5 changes
				name = L["Ancient Craft Targets"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget1,
				maxRank = 5
			}, { -- U5 changes
				name = L["Bane Flare Target"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget1,
				maxRank = 5
			}, { -- U5 changes
				name = L["Burning Embers Pulses"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable36
			}, {
				name = L["Cure Resistance Duration"],
				type = Type.Deprecated, -- was: Type.Minor
				modType = Modifier.Duration,
				mod = {5,11,18,25,32,39,46,53,60},
				cost = CostTable18
			}, { -- U5 changes
				name = L["Wizard Fire Pulses"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable36
			}, {
				name = L["Fire Damage Over Time"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, {
				name = L["Threat - Sign of the Wild: Rage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR values
				-- mod = {1,3,5,6,8,10,12,13,15},
				cost = CostTable23
			}, {
				name = L["Test of Will Devastate Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable27
			}, {
				name = L["Fire Skills Critical Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable32
			}, {
				name = L["Target Resistance (Fire Skills)"],
				type = Type.Major,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating460_50_neg ),
				cost = CostTable32
			}, { -- U5 changes
				name = L["Fire-lore Targets"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget1,
				maxRank = 5
			}, {
				name = L["Healing from Beacon of Hope"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR values
				-- mod = {1,3,5,6,8,10,12,13,15},
				cost = CostTable23
			}, {
				name = L["Target Resistance (Debuffing Skills)"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating1105_105_neg ),
				cost = CostTable23
			}, {
				name = L["Signs of Power Durations"],
				type = Type.Major,
				modType = Modifier.Duration,
				mod = {3,6,9,13,16,19,23,25,30},
				cost = CostTable18
			}, {
				name = L["Target Resistance (Damaging Skills)"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating460_50_neg ),
				cost = CostTable32
			}, {
				name = L["Inner Flame Healing"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,7.125,13.25,19.375,25.5,31.625,37.75,43.875,50}, -- RoR values
				-- mod = {1,7,13,19,26,32,38,44,50},
				cost = CostTable23
			}, { 
				name = L["Morale - Sign of the Wild: Protection"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5}, -- RoR values, previously a  6 ranks legacy, was probably altered in U5
				cost = CostTable23, -- RoR checked @ T1, T2, T4
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}

LegaciesChampion = 
{
	{
		name = L["Weapon (One Handed)"],
		defaultLegacy = DPS1HRating, 
		legacies = -- checked all legacies for RoR
		{
			{
				name = L["Area of Effect Skill Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable36
			}, { -- RoR: "Combat-only Effect Removal Delay"  ("Combat Effect Duration"??) replaced with "Targeted Melee Skills Range", identical to guardian one apparently
				name = L["Targeted Melee Skills Range"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {0.5,0.6,0.8,0.9,1.1,1.2,1.4,1.5,1.7},
				cost = CostTable36, -- checked @ T3,T4,T5,T6
			--[[
				name = L["Combat-only Effect Removal Delay"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable32
			--]]
			}, {
				name = L["Brutal Strikes Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable23
			}, {
				name = L["Critical Damage Multiplier"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {5,11,16,22,28,33,39,44,50},
				cost = CostTable32
			}, {
				name = L["Feral/Savage Strikes Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable23
			}, {
				name = L["Relentless/Remorless Strikes Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable23
			}, {
				name = L["Wild Attack Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable23
			}, {
				name = L["Fear Nothing Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,15,26,36,47,58,68,79,90},
				cost = CostTable27
			}, {
				name = L["Hamstring Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable32
			}, {
				name = L["Ferocious Strikes Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,2,3,4,5},
				cost = { -- Rank 1 & 2 & 3 matches CostTable63. Checked T1,T2, (RoR) T3,T4,T5,T6
					{27,41,59,81},
					{23,34,49,68},
					{18,27,39,54},
					{14,21,30,41},
					{9,14,20,27},
					{8,12,18,24}
				},
				maxRank = 5
			}, {
				name = L["Horn Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable23
			}, {
				name = L["Increased Rend Armour Reduction"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge(
					{
						80,88,95,103,111,119,126,134,142,150, -- 80,88 extrapolated
						157,165,173,181,188,196,204,212,219,227,-- 212 extrapolated
						235,243,250,258,266,270,274,277,281,285,
						289,292,296,300,304,307,311,315,319,322,
						326,330,334,337,341,345,349,352,356,
						360,364,368,372,376,380 -- extrapolated for first age LIs
					} 
				),
				cost = CostTable27
			}, {
				name = L["Battle Frenzy Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,3,5,8,10,12,15,17,20},
				cost = CostTable18
			}, {
				name = L["Rend Bleed Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable23
			}, { --  RoI changes
				name = L["Sudden Defence Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,19,34,48,63,77,91,106,120},
				cost = CostTable36,
			}, {
				name = L["Sprint Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {3,6,9,13,16,19,23,26,30},
				cost = CostTable27
			}
		}
	},
	{
		name = L["Weapon (Two Handed)"],
		defaultLegacy = DPS2HRating,
		legacies = {}	-- legacies set to same as one handed below 
	},
	{
		name = L["Rune"],
		defaultLegacy = IncomingHealingRating,
		legacies = -- all legacies checked for RoR
		{
			{
				name = L["Blade Line Area Damage Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2.125,-3.25,-4.375,-5.5,-6.625,-7.75,-8.875,-10}, -- RoR values
				-- mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable27
			}, { -- U5 changes
				name = L["Ardour/Glory Pip Interval"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {-1,-2,-3,-4},
				cost = CostTablePipInterval,
				maxRank = 4
			}, {
				name = L["Ardour/Glory in-Combat Power Regen"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR values
				-- mod = {1,3,5,6,8,10,12,13,15},
				cost = CostTable23
			}, {
				name = L["Adamant/Invincible Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,3,4,5},
				cost = CostTable36,
				maxRank = 5;
			}, {
				name = L["Ardour/Glory Parry and Evade Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27
			}, { -- RoR: "Hamstring Range" replaced with "Champion Skill Bubble Magnitude"
				name = L["Champion Skill Bubble Magnitude"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10},
				cost = CostTable36, -- checked at (RoR) T3,T4,T5,T6
			--[[
				name = L["Harmstring Range"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {0.5,1,2},
				cost = CostTableHarmstringRange,
				maxRank = 3
				--]]
			}, {
				name = L["Heroics Morale Heal Chance"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,10.875,20.75,30.625,40.5,50.375,60.25,70.125,80}, -- RoR values
				-- mod = {1,11,21,31,41,50,60,70,80},
				cost = CostTable18
			}, {
				name = L["Bracing Attack Heal"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR values
				-- mod = {1,3,5,6,8,10,12,13,15},
				cost = CostTable27
			}, {
				name = L["Dire Need Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {4,11,18,25,32,39,46,53,60}, 
				cost = CostTable32
			}, {
				name = L["Ebbing Ire Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {4,11,18,25,32,39,46,53,60},
				cost = CostTable36
			}, {
				name = L["(Glory) Hedge Armour Rating Mod"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating( 50, 35 ) ), -- might be worth checking, but should be correct (checked lvl 852nd age)
--[[				mod = ModAdjustForLevelRangeAndAge( 
					{ 50,85,120,155,190,225,260,295,330,365,400,435,470, -- Extrapolated
					505,540,575,610,645,680,715,750,
					785, -- Check
					820,855,890,925,960,995, --  Extrapolated
					-1,-1,-1,-1,-1,-1,-1,-1, 
					}  
				),--]]
				cost = CostTable27
			}, {
				name = L["Strikes Line Power Cost"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {-1,-2.125,-3.25,-4.375,-5.5,-6.625,-7.75,-8.875,-10}, -- RoR values
				-- mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable27
			}, {
				name = L["Swift Strike/Swift Blade Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-2,-5.5,-9,-12.5,-16,-19.5,-23,-26.5,-30}, -- RoR values
				-- mod = {-2,-6,-9,-13,-16,-20,-23,-27,-30},
				cost = CostTable27
			}, {
				name = L["Stun Duration - Champion's Horn"],
				type = Type.Major,
				modType = Modifier.Duration,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable36
			}, {
				name = L["Fight On Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {3,6,9,13,16,19,23,26,30},
				cost = CostTable32
			}, { -- U5 changes
				name = L["Rend Pulses"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable72 -- check (matches T2,T3,T4,T5,T6)
			}, {
				name = L["Battle Acuity Duration"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable36
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}
LegaciesChampion[2].legacies = LegaciesChampion[1].legacies;

LegaciesCaptain = 
{
	{
		name = L["Weapon (Two Handed)"],
		defaultLegacy = DPS2HRating, 
		legacies = -- all legacies checked for RoR
		{
			{
				name = L["Blade of Elendil Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable32
			}, {
				name = L["Cry Power Cost"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable16 -- checked (RoR) T2,T3,T4,T5,T6
			}, {
				name = L["Defensive Strike Armour Buff"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating( 50, 35 ) ), -- checked for RoI, rough check for RoR
				cost = CostTable23 -- checked @ T2, T3 & T4
			}, {
				name = L["Devastating Blow Critical Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable23
			}, {
				name = L["Cutting Attack Bleed Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {4,8.5,13,17.5,22,26.5,31,35.5,40},
				cost = CostTable27
			}, {
				name = L["Make Haste Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,4,7,10,13,16,19,22,25},
				cost = CostTable18 -- checked at T5
			}, {
				name = L["Kick Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,4,8,11,15,19,22,26,30},
				cost = CostTable27
			}, { -- U5 changes
				name = L["Pressing Attack Max Targets"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget2, -- checked @ T5
				maxRank = 5
			}, {
				name = L["Melee Skill Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable23
			}, {
				name = L["Pressing Attack Critical Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable23
			}, {
				name = L["Routing Cry Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {4,8.5,13,17.5,22,26.5,31,35.5,40},
				cost = CostTable27
			}, {
				name = L["Tactics: On Guard Parry Rating Buff"],
				type = Type.Minor, 
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable36 -- checked at T3
			}, {
				name = L["Tactics: Relentless Attack Critical Rating Buff"],
				type = Type.Minor, 
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable27
			}, {
				name = L["Telling Mark Damage"],
				type = Type.Major, 
				modType = Modifier.Percent,
				mod = {2,2.3,2.7,3.1,3.5,3.8,4.2,4.6,5},
				cost = CostTable36
			}, {
				name = L["Morale from Motivating Speech"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable36
			}, {
				name = L["To Arms Duration"],
				type = Type.Major, 
				modType = Modifier.Duration,
				mod = {1,2,4,6,8,9,11,13,15},
				cost = CostTable27
			}, { -- New RoR legacy
				name = L["Battle States and Defeat Response Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable27 --checked (RoR) at T1,T3,T4,T5,T6
			}
		}
	},
	{
		name = L["Weapon (One Handed)"],
		defaultLegacy = DPS1HRating,
		legacies = {}	-- legacies set to same as two handed below 
	},	
	{
		name = L["Emblem"],
		defaultLegacy = TacticalHealingRating,
		legacies = -- all legacies checked for RoR
		{
			{
				name = L["Escape from Darkness Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {10,83,157,231,305,378,452,526,600},
				cost = CostTable36
			}, {
				name = L["Shield of the Dunedain Cooldown"],
				type = Type.Minor, 
				modType = Modifier.Cooldown,
				mod = {5,10,15,20,30,45,60,75,90},
				cost = CostTable36
			}, { -- U5 changes
				name = L["Words of Courage Pulses"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,4,5,7,8,10,12,14},
				cost = CostTable27, -- Checked @ T3
			}, {
				name = L["Grave Wound Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable18
			}, {
				name = L["Rallying Cry Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR changes, two decimal places
				-- mod = {1,3,5,6,8,10,12,13,15},
				cost = CostTable23
			}, {
				name = L["Strength of Will Effects"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2,3,4,5,7,8,9,10},
				cost = CostTable27 -- checked @ T2 (RoR, check at T2)
			}, {
				name = L["Rallying Cry Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,4,8,11,15,19,22,26,30},
				cost = CostTable32
			}, {
				name = L["Melee Skills Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR values
				-- mod = {1,3,5,6,8,10,12,13,15},
				cost = CostTable27
			}, {
				name = L["Muster Courage Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable27b -- matches @ T2
			}, {
				name = L["Shadow's Lament Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,2,4,6,8,9,11,13,15},
				cost = CostTable32 -- checked @ T3
			}, {
				name = L["Time of Need Morale Cost"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {-1,-7.125,-13.25,-19.375,-25.5,-31.625,-37.75,-43.875,-50}, -- RoR values
				--mod = {1,7,13,19,26,32,38,44,50},
				cost = CostTable23
			}, {
				name = L["Valiant Strike Morale Return"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				--mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable27
			}, { -- RoI changes
				name = L["Tactics: Focus in-Combat Power Regen Buff"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = ModAdjustForLevelRangeAndAge( 
					{
						30.6,36.6,42,48,54,59.4,65.4,71.4,77.4,82.8,
						88.8,94.8,100.2,106.2,112.2,117.6,123.6,129.6,135,141,
						147.0,152.4,158.4,164.4,169.8,175.8,181.8,187.2,193.2,199.2,
						204.6,210.6,216.6,222.0,228.0,234.0,239.4,245.4,251.4,256.8,
						262.8,268.8,274.2,280.2,286.2,291.6,297.6,303.6,309.6,
						315,321,327,333,339,345 -- extrapolation for lvl 85 first age
					}
				),
				cost = CostTable32
			}, { -- RoI changes
				name = L["Time of Need Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {15,30,45,60,75,90,110,130,150},
				cost = CostTable23
			}, {
				name = L["Vocal Skills Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR values
				-- mod = {1,3,5,6,8,10,12,13,15},
				cost = CostTable27
			}, {
				name = L["Words of Courage Power and Morale Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2.125,-3.25,-4.375,-5.5,-6.625,-7.75,-8.875,-10}, -- RoR values
				--mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable36
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}

LegaciesCaptain[2].legacies = LegaciesCaptain[1].legacies;

LegaciesGuardian = 
{
	{
		name = L["Weapon"],
		defaultLegacy = DPS1HRating, 
		legacies = -- all legacies checked for RoR
		{
			{
				name = L["Charge Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable18
			}, { -- U5 changes
				name = L["Guardian Area Effect Melee Targets"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget1,
				maxRank = 5
			}, { -- TODO : 1h only 
				name = L["Bash Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable18
			}, {
				name = L["Brutal Assault Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27
			}, {
				name = L["Guardian Bleed Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {2,4.2,6.5,8.7,11,13.2,15.5,17.7,20},
				cost = CostTable36
			}, { -- U5 changes
				name = L["Guardian Bleed Pulses"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable72,
			}, {
				name = L["Overwhelm Critical Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( 
					{
						884,968,1052,1136,1220,1304,1388,1472,1556,1640,1724,
						1808,1892,1976,2060,2144,2228,2312,2396,2428,2464,
						2499,2534,2569,2604,2640,2675,2710,2745,2780,2816,
						2851,2886,2921,2956,2992,3027,3062,3097,3132,3168,
						3203,3238,3273,3308,3344,3379,3414,3449, -- -> level 85 RoR
						3484,3519,3554,3589,3624,3659 -- extrapolated first age level 85
					}
				),
				cost = CostTable32
			}, {
				name = L["Stamp Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,4,8,11,15,19,22,26,30}, -- RoR checked
				cost = CostTable27
			}, {
				name = L["Sweeping Cut Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27
			}, {
				name = L["Guardian's Ward Duration"],
				type = Type.Major,
				modType = Modifier.Duration,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable32
			}, { -- U5 changes
				name = L["Targeted Melee Skills Range"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {0.5,0.6,0.8,0.9,1.1,1.2,1.4,1.5,1.7},
				cost = CostTable36,
			}, {
				name = L["Guardian's Pledge Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {4,11,18,25,32,39,46,53,60}, -- RoR checked
				cost = CostTable32
			}, {
				name = L["Whirling Retaliation Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27
			}, {
				name = L["Vexing Blow Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable18
			}, {
				name = L["Turn the Tables Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,15,26,36,47,58,68,79,90},
				cost = CostTable32
			}, {
				name = L["Warrior's Heart/Fortitude Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {5,11,18,25,32,39,46,53,60},
				cost = CostTable27
			}, {
				name = L["To the King Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27
			}, { -- RoR: "Overpower Power Cost" replaced with "Overwhelm Damage"
				name = L["Overwhelm Damage"], 
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10}, -- RoR checked
				cost = CostTable18 -- RoR match @ T2
				--[[
				--  RoI 
				name = L["Overpower Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-5,-6},
				cost = { 
					{16,48,69,95,126}, -- check
					{14,41,59,81,108},
					{12,34,49,68,90},
					{9,27,39,54,72},
					{7,21,30,41,54},
					{5,14,20,27,36}
				},
				maxRank = 6
				--]]
			}
		}
	},
	{
		name = L["Weapon (Two Handed)"],
		defaultLegacy = DPS2HRating,
		legacies = {}	-- legacies set to same as one handed below 
	},	
	{
		name = L["Belt"],
		defaultLegacy = ShieldUseRank,
		legacies = -- all legacies checked for RoR
		{
			{
				name = L["Catch a Breath Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,4,8,11,15,19,22,26,30},
				cost = CostTable27
			}, {
				name = L["Catch a Breath Morale Heal"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR change, two decimal places
				-- mod = { 1,3,5,6,8,10,12,13,15},
				cost = CostTable27
				--cost = CostTable32 -- TODO: check (guessed from discrepancy in LIP from live) -- update: apparently incorrectly so, Table27 was correct
			}, {
				name = L["Cry Resist Chance"],
				type = Type.Major,
				modType = Modifier.Rating, 
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable32
			}, { -- U5 changes
				name = L["Challenge Targets"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget3,
				maxRank = 5
			}, {
				name = L["Guardian's Threat Block and Parry Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable32
			}, {
				name = L["Guardian's Ward Block Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable32
			}, {
				name = L["Guardian's Ward Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable18
			}, {
				name = L["Power Restore on Reactions"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {50,87.5,125,162.5,200,237.5,275,312.5,350}, -- RoR values
				--mod = {50,88,125,163,200,238,275,313,350},
				cost = CostTable27
			}, {
				name = L["Guardian's Ward Parry Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable32
			}, {
				name = L["Reactive Block Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {300,525,750,975,1200,1425,1650,1875,2100}, -- RoR checked
				cost = CostTable18
			}, {
				name = L["Increased Block, Parry and Evade from Protection"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge(
					{ -- most likely extrapolated properly (Table 207_19 /2)
						103,113, -- extrapolated
						122,132,141,151,160,170,179,189,198, -- correct value for lvl 61 third age
						208,217,227,236,246,255,265,268,272, -- extrapolated
						276,280,284,288,292,296,300, -- extrapolated
						304,308,312,316,320,324,328,332,336,
						340, -- extrapolated
						344,348,352,356,360,364,368,372,376,
						380,384,388, -- extrapolated
						392,396,400,404,408,412 -- extrapolated & presumed for level 75 1st ages
					}
				),
				cost = CostTable32
			}, {
				name = L["Shield Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,4,7,10,13,16,19,22,25},
				cost = CostTable63
			}, { -- U5 changes
				name = L["Shield Wall Range"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,3,5,7,9,11,13,16,20}, -- RoR check
				cost = CostTable18 -- checked @ T2 & RoR T5
			}, {
				name = L["Shield Smash Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25}, -- RoR change or maybe before that
				-- mod = {2,4,7,10,13,16,19,22,25},
				cost = CostTable32 -- checked RoR @ T2
			}, {
				name = L["Stagger Critical Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating1105_105 ),
				cost = CostTable32
			}, { -- U5 changes
				name = L["Threat Generation Up Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableThreat ),
				cost = CostTable36,
			}, {
				name = L["Stagger Effect Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable27
			}, {
				name = L["Warrior's Heart/Fortitude Morale Heal"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,4,7,10,13,15,19,22,25},
				cost = CostTable23
			}, {
				name = L["Stagger Positional Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.6,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable27
			}, { -- U5 changes
				name = L["Sting Damage"], 
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable16
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}
LegaciesGuardian[2].legacies = LegaciesGuardian[1].legacies;

LegaciesHunter = 
{
	{
		name = L["Ranged weapon"],
		defaultLegacy = DPS2HRating,
		legacies = -- all legacies checked for RoR
		{
			{
				name = L["Burn Hot Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.1,3.2,4.3,5.5,6.6,7.7,8.8,10},
				cost = CostTable27
			}, {
				name = L["Distracting Shot Resistance Penetration"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating460_50 ),
				cost = CostTable36
			}, { -- RoR checked
				name = L["Endurance Quick Shot Threat Down, Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable27
			}, {
				name = L["Distracting Shot Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,2,4,6,8,9,11,13,15},
				cost = CostTable36
			}, {
				name = L["Barbed Arrow Bleed Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {6,11.5,17,22.5,28,33.5,39,44.5,50},
				cost = CostTable32
			}, { -- TODO: *STILL HAS DOUBLE COSTS / SKIPPED RANKS ON LIs LEVEL 70-ISH !!!!
				name = L["Focus Bow Threat Down, Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableThreat ), 
				cost = CostTable32
			}, {
				name = L["Induction Bow Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable27
			}, {
				name = L["Heart Seeker Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {2,4.2,6.5,8.7,11,13.2,15.5,17.7,20},
				cost = CostTable36
			}, {
				name = L["Induction Bow Critical Multiplier"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable36
			}, {
				name = L["Focus Bow Critical Multiplier"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable36
			}, {
				name = L["Focus Bow Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-2,-3,-4,-6,-7,-8,-9,-10},
				cost = CostTable27
			}, {
				name = L["Quick Shot Critical Chance"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,1.5,2,2.5,3,3.5,4,4.5,5},
				cost = CostTable27
			}, {
				name = L["Ranged Skill Evade Chance Modifier"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19_neg ), -- gets upgraded one rank at T6 for some reason (as of RoR beta) -- TODO
				cost = CostTable32
			}, {
				name = L["Ranged Evade Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ), 
				cost = CostTable32
			}, {-- TODO: *STILL HAS DOUBLE COSTS / SKIPPED RANKS ON LIs LEVEL 70-ISH !!!!
				name = L["Induction Bow Threat Down, Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableThreat ),
				cost = CostTable32 -- checked @ T2
			}, { 
				name = L["Ranged Skill Block Chance Modifier"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19_neg ), -- gets upgraded one rank at T6 for some reason (as of RoR beta) -- TODO
				cost = CostTable32
			}, {
				name = L["Merciful Shot Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable32
			}, {
				name = L["Quick Shot Slow in Strength"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable32
			}
		}
	},
	{
		name = L["Weapon (One Handed)"],
		defaultLegacy = DPS1HRating,
		legacies = -- all legacies checked for RoR
		{
			{
				name = L["Agile Rejoinder Heal Multiplier"],
				type = Type.Minor;
				modType = Modifier.Percent,
				mod = {2,14,27,39,51,63,76,88,100},
				cost = CostTable23
			}, {
				name = L["Blindside Critical Rating"],
				type = Type.Major,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge(
					{
						517,565,612,660,707,755,802,850,897,945,
						992,1040,1087,1135,1182,1230,1277,1325,1340,1360,
						1380,1400,1420,1440,1460,1480,1500,1520,1540,1560,
						1580,1600,1620,1640,1660,1680,1700,1720,1740,1760,
						1780,1800,1820,1840,1860,1880,1900,1920,1940,1960,
						1980,2000,2020,2040,2060
					} 
				),
				cost = CostTable23
			}, {
				name = L["Desperate Flight Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {10,83,157,231,305,378,452,526,600},
				cost = CostTable32
			}, {
				name = L["Critical Magnitude in Precision Stance"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,3,4,5,7,8,10,11,13},
				cost = CostTable32
			}, {
				name = L["Beneath Notice Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {5,19,33,48,62,76,91,105,120},
				cost = CostTable18
			}, {
				name = L["Find the Path Movement Speed"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2,3,4,5,6},
				cost = { -- = cost table 27, truncated, rank 2 costs / 2. Checked for RoR, all tiers
					{12,34,49,68,90},
					{9,27,39,54,72},
					{7,21,30,41,54},
					{5,14,20,27,36},
					{4,12,18,24,32},
					{4,11,15,21,27}
				},
				maxRank = 6
			}, { -- U5 changes
				name = L["Improved Strength of Earth Morale Regen"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,5,10,15,20,25,30,35,40},
				cost = CostTable18 -- checked @ T3, T4, T5
			}, { -- U5 changes
				name = L["Maximum Targets for AoE Skills"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget3,
				maxRank = 5
			}, {
				name = L["Low Cut Bleed Chance"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,7,13,19,26,32,38,44,50},
				cost = CostTable23 -- checked T6 lvl 65 3rd age
			}, {
				name = L["Melee Critical Multiplier"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {3,5.7,8.5,11.2,14,16.7,19.5,22.2,25},
				cost = CostTable36
			}, {
				name = L["Melee Critical Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable36
			}, {
				name = L["Needful Haste Duration"],
				type = Type.Major,
				modType = Modifier.Duration,
				mod = {1,2,4,6,8,9,11,13,15},
				cost = CostTable32
			}, { -- U5 changes
				name = L["Stealth Detection"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3},
				cost = CostTableStealth, -- checked  (RoR) for T3,T4,T5,T6
				maxRank = 3
			}, {
				name = L["Power Restored by Deep Concentration"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {2,6,9,13,16,20,23,27,30},
				cost = CostTable27
			}, {
				name = L["Swift Stroke Parry and Evade Rating"],
				type = Type.Minor,
				modType = Modifier.Rating,
				mod = ModAdjustForLevelRangeAndAge( ModifierTableRating207_19 ),
				cost = CostTable18
			}, {
				name = L["Press Onward Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,15,26,36,47,58,68,79,90},
				cost = CostTable32
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}

LegaciesRunekeeper = 
{
	{
		name = L["Rune-stone"],
		defaultLegacy = TacticalDamageRating,
		legacies = -- All legacies checked for RoR
		{
			{	
				name = L["Fire Skill Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, {
				name = L["Battle Attuned Skill Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-3,-5,-6,-8,-10,-12,-13,-15},
				cost = CostTable27
			}, {
				name = L["Chill of Winter Debuff Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable36
			}, {
				name = L["Chill of Winter Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, { -- U6 changes: Distracting Flames Cooldown reduction reduced to 15 seconds.
				name = L["Distracting Flame Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,2,4,6,8,9,11,13,15},
				cost = CostTable27 -- check at T5, T6
			}, {
				name = L["Fury of Storm Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, {
				name = L["Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,1.5,2,2.5,3,3.5,4,5,6},
				cost = CostTable36
			}, { -- U6 changes - Glorious foreshadowing Duration - Reduced to 9 seconds.
				name = L["Glorious Foreshadowing Duration"],
				type = Type.Minor,
				modType = Modifier.Duration,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable32
			}, {
				name = L["Healing Over Time"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable36
			}, {
				name = L["Healing Attuned Skill Power Cost"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {-1,-3,-5,-6,-8,-10,-12,-13,-15},
				cost = CostTable27
			}, {
				name = L["Fury of Storm Critical Multiplier"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {2,5.5,9,12.5,16,19.5,23,26.5,30},
				cost = CostTable36
			}, { -- U5 changes
				name = L["Vivid Imagery Targets"],
				type = Type.Minor,
				modType = Modifier.Number,
				mod = {1,2,3,4,5},
				cost = CostTableTarget3, -- RoR checked @ T1,T3,T4
				maxRank = 5
			}, {
				name = L["Wrath of Flame Damage Over Time"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.7,4.5,6.2,8,9.7,11.5,13.2,15},
				cost = CostTable36
			}, {
				name = L["Steady Attuned Skill Power"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {-1,-3,-5,-6,-8,-10,-12,-13,-15},
				cost = CostTable23
			}, { -- RoI changes
				name = L["Finesse Rating"], 
				type = Type.Minor,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge( 
					{ -- 55 ranks
						258,282,306,330,353,377,401,425,448,472,
						496,520,543,567,591,615,638,662,670,680, -- extrapolated: 662,670
						690,700,710,720,730,740,750,760,770,780,
						790,800,810,820,830,840,
						850,860,870,880, -- extrapolated
						890,900,910,920,930,940,950,960,970,980, -- extrapolated
						990,1000,1010,1020,1030 -- extrapolated
					}
				),
				cost = CostTable36
			}
		}
	},
	{
		name = L["Rune-satchel"],
		defaultLegacy = TacticalHealingRating,
		legacies = -- All legacies checked for RoR
		{
			{
				name = L["Chilling Rhetoric Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,2,3,4,5,6,7,8,10},
				cost = CostTable18
			}, { -- U6 changes - Ceaseless Argument Power cost - Changed to Damage increase.
				name = L["Ceaseless Argument Damage"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.75,4.5,6.25,8,9.75,11.5,13.25,15}, -- RoR values
				-- mod = {1,3,5,6,8,10,12,13,15},
				cost = CostTable27 -- RoR checked @ T5 & T6
			}, {
				name = L["Distracting Winds Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {4,11,18,25,32,39,46,53,60},
				cost = CostTable32
			}, {
				name = L["Do Not Fall This Day Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,23,43,63,82,101,121,140,160},
				cost = CostTable36
			}, {
				name = L["Epic for the Ages Healing"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				-- mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable36
			}, {
				name = L["Essence of Flame Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {2,4.2,6.5,8.7,11,13.2,15.5,17.7,20},
				cost = CostTable36
			}, {
				name = L["Mending Verse Healing"],
				type = Type.Minor,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				-- mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable36
			}, {
				name = L["Frozen Epilogue Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {5,24,43,63,82,101,121,140,160},
				cost = CostTable32
			}, { -- U5 changes
				name = L["Pulses Prelude to Hope"],
				type = Type.Major,
				modType = Modifier.Number,
				mod = {1,2,3,4,5,6,7,8,9},
				cost = CostTable36,
			}, {
				name = L["Scribe's Spark Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {2,4.2,6.5,8.7,11,13.2,15.5,17.7,20},
				cost = CostTable27
			}, { -- U6 Changes - Self-motivation Power Restore - Changed to cooldown reduction.
				name = L["Self Motivation Cooldown"],
				type = Type.Major,
				modType = Modifier.Cooldown,
				mod = {2,5.5,9,12.5,16,19.5,23,26.5,30},
				cost = CostTable32 --RoR checked @ T2,T4,T5
			}, {
				name = L["Shocking Words Stun Chance"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,3.375,5.75,8.125,10.5,12.875,15.25,17.625,20}, -- RoR values
				-- mod = {1,3,6,8,11,13,15,18,20},
				cost = CostTable18
			}, {
				name = L["Writ of Fire Damage"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {2,4.2,6.5,8.7,11,13.2,15.5,17.7,20},
				cost = CostTable32
			}, {
				name = L["Writ of Health Healing"],
				type = Type.Major,
				modType = Modifier.Percent,
				mod = {1,2.125,3.25,4.375,5.5,6.625,7.75,8.875,10}, -- RoR values
				--mod = {1,2,3,4,6,7,8,9,10},
				cost = CostTable32
			}, {
				name = L["Word of Exaltation Cooldown"],
				type = Type.Minor,
				modType = Modifier.Cooldown,
				mod = {1,4,8,11,15,19,22,26,30},
				cost = CostTable27
			}, {
				name = L["Target Shocking Touch Resist Rating"],
				type = Type.Minor,
				modType = Modifier.Resist,
				mod = ModAdjustForLevelRangeAndAge(
					{ -- 55 ranks
						-690,-765,-840,-915,-990,-1065,-1140,-1215,-1290,-1365,
						-1440,-1515,-1590,-1665,-1740,-1815,-1890,-1920,-1950,-1980,
						-2010,-2040,-2070,-2100,-2130,-2160,-2190,-2220,-2250,-2280,
						-2310,-2340,-2370,-2400,-2430,-2460,-2490,-2520,-2550,-2580,
						-2610,-2640,-2670,-2700,-2730,-2760,-2790,-2820,-2850,-2880,
						-2910,-2940,-2970,-3000,-3030
					} 
				),
				cost = CostTable27
			}
		}
	},
	BridleLight,
	BridleMedium,
	BridleHeavy
}

-- Stat legacies 
ModifierTableStat = {
	5,7,8,10,11,13,14,16,17,19,
	20,22,24,26,28,30,31,32,33,34,
	35,36,37,38,39,40,41,42,43,44,
	45,46,47,48,49,50,51,52,53,54,
	55,56,57,58,59,60,61,62,63,64,
	65,66,67,68,69
};

LegaciesStat =
{
	{
		name = L["Agility"],
		type = Type.Stat,
		modType = Modifier.Number,
		mod = ModAdjustForLevelRangeAndAge( ModifierTableStat ),
		cost = CostTable23
	}, {
		name = L["Fate"],
		type = Type.Stat,
		modType = Modifier.Number,
		mod = ModAdjustForLevelRangeAndAge( ModifierTableStat ),
		cost = CostTable23
	}, {
		name = L["Might"],
		type = Type.Stat,
		modType = Modifier.Number,
		mod = ModAdjustForLevelRangeAndAge( ModifierTableStat ),
		cost = CostTable23		
	}, {
		name = L["Vitality"],
		type = Type.Stat,
		modType = Modifier.Number,
		mod = ModAdjustForLevelRangeAndAge( ModifierTableStat ),
		cost = CostTable23
	}, {
		name = L["Will"],
		type = Type.Stat,
		modType = Modifier.Number,
		mod = ModAdjustForLevelRangeAndAge( ModifierTableStat ),
		cost = CostTable23
	}
}
