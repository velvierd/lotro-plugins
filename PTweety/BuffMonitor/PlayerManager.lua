import "Turbine";
import "Turbine.UI";
import "Turbine.Gameplay";
import "PTweety.BuffMonitor.Utils";

local PlayerMgr = class();

--[[
	-- define PlayerMgr
--]]

function PlayerMgr:Constructor()
	-- This is explicitly set to false because a call to SetEnabled is necessary
	self.enabled = false;

	self.callbacks = {};

	self.localPlayer = Turbine.Gameplay.LocalPlayer.GetInstance();

	-- configure callbacks
	self.playerCallbacks = {};
	
	self.playerCallbacks.InCombatChanged = function( sender, args )
		self:FireInCombat();
	end

	self.playerCallbacks.MountChanged = function( sender, args )
		self:FireMounted();
	end
end

function PlayerMgr:IsEnabled()
	return self.enabled;
end

function PlayerMgr:SetEnabled( bValue )
	if ( self.enabled ~= bValue ) then
		self.enabled = bValue;

		if ( self.enabled ) then
			-- register callbacks
			PTweety.BuffMonitor.Utils.AddCallback( self.localPlayer, "InCombatChanged", self.playerCallbacks.InCombatChanged );
			PTweety.BuffMonitor.Utils.AddCallback( self.localPlayer, "MountChanged", self.playerCallbacks.MountChanged );
		else
			-- unregister callbacks
			PTweety.BuffMonitor.Utils.RemoveCallback( self.localPlayer, "InCombatChanged", self.playerCallbacks.InCombatChanged );
			PTweety.BuffMonitor.Utils.RemoveCallback( self.localPlayer, "MountChanged", self.playerCallbacks.MountChanged );
		end
	end
end

function PlayerMgr:Destroy()
	self:SetEnabled( false );
	self.callbacks = nil;
	self.playerCallbacks = nil;
end

function PlayerMgr:GetPlayer()
    return self.localPlayer;
end

function PlayerMgr:IsInCombat()
	return self.localPlayer:IsInCombat();
end

function PlayerMgr:IsMounted()
	if ( self.localPlayer:GetMount() == nil ) then return false; else return true; end
end

-- handle callbacks

function PlayerMgr:AddCallback( cControl )
	self:RemoveCallback( cControl );
	table.insert( self.callbacks, cControl );
end

function PlayerMgr:RemoveCallback( cControl )
	for i = 1, table.getn( self.callbacks ) do
		if ( self.callbacks[i] == cControl ) then
			table.remove( self.callbacks, i );
			break;
		end
	end
end

-- trigger events
function PlayerMgr:FireInCombat()
	-- trigger all registered callbacks
    for i = 1, table.getn( self.callbacks ) do
        if ( type( self.callbacks[i].InCombatChanged) == "function" ) then
            self.callbacks[i]:InCombatChanged( self:IsInCombat() );
        end
    end
end

function PlayerMgr:FireMounted()
	-- trigger all registered callbacks
    for i = 1, table.getn( self.callbacks ) do
        if ( type( self.callbacks[i].MountChanged) == "function" ) then
            self.callbacks[i]:MountChanged( self:IsMounted() );
        end
    end
end

-- instance of player manager
PlayerManager = PlayerMgr();