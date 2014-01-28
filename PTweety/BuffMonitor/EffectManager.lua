import "Turbine";
import "Turbine.UI";
import "Turbine.Gameplay";
import "PTweety.BuffMonitor.Utils";

local EffectMgr = class();

EffectMgr.Events = {};
EffectMgr.Events.EffectAdded = 1;
EffectMgr.Events.EffectRemoved = 2;

--[[
	-- define EffectMgr
--]]

function EffectMgr:Constructor()
	self.useStack = false;

	-- This is explicitly set to false because a call to SetEnabled is necessary
	self.enabled = false;

	self.callbacks = {};

	self.localPlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
	self.effectList = self.localPlayer:GetEffects();
	
	self.effectStack = {};

	-- configure refresh timer for the stack
	if ( self.useStack ) then
		self.Timer = PTweety.BuffMonitor.Utils.Timer( 100 ); -- 1/10 second
	
		self.Timer.OnTick = function( sender, args )
			self:FireEvents();
		end
	end
	
	-- configure callbacks
	self.effectCallbacks = {};
	
	self.effectCallbacks.EffectAdded = function( sender, args )
		if ( self.useStack ) then
			self:AddToStack( self.localPlayer:GetEffects():Get(args.Index), EffectMgr.Events.EffectAdded );
		else
			self:AddEffect( self.localPlayer:GetEffects():Get(args.Index) );
		end
	end

	self.effectCallbacks.EffectRemoved = function( sender, args )
		if ( self.useStack ) then
			self:AddToStack( args.Effect, EffectMgr.Events.EffectRemoved );
		else
			self:RemoveEffect( args.Effect );
		end
	end

	self.effectCallbacks.EffectsCleared = function( sender, args )
		if ( self.useStack ) then
			-- need to handle this?
		else
			self:ClearEffects();
		end
	end
end

function EffectMgr:IsEnabled()
	return self.enabled;
end

function EffectMgr:SetEnabled( bValue )
	if ( self.enabled ~= bValue ) then
		self.enabled = bValue;

		if ( self.enabled ) then
			-- register callbacks
			PTweety.BuffMonitor.Utils.AddCallback( self.effectList, "EffectAdded", self.effectCallbacks.EffectAdded );
			PTweety.BuffMonitor.Utils.AddCallback( self.effectList, "EffectRemoved", self.effectCallbacks.EffectRemoved );
			PTweety.BuffMonitor.Utils.AddCallback( self.effectList, "EffectsCleared", self.effectCallbacks.EffectsCleared );

			if ( self.useStack ) then
				-- initialize the stack
				for i = 1, self.effectList:GetCount() do
					self:AddToStack( self.effectList:Get( i ), EffectMgr.Events.EffectAdded );
				end

				-- start refresh timer for the stack
				self.Timer:SetEnabled( true );
			end
		else
			-- unregister callbacks
			PTweety.BuffMonitor.Utils.RemoveCallback( self.effectList, "EffectAdded", self.effectCallbacks.EffectAdded );
			PTweety.BuffMonitor.Utils.RemoveCallback( self.effectList, "EffectRemoved", self.effectCallbacks.EffectRemoved );
			PTweety.BuffMonitor.Utils.RemoveCallback( self.effectList, "EffectsCleared", self.effectCallbacks.EffectsCleared );

			if ( self.useStack ) then
				-- wipe the stack
				for k in pairs(self.effectStack) do
					self:RemoveFromStack( k );
				end

				-- stop refresh timer for the stack
				self.Timer:SetEnabled( false );
			end
		end
	end
end

function EffectMgr:Destroy()
	self:SetEnabled( false );
	self.callbacks = nil;
	self.effectStack = nil;
	self.effectCallbacks = nil;
	if ( self.useStack ) then
		self.Timer = nil;
	end
end


--[[
	-- handle callbacks
--]]

function EffectMgr:AddCallback( cControl )
	self:RemoveCallback( cControl );
	table.insert( self.callbacks, cControl );
end

function EffectMgr:RemoveCallback( cControl )
	for i = 1, table.getn( self.callbacks ) do
		if ( self.callbacks[i] == cControl ) then
			table.remove( self.callbacks, i );
			break;
		end
	end
end


--[[
	-- handle stack
--]]

function EffectMgr:AddToStack( cEffect, nEvent )
	-- effect cannot be nil
	if ( cEffect == nil ) then
		return;
	end

	-- effect is already on the stack
	if ( self.effectStack[cEffect] ~= nil ) then
		self.effectStack[cEffect] = nil;
		return;
	end

	self.effectStack[cEffect] = nEvent;
end

function EffectMgr:RemoveFromStack( cEffect )
	-- effect is not on the stack
	if ( self.effectStack[cEffect] == nil ) then
		return;
	end

	self.effectStack[cEffect] = nil;
end

function EffectMgr:FireEvents()
	-- see: http://www.lua.org/pil/19.3.html
	local function pairsByIDs( tSort )
		-- index table for sorting
		local tIndex = {}
		for n in pairs( tSort ) do table.insert( tIndex, n ); end
		table.sort( tIndex, function( arg1, arg2 ) if arg1:GetID() < arg2:GetID() then return true; end end );

		-- iterator variable
		local i = 0;

		-- iterator function
		local fIterator = function ()
			i = i + 1;
			if tIndex[i] == nil then
				return nil;
			else
				return tIndex[i], tSort[tIndex[i]];
			end
		end

		return fIterator;
	end

	-- process effects on the stack sorted by ID
	for k, v in pairsByIDs( self.effectStack ) do
		if ( v ~= nil ) then
			if ( v == EffectMgr.Events.EffectAdded ) then
				self:AddEffect( k );
			elseif ( v == EffectMgr.Events.EffectRemoved ) then
				self:RemoveEffect( k );
			end
		end
		self:RemoveFromStack( k );
	end
end


--[[
	-- trigger events
--]]

function EffectMgr:AddEffect( cEffect )
	-- trigger all registered callbacks
	for i = 1, table.getn( self.callbacks ) do
		if ( type( self.callbacks[i].EffectAdded ) == "function" ) then
			self.callbacks[i]:EffectAdded( cEffect );
		end
	end
end

function EffectMgr:RemoveEffect( cEffect )
	-- trigger all registered callbacks
	for i = 1, table.getn(self.callbacks) do
		if ( type( self.callbacks[i].EffectRemoved ) == "function" ) then
			self.callbacks[i]:EffectRemoved( cEffect );
		end
	end
end

function EffectMgr:ClearEffects()
	-- trigger all registered callbacks
	for i = 1, table.getn(self.callbacks) do
		if ( type( self.callbacks[i].EffectsCleared ) == "function" ) then
			self.callbacks[i]:EffectsCleared();
		end
	end
end


--[[
	-- get the (initial!) list of effects
--]]

function EffectMgr:GetEffects() -- returns {}
	if ( self.enabled ) then
		return self.localPlayer:GetEffects();
	else
		return {};
	end
end

-- instance of effect manager
EffectManager = EffectMgr();