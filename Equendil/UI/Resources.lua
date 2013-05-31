-- Various resource definitions

-- preset colors
Color = { 
	TurbineWhite = Turbine.UI.Color(1, 0.9, 0.9, 0.9),
	TurbineYellow = Turbine.UI.Color( 1, 0.9, 0.9, 0.1 ),
	TurineOrange = Turbine.UI.Color( 1, 190/255, 148/255, 0 ),
	TurbineLightYellow = Turbine.UI.Color( 1, 232/255, 229/255, 174/255 ),
	TurbineGrey = Turbine.UI.Color( 1, 0.5, 0.5, 0.5 ),

	Transparent = Turbine.UI.Color ( 0, 0, 0, 0 );
	White = Turbine.UI.Color( 1, 1, 1, 1 ),
	Black = Turbine.UI.Color( 1, 0, 0, 0 ),
	Green = Turbine.UI.Color( 1, 0, 1, 0 ),
	
	-- colors used to indicate the age of a LI
	TurbineLI = { 
		Turbine.UI.Color( 1, 1, 0.7, 0 ), -- first age = orange
		Turbine.UI.Color( 1, 0, 1, 1 ), -- second age = cyan
		Turbine.UI.Color( 1, 1, 0, 1 ), -- third age = purple
	};
};

