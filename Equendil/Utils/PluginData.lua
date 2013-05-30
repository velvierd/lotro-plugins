-- Turbine.PluginData.Save() saves numbers in a way that is locale dependant and causes TurbinePluginData.Load() to fail on German and French clients.
-- This is a workaround for those functions.
-- Numbers are converted to strings and prefixed with "_lf_" before saving, for convertion back to numbers when loading
-- Obviously, any data saved shouldn't have strings beginning with "_lf_" or chaos will ensue.

PluginData = {}; -- namespace

-- 'Fix' 'data' in a locale invariant way. Resursive
local function _Encode( data )
	if type( data ) == "number" then
		-- if we have a number, convert to string and add a prefix
		return "_lf_" .. tostring( data );
	elseif type( data ) == "table" then
		-- build a new table and fill in with "fixed" keys and values
		local newTable = {};
		for k, v in pairs( data ) do 
			newTable[_Encode(k)] = _Encode( v );
		end

		return newTable;
	else
		return data;
	end
end

-- Converts 'fixed' data back into normal data. Recursive
local function _Decode( data )
	if type( data ) == "string" then
		if string.find( data, "_lf_" ) then
			return tonumber( string.sub( data, 5 ) );
		else
			return data;
		end
	elseif type( data ) == "table" then
		local newTable = {};
		for k, v in pairs( data ) do
			newTable[_Decode(k)] = _Decode(v);
		end

		return newTable;
	else
		return data;
	end

end

-- Straight teplacement for Turbine.PluginData.Save()
function PluginData.Save( dataScope, key, data, saveCompleteEventHandler )
	--[[ 	-- Actually, GetLocale() seems to return the OS locale, while the data is mangled depending on the client's locale *sigh*, we'll just always convert 
	if Turbine.Engine.GetLocale() ~= "en" then -- no need to "fix" the data if the locale is english

	end
	--]]

	-- return Turbine.PluginData.Save( dataScope, key, data, saveCompleteEventHandler );
	return Turbine.PluginData.Save( dataScope, key, _Encode( data ), saveCompleteEventHandler );
end

-- Straight replacement for Turbine.PluginData.Load()
function PluginData.Load( dataScope, key, dataLoadEventHandler )
	local dataLoaded = function( data )
		dataLoadEventHandler( _Decode( data ) );
	end

	return _Decode( Turbine.PluginData.Load( dataScope, key, dataLoaded ) );
	
end
