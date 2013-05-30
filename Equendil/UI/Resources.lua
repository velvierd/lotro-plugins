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