-- resource IDs for icons
Icon = {
	ArrowLeftSmall = { 0x41007E0D, 0x41007E0F, 0x41007E0E }, -- 16x16, normal, highlighted, depressed
	ArrowRightSmall = { 0x41007E10, 0x41007E12, 0x41007E11 }, -- 16x16, normal, highlighted, depressed
	ArrowLeftBig = { 0x41000276, 0x41000279, 0x41000278 }, -- 25x25, normal, highlighted, depressed
	ArrowRightBig = { 0x41000272, 0x41000275, 0x41000274 }, -- 25x25, normal, highlighted, depressed
	ArrowDownTiny = { 0x41007E1A, 0x41007E1B, 0x41007E1B }, -- 16x16
	
	ArrowUp = { -- 20x20
		"Equendil/UI/images/arrowup20.tga",
		"Equendil/UI/images/arrowup20_highlighted.tga",
		"Equendil/UI/images/arrowup20_depressed.tga"
	},
	
	ArrowDown = { -- 20x20
		"Equendil/UI/images/arrowdown20.tga",
		"Equendil/UI/images/arrowdown20_highlighted.tga",
		"Equendil/UI/images/arrowdown20_depressed.tga",
	},
	
	FastForwardSmall = { -- 16x16
		"Equendil/UI/images/fastforward_normal.tga", 
		"Equendil/UI/images/fastforward_highlighted.tga", 
		"Equendil/UI/images/fastforward_depressed.tga" 
	}, 
	
	CloseRed = { 0x41005F41, 0x41005F50, 0x41005F49 }, -- 16x16 , normal, highlighted, depressed

	CheckMarkGreen = 0x41000007, -- 16x16
	
	LegacyTierSmall = { 0x410F29EC, 0x410F29EE, 0x410F29F0, 0x410F29F2, 0x410F29F4, 0x410F2A16 }, -- Per rank - 16x16 dimension
	LegacyTierBig = { 0x410F29ED, 0x410F29EF, 0x410F29F1, 0x410F29F3, 0x410F29F5, 0x410F29F6 }, -- Per rank - 32x32
	
	LegacyDefaultSmall = { -- 16x16
		DPS = 0x41102109, -- TODO, wrong icon
		TacticalDamageRating = 0x41102104,
		TacticalHealingRating = 0x4110210B,
		IncomingHealingRating = 0x41102107,
		ShieldUse = 0x41102109
	},
	
	LegacyDefaultBig = {	-- icons of default legacies
		DPS = 0x410F6F7F, -- 36x36 !
		TacticalDamageRating = 0x41102106, -- 32x32
		TacticalHealingRating = 0x41102108, -- 32x32
		IncomingHealingRating = 0x41102105, -- 32x32
		ShieldUse = 0x4110210A -- 32x32
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

		Stone = { 0x410F456F, 0x410F456F, 0x410F456F }, -- Rune keeper stones seem to have a lot of different icons, but no 1st/2nd/3rd distinction apparently, so arbitrary stuff thrown here
		
		-- weapons don't seem to have different icons for 1st, 2nd, 3rd age, so IDs are repeated 
		Staff = { 0x410015D8, 0x410015D8, 0x410015D8 },
		Dagger = { 0x41000412, 0x41000412, 0x41000412 },
		Spear = { 0x41000710, 0x41000710, 0x41000710 },
		Hammer = { 0x41001622, 0x41001622, 0x41001622 },
		Mace = { 0x4100040C, 0x4100040C, 0x4100040C }, -- same as clubs it seems
		Sword = { 0x4100041B, 0x4100041B, 0x4100041B },
		Club = { 0x4100040C, 0x4100040C, 0x4100040C },
		Axe = { 0x410010DD, 0x410010DD, 0x410010DD },
		GreatSword = { 0x4100041B, 0x4100041B, 0x4100041B }, -- same as swords
		GreatClub = { 0x41001326, 0x41001326, 0x41001326 },
		GreatAxe = { 0x410012E0, 0x410012E0, 0x410012E0 },
		GreatHammer = { 0x41001323, 0x41001323, 0x41001323 },
		Halberd = { 0x41001611, 0x41001611, 0x41001611 },
		Bow = { 0x41001180, 0x41001180, 0x41001180 },
		Javelin = { 0x410F2026, 0x410F2026, 0x410F2026 },
		Crossbow = { 0x410015FD, 0x410015FD, 0x410015FD },
	},
	LIShadow = { -- shadow of above icons
		Rune = { 0x410f44dd, 0x410f44da, 0x410f44cd },
		Belt = { 0x410f44d8, 0x410f44e8, 0x410f44d7 },
		SongBook = { 0x410f44f0, 0x410f44d2, 0x410f44f2 },
		Book = { 0x410f44e1, 0x410f44d4, 0x410f44d9 }, -- all look the same, so might be wrong order
		Emblem = { 0x410f44ec, 0x410f44e6, 0x410f44e3 }, -- all look the same, might be wrong order
		Tools = { 0x410f44c4, 0x410f44eb, 0x410f44cb }, 
		Satchel = { 0x410f4683, 0x410f4681, 0x410f467f },

		Stone = { 0x410f4570, 0x410f4570, 0x410f4570 }, 
		
		Staff = { 0x410015d9, 0x410015d9, 0x410015d9 },
		Dagger = { 0x41000413, 0x41000413, 0x41000413 },
		Spear = { 0x41000711, 0x41000711, 0x41000711 },
		Hammer = { 0x41001623, 0x41001623, 0x41001623 },
		Mace = { 0x4100040d, 0x4100040d, 0x4100040d },
		Sword = { 0x4100041c, 0x4100041c, 0x4100041c },
		Club = { 0x4100040d, 0x4100040d, 0x4100040d },
		Axe = { 0x410010de, 0x410010de, 0x410010de },
		GreatSword = { 0x4100041c, 0x4100041c, 0x4100041c },
		GreatClub = { 0x41001327, 0x41001327, 0x41001327 },
		GreatAxe = { 0x410012e1, 0x410012e1, 0x410012e1 },
		GreatHammer = { 0x41001324, 0x41001324, 0x41001324 },
		Halberd = { 0x41001612, 0x41001612, 0x41001612 },
		Bow = { 0x41001181, 0x41001181, 0x41001181 },
		Javelin = { 0x410f2027, 0x410f2027, 0x410f2027 },
		Crossbow = { nil, nil, nil } -- Doesn't seem to have a shadow
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
	},
	
	ClassBig = {	-- 48x48 class icons
		Minstrel = 0x410081F7,
		Burglar = 0x41007E87,
		Loremaster = 0x410081FC,
		Hunter = 0x41008201,
		Guardian = 0x410081FF,
		Champion = 0x410081CD,
		Captain = 0x410081F3,
		Warden = 0x410E0DCA,
		Runekeeper = 0x410E81CB
	},
	ClassMedium = {	-- 32x32 class icons
		Minstrel = 0x41110FCB,
		Burglar = 0x41110FBF,
		Loremaster = 0x41110FC9,
		Hunter = 0x41110FC7,
		Guardian = 0x41110FC5,
		Champion = 0x41110FC3,
		Captain = 0x41110FC1,
		Warden = 0x41110FCF,
		Runekeeper = 0x41110FCD
	},
}

