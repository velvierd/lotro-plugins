-- Turbine Imports..
import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

-- Plugin Imports
import "GaluhadPlugins.RaidAssistant.VindarPatch";
import "GaluhadPlugins.RaidAssistant.Globals";
import "GaluhadPlugins.RaidAssistant.UTF";
import "GaluhadPlugins.RaidAssistant.Languages";
import "GaluhadPlugins.RaidAssistant.Includes.Commands";
import "GaluhadPlugins.RaidAssistant.Includes.Onscreen";
import "GaluhadPlugins.RaidAssistant.Includes.MessageBox";
import "GaluhadPlugins.RaidAssistant.Includes.InstancesDB";
import "GaluhadPlugins.RaidAssistant.Includes.SkirmsDB";
import "GaluhadPlugins.RaidAssistant.Includes.ChatLogger";
import "GaluhadPlugins.RaidAssistant.Includes.ColorPicker";
import "GaluhadPlugins.RaidAssistant.Includes.DropDown";
import "GaluhadPlugins.RaidAssistant.Includes.Group";
import "GaluhadPlugins.RaidAssistant.Windows.IconWindow";
import "GaluhadPlugins.RaidAssistant.Windows.Shouts";
import "GaluhadPlugins.RaidAssistant.Windows.Rolls";
import "GaluhadPlugins.RaidAssistant.Windows.LootHistory";
import "GaluhadPlugins.RaidAssistant.Windows.LFF";
import "GaluhadPlugins.RaidAssistant.Windows.BList";
import "GaluhadPlugins.RaidAssistant.Windows.Instances";
import "GaluhadPlugins.RaidAssistant.Windows.Settings";
import "GaluhadPlugins.RaidAssistant.Windows.Log";


-- Dump table function for checking tables on the fly ---------------
function dump(o)
    if type(o) == 'table' then
        local s = '{\n'
        for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. dump(v) .. '\n'
        end
        return s .. '}\n'
    else
        return tostring(o)
    end
end


--This function returns a deep copy of a given table ---------------
function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end


