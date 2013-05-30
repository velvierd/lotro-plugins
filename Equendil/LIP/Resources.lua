-- resource IDs for icons
Icon = {
	LegacyTierSmall = { 0x410F29EC, 0x410F29EE, 0x410F29F0, 0x410F29F2, 0x410F29F4, 0x410F2A16 }, -- Per rank - 16x16 dimension
	LegacyTierBig = { 0x410F29ED, 0x410F29EF, 0x410F29F1, 0x410F29F3, 0x410F29F5, 0x410F29F6 }, -- Per rank - 32x32
	
	LegacyDefaultSmall = { -- 16x16
		DPS = 0x41102109, -- TODO, wrong icon
		TacticalDamageRating = 0x41102104,
		TacticalHealingRating = 0x4110210B,
		IncomingHealingRating = 0x41102107,
		ShieldUse = 0x41102109,
		FuryBonusContributionRating = 0x4112AA9D,
	},
	
	LegacyDefaultBig = {	-- icons of default legacies
		DPS = 0x410F6F7F, -- 36x36 !
		TacticalDamageRating = 0x41102106, -- 32x32
		TacticalHealingRating = 0x41102108, -- 32x32
		IncomingHealingRating = 0x41102105, -- 32x32
		ShieldUse = 0x4110210A, -- 32x32
		FuryBonusContributionRating = 0x4112AA9C, -- 32x32
	},
	
	CostSmall = 0x410E82A2, -- small coin icon as used in the legendary item panel
	CostBig = 0x410E8297,	-- large coin icon as used in the legendary item panel, 27x22
	
	LegacyMajor = 0x4111079C,	-- 16x16 icon indicating a legacy is major
	LegacyMinor = 0x4111079B,	-- 16x16 icon indicating a legacy is minor
	
	LegacyTierMajor = 	0x4111059A,	-- 32x32 tier overlay icon 
	LegacyTierMinor = 	0x4111059B,	-- 32x32 tier overlay icon
	
	LIBackground = { 0x410E8E58, 0x410E8E59, 0x410E8E4A }, -- background for legendary item icons. 1st, 2nd, 3rd age, 32x32
	GreyBackground = 0x41000001, -- 32x32 background for icons
	Highlight2 = 0x41000221, 
	
	LI = { --first, second, thid age in that order, 32x32 unless specified otherwise
		Rune = { 0x410F44C2, 0x410F44C5, 0x410F44C3 },	-- champion
		Belt = { 0x410F44CA, 0x410F44D0, 0x410F44C0 },	-- guardian
		SongBook = { 0x410F44D6, 0x410F44CC, 0x410F44F1 },	-- minstrel
		Book = { 0x410F44DF, 0x410F44C9, 0x410F44D3 },	-- lore-master
		Emblem = { 0x410F44ED, 0x410F44CF, 0x410F44C7 }, -- captain
		Tools = { 0x410F44C8, 0x410F44DB, 0x410F44E9 }, -- burglar
		Satchel = { 0x410F4682, 0x410F4680, 0x410F467E }; --There's a bunch of different satchel icons, listing three arbitrarily here ...

		Stone = { 0x41118789, 0x41118789, 0x41118789 }, -- Rune keeper stones seem to have a lot of different icons, but no 1st/2nd/3rd distinction apparently, so arbitrary stuff thrown here
		
		-- weapons don't seem to have different icons for 1st, 2nd, 3rd age, so IDs are repeated 
		Staff = { 0x411187DA, 0x411187DA, 0x411187DA },
		Dagger = { 0x411189E5, 0x411189E5, 0x411189E5 },
		Spear = { 0x411187C8, 0x411187C8, 0x411187C8 },
		Hammer = { 0x41001622, 0x41001622, 0x41001622 },
		Mace = { 0x4100040C, 0x4100040C, 0x4100040C }, -- same as clubs it seems
		Sword = { 0x411187EF, 0x411187EF, 0x411187EF },
		Club = { 0x4100040C, 0x4100040C, 0x4100040C },
		Axe = { 0x410010DD, 0x410010DD, 0x410010DD },
		GreatSword = { 0x4100041B, 0x4100041B, 0x4100041B }, -- same as swords
		GreatClub = { 0x41001326, 0x41001326, 0x41001326 },
		GreatAxe = { 0x410012E0, 0x410012E0, 0x410012E0 },
		GreatHammer = { 0x41001323, 0x41001323, 0x41001323 },
		Halberd = { 0x41118A67, 0x41118A67, 0x41118A67 },
		Bow = { 0x41118732, 0x41118732, 0x41118732 },
		Javelin = { 0x41118765, 0x41118765, 0x41118765 },
		Crossbow = { 0x410015FD, 0x410015FD, 0x410015FD },
		
		-- bridles
		LightBridle = {0x4112D436,0x4112D429,0x4112D42D},
		MediumBridle = {0x4112D42C,0x4112D42F,0x4112D42A},
		HeavyBridle = {0x4112D434,0x4112D430,0x4112D432},
	},
	LIShadow = { -- shadow of above icons
		Rune = { 0x410f44dd, 0x410f44da, 0x410f44cd },
		Belt = { 0x410f44d8, 0x410f44e8, 0x410f44d7 },
		SongBook = { 0x410f44f0, 0x410f44d2, 0x410f44f2 },
		Book = { 0x410f44e1, 0x410f44d4, 0x410f44d9 }, -- all look the same, so might be wrong order
		Emblem = { 0x410f44ec, 0x410f44e6, 0x410f44e3 }, -- all look the same, might be wrong order
		Tools = { 0x410f44c4, 0x410f44eb, 0x410f44cb }, 
		Satchel = { 0x410f4683, 0x410f4681, 0x410f467f },

		Stone = { 0x41118790, 0x41118790, 0x41118790 }, 
		
		Staff = { 0x411187DB, 0x411187DB, 0x411187DB },
		Dagger = { 0x411189E6, 0x411189E6, 0x411189E6 },
		Spear = { 0x411187C9, 0x411187C9, 0x411187C9 },
		Hammer = { 0x41001623, 0x41001623, 0x41001623 },
		Mace = { 0x4100040d, 0x4100040d, 0x4100040d },
		Sword = { 0x411187F0, 0x411187F0, 0x411187F0 },
		Club = { 0x4100040d, 0x4100040d, 0x4100040d },
		Axe = { 0x410010de, 0x410010de, 0x410010de },
		GreatSword = { 0x4100041c, 0x4100041c, 0x4100041c },
		GreatClub = { 0x41001327, 0x41001327, 0x41001327 },
		GreatAxe = { 0x410012e1, 0x410012e1, 0x410012e1 },
		GreatHammer = { 0x41001324, 0x41001324, 0x41001324 },
		Halberd = { 0x41118A68, 0x41118A68, 0x41118A68 },
		Bow = { 0x41118733, 0x41118733, 0x41118733 },
		Javelin = { 0x41118766, 0x41118766, 0x41118766 },
		Crossbow = { nil, nil, nil }, -- Doesn't seem to have a shadow
		
		-- bridles
		-- all nine bridle shadows look exactly the same, so using just one, arbitrarily
		LightBridle = {0x4112D42B,0x4112D42B,0x4112D42B},
		MediumBridle = {0x4112D42B,0x4112D42B,0x4112D42B},
		HeavyBridle = {0x4112D42B,0x4112D42B,0x4112D42B},
	},
	
	LITabHeaderBig = { -- 90x40
		-- all 'secondary' LIs have the same header icon
		Rune = 0x410EE55A, -- TODO check
		Belt = 0x410EE55A, -- TODO check
		SongBook = 0x410EE55A, -- winged thingies
		Book = 0x410EE56A, -- LM class icon for books
		Emblem = 0x410EE55A, -- TODO check
		Tools = 0x410EE565,	-- Burg class icon for tools
		Satchel = 0x410EE56C, -- RK Class Icon for satchels

		Stone = 0x410EE563, -- rune keeper stone		
		
		Staff = 0x410EE564, -- same as spear, oddly
		Dagger = 0x410EE55F,
		Spear = 0x410EE564, 
		Hammer = 0x410EE561, 
		Mace = 0x410EE562,
		Sword = 0x410EE55B,
		Club = 0x410EE562, -- TODO check if same as mace
		Axe = 0x410FB4CB, 
		GreatSword = 0x410EE55B,
		GreatClub = 0x410EE562, -- TODO check if same as mace
		GreatAxe = 0x410FB4CB, 
		GreatHammer = 0x410EE561,
		Halberd = 0x410EE560,
		Bow = 0x410EE55C, 
		Javelin = 0x410EE55A, -- Winged thingie, same as song books ...
		Crossbow = 0x410EE55C, -- TODO: Same as bow ?
		
		-- bridles -- asumedly same header for all three types
		LightBridle = 0x4112D428,
		MediumBridle = 0x4112D428,
		HeavyBridle = 0x4112D428,
	},
};