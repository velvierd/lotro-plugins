
SETTINGS = {}; -- Table used when loading settings.
TEMP_SETTINGS = {};
_BLACKLIST = {};
_ITEMIGNORE = {};
_SHOUTS = {};

blSAVED = false;

PLUGINNAME = "Raid Assistant";

RESOURCEDIR = "GaluhadPlugins/RaidAssistant/Resources/";

SELECTEDSHOUT = 0;

SCREENWIDTH = Turbine.UI.Display.GetWidth();
SCREENHEIGHT = Turbine.UI.Display.GetHeight();
TRANSPARENT = Turbine.UI.Color(0,0,0,0); -- ARGB
WHITE = Turbine.UI.Color(1,1,1);
BLACK = Turbine.UI.Color(0,0,0);
GREEN = Turbine.UI.Color(0,1,0);
RED = Turbine.UI.Color(1,0,0);
YELLOW = Turbine.UI.Color(1,1,0);
clrSHOUTOVER = Turbine.UI.Color(0.7,0,0,0);
clrSHOUTOUT = Turbine.UI.Color(0.2,0,0,0);
ORANGE = Turbine.UI.Color(247/255,148/255,29/255);
SHOUTNORM = Turbine.UI.Color(1/255,13/255,37/255);
SHOUTOVER = Turbine.UI.Color(3/255,25/255,59/255);
SHOUTSEL = Turbine.UI.Color(35/255,22/255,114/255);
ROLLSBLISTED = Turbine.UI.Color(1,0.1,0.1);

HFONT = Turbine.UI.Lotro.Font.TrajanPro16;
BFONT = Turbine.UI.Lotro.Font.TrajanPro14;
HFONTCOLOR = Turbine.UI.Color((201/255),(195/255),(98/255));
BUTTONCOLOR = Turbine.UI.Color((220/255),(180/255),(90/255));
LISTFONT = Turbine.UI.Lotro.Font.Verdana12;
EDITFONT = Turbine.UI.Lotro.Font.Verdana14;

CHATLOG = Turbine.Chat;

--GROUP GLOBALS
MYCHAR = Turbine.Gameplay.LocalPlayer.GetInstance();
--MYPARTY = MYCHAR:GetParty();
MYNAME = MYCHAR:GetName();
GROUPSIZE = 0;
GROUPMEMBER = {};
GROUPLEADER = "";
_PARTYBLISTED = {};
--MYPARTY = {};

-- ROLLS GLOBALS
_ROLLS = {};	-- Table for storing rolls.
ROLLCOUNTER = 1;
CURLOOTRULE = "Not in group";
CURLOOTQUAL = "Unknown";

-- LOOT HISTORY GLOBALS
_LOOT = {}; -- Table for storing loot HISTORY.
_LOOTDROPDOWN = {};
LOOTSTARTDATE = "";
LOOTID = 1;

-- RAID SHOUT GLOBALS
MAXRAIDSHOUTLENGTH = 100;
MAXSHOUTLENGTH = 384;
SHOUTRESIZECTRL = 5;
MAXCATLENGTH = 18;

-- BLACKLIST GLOBALS
SELECTEDBL = nil;
SELBLNAME = "";

-- RAID LOG GLOBALS
_RAIDLOG = {};
_LOGTYPE = {[1] = "Roll"; [2] = "Item"; [3] = "Group"; [4] = "Win";};
LOGSTART = "";
LOGFINISH = "";
blLOGGING = false;


-- Random Variables
blDRAGGING = false;
relX = 0;
relY = 0;

-- Detect client lang.
CLIENTLANG = "ENGLISH";
-- DToX Start
local Locale = Turbine.Engine.GetLocale();
-- DToX End
if Turbine.Shell.IsCommand("hilfe") then
	CLIENTLANG = "GERMAN";
elseif Turbine.Shell.IsCommand("aide") then
	CLIENTLANG = "FRENCH";
elseif (Locale == 268435463) or (Locale == "ru") then
	CLIENTLANG = "RUSSIAN";
end

-- Default Settings
DEFAULT_SETTINGS =
	{
	["LANGUAGE"] = CLIENTLANG;
	["MSGCOLOR"] = "FFFFFF";

	["ICONX"] = 10;
	["ICONY"] = 10;
	["ICONVIS"] = true;

	["ROLLS"] =
		{
		["VISIBLE"] = false;
		["CHKUNIQUE"] = true;
		["X"] = (SCREENWIDTH/2)-210;
		["Y"] = SCREENHEIGHT/3;
		};

	["LOOT"] =
		{
		["VISIBLE"] = false;
		["CHKROLLS"] = false;
		["SELF_ENABLED"] = true;
		["FELLOW_ENABLED"] = true;
		["X"] = (SCREENWIDTH/2)-210;
		["Y"] = SCREENHEIGHT/3;

		};

	["LFF"] =
		{
		["VISIBLE"] = false;
		["X"] = (SCREENWIDTH/2)-210;
		["Y"] = SCREENHEIGHT/3;
		};

	["LOG"] =
		{
		["VISIBLE"] = false;
		["X"] = (SCREENWIDTH/2)-250;
		["Y"] = (SCREENHEIGHT/2) - 300;
		["COLOR_ROLLS"] = YELLOW;
		["COLOR_ITEMS"] = WHITE;
		["COLOR_GROUP"] = GREEN;
		["COLOR_WIN"] = ORANGE;
		};

	["BLACKLIST"] =
		{
		["VISIBLE"] = false;
		["X"] = (SCREENWIDTH/2)-210;
		["Y"] = SCREENHEIGHT/3;
		};

	["INSTANCES"] =
		{
		["VISIBLE"] = false;
		["X"] = (SCREENWIDTH/2)-210;
		["Y"] = SCREENHEIGHT/3;
		};

	["SETTWIN"] =
		{
		["VISIBLE"] = true;	-- DToX; Plugin default - false
		["X"] = (SCREENWIDTH/2)-210;
		["Y"] = SCREENHEIGHT/3;
		};

	["SHOUTS"] =
		{
		["VISIBLE"] = false;
		["X"] = (SCREENWIDTH/2)-210;
		["Y"] = SCREENHEIGHT/3;
		};

	["MINSHOUTS"] =
		{
		["X"] = (SCREENWIDTH/2)-210;
		["Y"] = SCREENHEIGHT/3;
		["SHOW"] = false;
		["SHOWLEAD"] = false;
		["WIDTH"] = 300;
		["HEIGHT"] = 150;
		};

	};

-- DToX Start
if CLIENTLANG == "RUSSIAN" then
	_LOGTYPE = {[1] = "Бросок"; [2] = "Предметы"; [3] = "Группа"; [4] = "Выигрыш";};
	CURLOOTRULE = "Нет группы";
	CURLOOTQUAL = "Неизвестно";
end
-- DToX End