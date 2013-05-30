-- Various tables for the cost of legacies at each rank

-- Costs of a default legacy per rank. Default legacies don't have tiers, so only one inner table.
CostTableDefault = { {14, 21, 30, 41, 54, 70 } };

-- REGULAR LEGACIES

-- Tables of  legacy costs / rank that most legacies use at various tiers. Tables are numbered by their rank 9 cost for 'easy' identification
local Cost252 = {32,48,69,95,126,163,205,252 };
local Cost216 =	{27,41,59,81,108,140,176,216 };
local Cost180 =	{23,34,49,68,90,117,147,180};
local Cost144 =	{18,27,39,54,72,93,117,144};

local Cost126 = {16,24,35,48,63,82,103,126 };
local Cost108 = {14,21,30,41,54,70,88,108 };
local Cost90 =	{12,17,25,34,45,59,74,90 };
local Cost72 = 	{9,14,20,27,36,47,59,72 }; -- 284

local Cost63 =	{8,12,18,24,32,41,52,63}; -- 250
local Cost54 =	{7,11,15,21,27,35,44,54 }; -- 214
local Cost45 =	{6,9,13,17,23,30,37,45 }; --180
local Cost36 =	{5,7,10,14,18,24,30,36 }; -- 144

local Cost32 =	{4,6,9,12,16,21,26,32}; -- 126
local Cost27 =	{4,6,8,11,14,18,22,27}; -- 110
local Cost23 =	{3,5,7,9,12,15,19,23}; --93
local Cost18 =	{3,4,5,7,9,12,15,18 }; -- 73

local Cost59 =	{8,11,16,22,30,38,48,59}; -- TODO 38 was 36 previously, was probably erroneous, need to keep an eye on it
local Cost50 = 	{7,10,14,19,25,32,41,50}; --198
local Cost41 = 	{6,8,11,16,21,27,33,41}; -- 163
local Cost16 =	{2,3,5,6,8,10,13,16}; -- 63

-- Tables of legacy costs per rank per tier, that are used for most legacies. Tables are numbered by their tier6/rank9 cost for 'easy" identification
CostTable72 = { Cost252, Cost216, Cost180, Cost144, Cost108, Cost72 }; -- 36*(8-t)  ?
CostTable63 = { Cost216, Cost180, Cost144, Cost108, Cost72, Cost63 };
CostTable54 = { Cost180, Cost144, Cost108, Cost72, Cost63, Cost54 }; -- 214
CostTable36 = { Cost126, Cost108, Cost90, Cost72, Cost54, Cost36 }; -- total at rank 9 = 144 points tor tier 6
CostTable32 = { Cost108, Cost90, Cost72, Cost54, Cost36, Cost32 }; -- total at rank 9 = 126 points tor tier 6 
CostTable27 = { Cost90, Cost72, Cost54, Cost36, Cost32, Cost27 }; -- total at rank 9 = 110 points for tier 6
CostTable27b = { Cost108, Cost72, Cost50, Cost41, Cost32, Cost27 };
CostTable23 = { Cost72, Cost59, Cost50, Cost41, Cost32, Cost23 }; --total at rank 9 = 93 points for tier 6
CostTable18 = { Cost63, Cost54, Cost45, Cost36, Cost27, Cost18 }; -- total at rank 9 = 73 points for tier 6
CostTable16 = { Cost54, Cost45, Cost36, Cost27, Cost23, Cost16 }; -- total at rank 9 = 73 points for tier 6


-- TARGET LEGACIES

-- Tables of legacy costs per rank for +target legacies @ various tiers
-- Five ranks, rank 2 variable
local CostTableTarget1_1 = {111,166,308,378};
local CostTableTarget1_2 = {95,142,264,324};
local CostTableTarget1_3 = {79,119,220,270};
local CostTableTarget1_4 = {63,95,176,216};
local CostTableTarget1_5 = {48,71,132,162};
local CostTableTarget1_6 = {32,48,88,108};
local CostTableTarget1_7 = {28,42,77,95};
local CostTableTarget1_8 = {24,36,66,81};

-- Call of the Second Age Targets (MNS), Ancient Craft Targets (LRM), Bane Flare Target (LRM), Fire-lore Targets (LRM), Guardian Area Effect Melee Targets (GRD)
CostTableTarget1 = { 
	CostTableTarget1_1, 
	CostTableTarget1_2, 
	CostTableTarget1_3, 
	CostTableTarget1_4, 
	CostTableTarget1_5, 
	CostTableTarget1_6 
};

