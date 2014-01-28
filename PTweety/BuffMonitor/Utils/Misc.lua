
-- restrict windows to the displayable area
function ValidatePosition(x, y, width, height)
	x = math.min(math.max(x, 0), Turbine.UI.Display:GetWidth() - width);
	y = math.min(math.max(y, 0), Turbine.UI.Display:GetHeight() - height);
	return x, y;
end

-- Returns the distance between aPoint1 and aPoint2        
-- Spezial thanks to MrJackdaw
function DistancePointToPoint ( aPoint1, aPoint2 )
	return math.sqrt( ( aPoint2.x - aPoint1.x )^2 + ( aPoint2.y - aPoint1.y )^2 );
end

-- Returns the distance between aPoint and aLine
-- Spezial thanks to MrJackdaw
function DistancePointToLine( aPoint, aLine )
	local X = aLine[2].x - aLine[1].x;
	local Y = aLine[2].y - aLine[1].y;

	if ( X == 0 ) then --this is a vertical line
		return math.abs( aLine[1].x - aPoint.x );
	elseif ( Y == 0 ) then --this is a horizontal line
		return math.abs( aLine[1].y - aPoint.y );
	else -- aLine is neither vertical nor horizontal.
		return math.abs( ( X * ( aLine[1].y - aPoint.y ) - Y * ( aLine[1].x - aPoint.x ) ) / math.sqrt( X^2 + Y^2 ) );
	end
end


-- safely add a callback without overwriting any existing ones
-- see: http://forums.lotro.com/showthread.php?370323-LocalPlayer-instance-and-events
function AddCallback(object, event, callback)
	if (object[event] == nil) then
		object[event] = callback;
	else
		if (type(object[event]) == "table") then
			table.insert(object[event], callback);
		else
			object[event] = {object[event], callback};
		end
	end
end


-- safely remove a callback without clobbering any extras
function RemoveCallback(object, event, callback)
	if (object[event] == callback) then
		object[event] = nil;
	else
		if (type(object[event]) == "table") then
			local size = table.getn(object[event]);
			for i = 1, size do
				if (object[event][i] == callback) then
					table.remove(object[event], i);
					break;
				end
			end
		end
	end
end

-- safetly execute a callback
function ExecuteCallback(object, event, args)
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

-- deep copy a given table
-- see: http://lua-users.org/wiki/CopyTable
function DeepCopy(object)
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

-- deep copy a given table and encode numbers to stings
function DeepCopyEncode(object)
	if ( type(object) ~= "table" ) then
		return nil;
	else
		local lookup_table = {}
		local function _copy(object)
			if (type(object) == "number") then
				return string.format("INTEGER:%f", object);
			elseif type(object) ~= "table" then
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
end

-- deep copy a given table and decode stings to numbers
function DeepCopyDecode(object)
	if ( type(object) ~= "table" ) then
		return nil;
	else
		local lookup_table = {}
		local function _copy(object)
			if (type(object) == "string") then
				local capture = string.match(object, "INTEGER:(%d+.%d+)");
				if ( capture == nil ) then
					return object;
				else
					return tonumber(capture);
				end
			elseif type(object) ~= "table" then
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
end

--[[
function Debug(STRING)
    if STRING == nil or STRING == "" then return end;
    Turbine.Shell.WriteLine("<rgb=#FF5555>" .. STRING .. "</rgb>");
end

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
--]]