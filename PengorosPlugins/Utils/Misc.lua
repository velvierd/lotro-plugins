import "Turbine.UI";

local loadedLocale = nil;

-- returns a default local object
function DefaultLocale()
    local L = {};
    setmetatable(L, {__index=function(L, key) return key; end;});
    return L;
end

-- loads the localization strings for the given package
function ImportLocale(package)
    pcall(import, ("%s.locale.%s"):format(package, GetLocale()));
end

function GetLocale()
	if (loadedLocale == nil) then
		loadedLocale = Turbine.PluginData.Load(Turbine.DataScope.Account, "BuffBarsLocale");
		if (loadedLocale == nil) then
			local language = Turbine.Engine.GetLanguage();
			local locale = (language == Turbine.Language.German and "de" or (language == Turbine.Language.French and "fr" or (language == Turbine.Language.Russian and "ru" or "en" )));
			SetLocale(locale);
		end
	end
	return loadedLocale;
end

function SetLocale(locale)
	Turbine.PluginData.Save(Turbine.DataScope.Account, "BuffBarsLocale", locale);
	loadedLocale = locale;
end

-- constrain the window to the display
function ValidatePosition(x, y, width, height)
    x = math.min(math.max(x, 0), Turbine.UI.Display:GetWidth() - width);
    y = math.min(math.max(y, 0), Turbine.UI.Display:GetHeight() - height);
    return x, y;
end

function ModalWindow(dialog, parent)
    -- put a panel in front of the parent to prevent other input until they get rid of the modal window
    dialog._modal = Turbine.UI.Control();
    dialog._modal:SetParent(parent);
    dialog._modal:SetPosition(0, 0);
    dialog._modal:SetSize(parent:GetSize());
    --dialog._modal:SetVisible(true);
    dialog._modal:SetZOrder(8);
    dialog._modal.MouseClick = function(sender, args)
        dialog:Activate();
        dialog:Focus();
    end
    
    -- trap the close event
    AddListener(dialog, "Closed", function(sender, args)
        dialog._modal:SetVisible(false);
        dialog._modal:SetParent(nil);
        dialog._modal.MouseClick = nil;
        dialog._modal = nil;
    end);
    
    -- show it
    dialog:SetZOrder(9);
    dialog:SetVisible(true);
end

function EscapeMatch(s)
	if (s ~= nil) then
		return s:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]','%%%1');
	end
	return s;
end

function UnescapeMatch(s)
	if (s ~= nil) then
		return s:gsub('%%([%-%.%+%[%]%(%)%$%^%%%?%*])', '%1');
	end
	return s;
end

-- deep copy an object
function DeepCopy(object)
    local lookup_table = {};
    local function _copy(object)
        if (type(object) ~= "table") then
            return object;
        elseif (lookup_table[object]) then
            return lookup_table[object];
        end
        local new_table = {};
        lookup_table[object] = new_table;
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value);
        end
        return setmetatable(new_table, getmetatable(object));
    end
    return _copy(object);
end

-- safely add a listener without overwriting any existing ones
function AddListener(object, event, listener)
    if (object[event] == nil) then
        object[event] = listener;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], listener);
        else
            object[event] = {object[event], listener};
        end
    end
    return listener;
end

-- safely remove a listener without clobbering any extras
function RemoveListener(object, event, listener)
    if (object[event] == listener) then
        object[event] = nil;
    else
        if (type(object[event]) == "table") then
            local size = table.getn(object[event]);
            for i = 1, size do
                if (object[event][i] == listener) then
                    table.remove(object[event], i);
                    break;
                end
            end
        end
    end
end

-- safely execute a listener whether it be an array of functions or a single one
function ExecuteListener(object, event, args)
    if (type(object[event]) == "function") then
        object[event](object, args);
    else
        if (type(object[event]) == "table") then
            local size = table.getn(object[event]);
            for i = 1, size do
                if (type(object[event][i]) == "function") then
                    object[event][i](object, args);
                end
            end
        end
    end
end

-- common time formatters, values passed are in seconds
TimeFormat = {};
TimeFormat.LITERAL = function(value)
	return tonumber(string.format("%.1f", value));
end
TimeFormat.TRUNCATED = function(value)
    if (value >= 3600) then
        if value % 3600 == 0 then
            value = ("%dh"):format(value / 3600)
        else
            value = ("%.1fh"):format(value / 3600)
        end
    elseif (value >= 60) then
        if value % 60 == 0 then
            value = ("%dm"):format(value / 60)
        else
            value = ("%.1fm"):format(value / 60)
        end
    else
        value = ("%ds"):format(value);
    end
    return value;
end
TimeFormat.CLOCK = function(value)
    if (value >= 3600) then
        local sec = math.fmod(value, 3600) / 60;
        value = ("%d:%02d:%02d"):format(value / 3600, value % 3600 / 60, value % 60);
    elseif (value >= 60) then
        value = ("%d:%02d"):format(value / 60, value % 60);
    else
        value = ("0:%02d"):format(value);
    end
    return value;
end

-- encode numbers as strings if necessary for the client to save properly
function EncodeNumbers(object)
    if ("en" == Turbine.Engine.GetLocale()) then
        return object;
    end

    local lookup_table = {};
    local function _encode(object)
        if (type(object) == "number") then
            return ("<num>%f</num>"):format(object);
        elseif (type(object) ~= "table") then
            return object;
        elseif (lookup_table[object]) then
            return lookup_table[object];
        end
        local new_table = {};
        lookup_table[object] = new_table;
        for index, value in pairs(object) do
            new_table[_encode(index)] = _encode(value);
        end
        return setmetatable(new_table, getmetatable(object));
    end
    return _encode(object);
end

-- decode numbers encoded as strings
function DecodeNumbers(object)
    if ("en" == Turbine.Engine.GetLocale()) then
        return object;
    end
    
    local lookup_table = {};
    local function _decode(object)
        if (type(object) == "string") then
            local match = object:match("<num>(%d+.%d+)</num>");
            if (match ~= nil) then
                return tonumber(match);
            else
                return object;
            end
        elseif (type(object) ~= "table") then
            return object;
        elseif lookup_table[object] then
            return lookup_table[object];
        end
        local new_table = {};
        lookup_table[object] = new_table;
        for index, value in pairs(object) do
            new_table[_decode(index)] = _decode(value);
        end
        return setmetatable(new_table, getmetatable(object));
    end
    return _decode(object);
end