-- This function merges table two into table one, overwriting any matching entries.
function mergeTables(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			mergeTables(t1[k], t2[k])
		else
			t1[tostring(k)] = v
		end
	end
	return t1
end


function saveData()

	-- Store the settings table.
	PatchDataSave(Turbine.DataScope.Character, "RaidAssistant_Settings", SETTINGS);
	PatchDataSave(Turbine.DataScope.Server, "RaidAssistant_BlackList", _BLACKLIST);
	PatchDataSave(Turbine.DataScope.Account, "RaidAssistant_ItemIgnore", _ITEMIGNORE);
	PatchDataSave(Turbine.DataScope.Account, "RaidAssistant_Shouts", _SHOUTS);

end


function loadData()

	local SavedSettings = {};
	local SavedBlacklist = {};
	local SavedIgnoreList = {};
	local SavedShouts = {};

	-- Load the settings
	function GetSavedSettings()
		SavedSettings = PatchDataLoad(Turbine.DataScope.Character, "RaidAssistant_Settings");
	end

	if pcall(GetSavedSettings) then
		-- Loaded without error
		SavedSettings = PatchDataLoad(Turbine.DataScope.Character, "RaidAssistant_Settings");
	else
		-- Loaded with errors
		SavedSettings = nil;
		-- DToX Start
		if SETTINGS.LANGUAGE == "RUSSIAN" then
			Turbine.Shell.WriteLine("Ошибка при загрузке сохраненных настроек");
		else	-- plugin default
			Turbine.Shell.WriteLine("Error loading saved settings");
		end
		-- DToX End
	end


	function GetSavedBlacklist()
		SavedBlacklist = PatchDataLoad(Turbine.DataScope.Server, "RaidAssistant_BlackList");
	end

	if pcall(GetSavedBlacklist) then
		-- Loaded without error
		SavedBlacklist = PatchDataLoad(Turbine.DataScope.Server, "RaidAssistant_BlackList");
	else
		-- Loaded with errors
		SavedBlacklist = nil;
		-- DToX Start
		if SETTINGS.LANGUAGE == "RUSSIAN" then
			Turbine.Shell.WriteLine("Ошибка при загрузке сохраненного черного списка");
		else	-- plugin default
			Turbine.Shell.WriteLine("Error loading saved blacklist");
		end
		-- DToX End
	end


	function GetSavedShouts()
		SavedShouts = PatchDataLoad(Turbine.DataScope.Account, "RaidAssistant_Shouts");
	end

	if pcall(GetSavedShouts) then
		-- Loaded without error
		SavedShouts = PatchDataLoad(Turbine.DataScope.Account, "RaidAssistant_Shouts");
	else
		-- Loaded with errors
		SavedShouts = nil;
		-- DToX Start
		if SETTINGS.LANGUAGE == "RUSSIAN" then
			Turbine.Shell.WriteLine("Ошибка при загрузке сохраненных криков");
		else	-- plugin default
			Turbine.Shell.WriteLine("Error loading saved shouts");
		end
		-- DToX End
	end


	function GetSavedIgnore()
		SavedIgnoreList = PatchDataLoad(Turbine.DataScope.Account, "RaidAssistant_ItemIgnore");
	end

	if pcall(GetSavedIgnore) then
		-- Loaded without error
		SavedIgnoreList = PatchDataLoad(Turbine.DataScope.Account, "RaidAssistant_ItemIgnore");
	else
		-- Loaded with errors
		SavedIgnoreList = nil;
		-- DToX Start
		if SETTINGS.LANGUAGE == "RUSSIAN" then
			Turbine.Shell.WriteLine("Ошибка при загрузке списка исключенных трофеев");
		else	-- plugin default
			Turbine.Shell.WriteLine("Error loading saved ignore list");
		end
		-- DToX End
	end


		-- Check the saved settings to make sure it is still compatible with newer updates, add in any missing default settings
	if type(SavedSettings) == 'table' then

		local tempSETTINGS = {};
		tempSETTINGS = deepcopy(DEFAULT_SETTINGS);

		SETTINGS = mergeTables(tempSETTINGS,SavedSettings);

		GAMessage("v" .. Plugins["RaidAssistant"]:GetVersion());

	else

		SETTINGS = deepcopy(DEFAULT_SETTINGS);

		GAMessage("v" .. Plugins["RaidAssistant"]:GetVersion());

	end

	-- Check the Blacklist to see if it's valid.
	if type(SavedBlacklist) == 'table' then

		_BLACKLIST = deepcopy(SavedBlacklist);

	else

		_BLACKLIST = {};

	end

	-- Check the Ignored Item list to see if it's valid.
	if type(SavedIgnoreList) == 'table' then

		_ITEMIGNORE = deepcopy(SavedIgnoreList);

	else

		_ITEMIGNORE = {};

	end

	-- Check the Shouts list to see if it's valid.
	if type(SavedShouts) == 'table' then

		_SHOUTS = deepcopy(SavedShouts);

	else

		_SHOUTS = {};

	end

end


Turbine.Plugin.Unload = function (sender, args)

	-- Save the data when the plugin unloads.
	saveData();

end


function DrawWindows()

	Windows.DrawIconWindow();
	Windows.DrawRollWindow();
	Windows.DrawLootHisWindow();
	Windows.DrawLFFWindow();
	Windows.DrawBListWindow();
	Windows.DrawInstWindow();
	Windows.DrawSettWindow();
	Windows.DrawLogWindow();
	Windows.DrawShoutsWindow();
end


function GAMessage(Message)

	Turbine.Shell.WriteLine("<rgb=#" .. SETTINGS.MSGCOLOR .. ">" .. PLUGINNAME .. ": " .. Message .. ".</rgb>");

end


function BLMessage(Message)

	Turbine.Shell.WriteLine("<rgb=#FF0000>" .. PLUGINNAME .. ": " .. Message .. ".</rgb>");

end



-- Load the data when the plugin loads
loadData();
Includes.InitiateChatLogger();
--DrawWindows();
Includes.GroupLoad();
DrawWindows();
Includes.RegisterCommands();


