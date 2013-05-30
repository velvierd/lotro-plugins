-- Turbine's Event class modified to use weak references

-- Rationale: 
-- 1) Strong references to event handlers prevent .the garbage collector from reaching them, unless they are removed manually.
-- 2) failing to remove event handlers causes memory leaks (of the event handlers themselves and any object they keep strong references on). 
-- 3) removing event handlers manually causes design issues typical of languages *without* garbage collection. Dispose() chains, besides the additional code 
-- involved, run counter to the very idea of automated resource management and may force early disposal of objects still in use elsewhere.

-- Advantage: Event handlers not (strongly) referenced anywhere else are in reach of the garbage collector

-- Disadvantage: Caller is responsible for keeping references on event handlers for as long as they are needed. Most notably, anonymous 
-- functions cannot be used as event handlers as they would be removed in the next garbage collection cycle. This is a small price to pay 
-- to avoid more annoying design issues however..

import "Equendil.Utils.Class";

local WeakEventMetatable;
local WeakEventInfo;
local WeakEventInstanceMetatable;

WeakEvent, WeakEventMetatable, WeakEventInfo, WeakEventInstanceMetatable = class();

--[[

If event is a function, invokes the function with the passed arguments. If
event is a table, iterate through all the elements of the table and invoke
any functions with the passed arguments.

This event class simulates the logic used by the native packages for firing
events so it maintains a nice consistency with existing events.

]]--
function WeakEvent:Constructor()
	self.eventHandlers = setmetatable({}, {__mode="k"});
end

function WeakEvent:Add( eventHandler )
	self.eventHandlers[eventHandler] = true;
end

function WeakEvent:Remove( eventHandler )
	if eventHandler == nil then return end
	self.eventHandlers[eventHandler] = nil;
end

function WeakEvent.Fire( event, ... )
	local type = Type.StaticGetType( event );
	local eventHandlers = nil;

	if ( type:IsClass() and type:GetClass() == WeakEvent ) then
		eventHandlers = event.eventHandlers;
	elseif ( type:IsFunction() ) then
		eventHandlers = { event = event };
	elseif ( type:IsTable() ) then
		eventHandlers = event;
	end

	if ( eventHandlers ~= nil ) then	
		for k, v in pairs( eventHandlers ) do
			local subType = Type.StaticGetType( k );

			if ( subType:IsFunction() ) then
				k( ... );
			end
		end
	end
end

function WeakEventInstanceMetatable.__call( self, ... )
	WeakEvent.Fire( self, ... );
end