-- Pressing Attack Max Targets (CPT)
CostTableTarget2 = { 
	CostTableTarget1_2, 
	CostTableTarget1_3, 
	CostTableTarget1_4, 
	CostTableTarget1_5, 
	CostTableTarget1_6, 
	CostTableTarget1_7 
};

-- Challenge Targets (GRD), Vivid Imagery Targets (RNK), Maximum Targets for AoE Skills (HNT)
CostTableTarget3 = { 
	CostTableTarget1_3, 
	CostTableTarget1_4, 
	CostTableTarget1_5, 
	CostTableTarget1_6, 
	CostTableTarget1_7, 
	CostTableTarget1_8 
};

-- MISC LEGACIES

-- Stealth Level (BRG), Stealth Detection (HNT)
CostTableStealth = { {48,71},{41,61},{34,51},{27,41},{21,31},{14,21} };

-- Ardour/Glory Pip Interval (CHP)
CostTablePipInterval = { {126,189,376}, {108,162,322}, {90,135,269}, {72,108,215}, {54,81,161}, {36,54,108} }; -- RoR checked T5,T6

-- Harmstring Range
CostTableHarmstringRange = CostTableStealth; -- TODO U5 check

-- Bridles
CostTableBridle63 = { -- essentially CostTable63 with half R1 costs
	{14,41,59,81}, -- extrapolated 14, could be 13 TODO
	{12,34,49,68},
	{9,27,39,54},
	{7,21,30,41},
	{5,14,20,27},
	{4,12,18,24}
};

CostTableBridle54 = { -- essentially CostTable54 with half R1 costs
	{12,34,49,68}, -- 12 extrapolated, might be 11 TODO
	{9,27,39,54},
	{7,21,30,41},
	{5,14,20,27},
	{4,12,18,24},
	{4,11,15,21},
};


-- not used in regular tables, but useful for *2 or *3  multipliers. 0 values are placeholders, should be replaced with multiplication for default
--local Cost378 = {0,0,0,0,0,0,0,0};
--local Cost324 = {0,0,0,0,0,210,264,324};
--local Cost270 = {0,0,0,0,135,175,0,0}; -- probably 269
--local Cost162 = {0,0,0,0,0,105,132,0};
--local Cost135 = {0,0,0,0,68,88,0,0};
--local Cost117 = {0,0,0,44,59,0,0,117};
--local Cost99 = {0,0,0,38,50,64,81,99};
--local Cost82 = {0,0,0,31,41,0,0,0}; -- probably 81

--[[
Cost252.Half = Cost126;
Cost216.Half = Cost108;
Cost180.Half = Cost90;
Cost144.Half = Cost72;
Cost126.Half = Cost63;
Cost108.Half = Cost54;
Cost90.Half = Cost45;
Cost72.Half = Cost36;
Cost63.Half = Cost32;
Cost54.Half = Cost27;
Cost45.Half = Cost23;
Cost36.Half = Cost18; 

Cost252.OneAndHalf = Cost378;
Cost216.OneAndHalf = Cost324;
Cost180.OneAndHalf = Cost270;
Cost144.OneAndHalf = Cost216;
-- Cost126.OneAndHalf = Cost189 needed, no data
Cost108.OneAndHalf = Cost162;
Cost90.OneAndHalf = Cost135 
Cost72.OneAndHalf = Cost108;
-- Cost63.OneAndHalf = Cost95 needed, no data
Cost54.OneAndHalf = Cost82;
Cost36.OneAndHalf = Cost54;
--]]
--[[
Cost126.Double = Cost252;
Cost108.Double = Cost216;
Cost90.Double = Cost180;
Cost72.Double = Cost144;
Cost63.Double = Cost126;
Cost54.Double = Cost108;
Cost45.Double = Cost90;
Cost36.Double = Cost72;
Cost32.Double = Cost63;
Cost27.Double = Cost54;
Cost23.Double = Cost45;
Cost18.Double = Cost36;
Cost59.Double = Cost117;
Cost50.Double = Cost99;
Cost41.Double = Cost82;

Cost126.Triple = Cost378;
Cost108.Triple = Cost324;
Cost90.Triple = Cost270;
Cost72.Triple = Cost216;
Cost54.Triple = Cost162;
Cost45.Triple = Cost135;
Cost36.Triple = Cost108;
-- Cost32.Triple = Cost96, needed, no data
Cost27.Triple = Cost82;
-- Cost23.Triple = needed, no data
Cost18.Triple = Cost54;
--]]