-- resource IDs for larger images
Background = {
	LIItem = 0x410E8298, -- empty icon slot + funky background for name
	
	SectionWide = 0x41005F8A, -- 400x30, section header background as used in setup windows
	SectionNarrow = 0x41108F3B, -- 150x23, section header background
};

Decoration = {
	RoundSilver = { -- round silver transparent
		topLeft = 0x41108A8A, 
		top = 0x41108A8B, 
		topRight = 0x41108A89, 
		right =  0x41108A90, 
		bottomRight = 0x41108A8F, 
		bottom = 0x41108A8E, 
		bottomLeft = 0x41108A8D, 
		left = 0x41108A8C, 
--		center = 0x41103EF2
--		centerColor = Turbine.UI.Color( 1, 0, 0, 0 );
	},
	
	SimpleGreyOutline =	{
		topLeft = 0x4100016D, 
		top = 0x41000174, 
		topRight = 0x41000173, 
		right =  0x41000172, 
		bottomRight = 0x41000171, 
		bottom = 0x41000170, 
		bottomLeft = 0x4100016F, 
		left = 0x4100016E, 
		center = nil,
		centerColor = Turbine.UI.Color( 1, 0, 0, 0 );
	},
	
	RedOutline = {
		topLeft = 0x410E87AD,
		top = 0x410E87AE,
		topRight = 0x410E87AC,
		right =  0x410E87B3,
		bottomRight = 0x410E87B2,
		bottom = 0x410E87B1,
		bottomLeft = 0x410E87B0,
		left = 0x410E87AF,
		center = 0x410E87B4
	},
	
	DarkGreyOutline = {
		topLeft = 0x4110A0EF,
		top = 0x4110A0EE,
		topRight = 0x4110A0F0,
		right =  0x4110A0ED,
		bottomRight = 0x4110A0EA,
		bottom = 0x4110A0E8,
		bottomLeft = 0x4110A0E9,
		left = 0x4110A0EC,
		center = 0x4110A0EB
	},
	
	LightYellowOutline = {
		topLeft = 0x4110A0F8,
		top = 0x4110A0F7,
		topRight = 0x4110A0F9,
		right =  0x4110A0F6,
		bottomRight = 0x4110A0F3,
		bottom = 0x4110A0F1,
		bottomLeft = 0x4110A0F2,
		left = 0x4110A0F5,
		center = 0x4110A0F4
	},
	
	Leatherish = {	-- 400 x 449
		topLeft = 0x4110CD52,
		top = nil,
		topRight = 0x4110CD53,
		right =  nil,
		bottomRight = 0x4110CD50,
		bottom = nil,
		bottomLeft = 0x4110CD51,
		left = nil,
		center = 0x41102ECB
	},
	
	Leatherish2 = { -- 309 + n*74,, 190 + n*95
		topLeft = 0x410FB1A7,
		top = 0x410FB1A8,
		topRight = 0x410FB1A9,
		right =  0x410FB1AC,
		bottomRight = 0x410FB1AF,
		bottom = 0x410FB1AE,
		bottomLeft = 0x410FB1AD,
		left = 0x410FB1AA,
		center = 0x410FB1AB
	},
	
	HighlightCyan = { 
		topLeft = 0x4110CF2C,
		topRight = 0x4110CF26,
		bottomRight = 0x4110CF29,
		bottomLeft = 0x4110CF27,
		top = 0x4110CF2D,
		right = 0x4110CF2B,
		bottom = 0x4110CF28,
		left = 0x4110CF2A
	},
	
	HighlightRed = { 
		topLeft = 0x4110E26E,
		topRight = 0x4110E26C,
		bottomRight = 0x4110E271,
		bottomLeft = 0x4110E273,
		top = 0x4110E26D,
		right = 0x4110E26F,
		bottom = 0x4110E272,
		left = 0x4110E270
	},
	
	RoundSilverBlue = {
		topLeft = 0x410E87A5,
		topRight = 0x410E87A4,
		bottomRight = 0x410E87AA,
		bottomLeft = 0x410E87A8,
		top = 0x410E87A6,
		right = 0x410E87AB,
		bottom = 0x410E87A9,
		left = 0x410E87A7
	},
	
	GrainyBlue = { --512x
		center = 0x4111079E
	}
};


