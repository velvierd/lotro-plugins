import "Turbine.Gameplay";
import "PengorosPlugins.Utils";

PlayerManager = {};

-- listeners
PlayerManager.listeners = {};

-- trap the player events
PlayerManager.player = Turbine.Gameplay.LocalPlayer.GetInstance();
PengorosPlugins.Utils.AddListener(PlayerManager.player, "InCombatChanged", function(sender, args)
    PlayerManager.FireInCombat();
end);
PengorosPlugins.Utils.AddListener(PlayerManager.player, "MaxMoraleChanged", function(sender, args)
    PlayerManager.FireMaxMorale();
end);
PengorosPlugins.Utils.AddListener(PlayerManager.player, "MoraleChanged", function(sender, args)
    PlayerManager.FireMorale();
end);
PengorosPlugins.Utils.AddListener(PlayerManager.player, "MaxPowerChanged", function(sender, args)
    PlayerManager.FireMaxPower();
end);
PengorosPlugins.Utils.AddListener(PlayerManager.player, "PowerChanged", function(sender, args)
    PlayerManager.FirePower();
end);
PengorosPlugins.Utils.AddListener(PlayerManager.player, "MountChanged", function(sender, args)
    PlayerManager.FireMount();
end);

-- additions for the lack of mount methods in the API
function PlayerManager.player:IsMounted()
    return self:GetMount() ~= nil;
end

function PlayerManager.player:IsOnCombatMount()
    local mount = self:GetMount();
    return mount ~= nil and mount:IsA(Turbine.Gameplay.CombatMount);
end

function PlayerManager.GetPlayer()
    return PlayerManager.player;
end

function PlayerManager.AddListener(listener)
    -- make sure it isn't in the list already
    PlayerManager.RemoveListener(listener);
    table.insert(PlayerManager.listeners, listener);
end

function PlayerManager.RemoveListener(listener)
    local i;
    for i = 1, table.getn(PlayerManager.listeners) do
        if (PlayerManager.listeners[i] == listener) then
            table.remove(PlayerManager.listeners, i);
            break;
        end
    end
end

function PlayerManager.FireInCombat()
    local i;
    local inCombat = PlayerManager.player:IsInCombat();
    for i = 1, table.getn(PlayerManager.listeners) do
        if (type(PlayerManager.listeners[i].InCombatChanged) == "function") then
            PlayerManager.listeners[i]:InCombatChanged(inCombat);
        end
    end
end

function PlayerManager.FireMount()
    local i;
    local mounted = PlayerManager.player:IsMounted();
    local combat = PlayerManager.player:IsOnCombatMount();
    for i = 1, table.getn(PlayerManager.listeners) do
        if (type(PlayerManager.listeners[i].MountChanged) == "function") then
            PlayerManager.listeners[i]:MountChanged(mounted, combat);
        end
    end
end

function PlayerManager.FireMaxMorale()
    local i;
    for i = 1, table.getn(PlayerManager.listeners) do
        if (type(PlayerManager.listeners[i].MaxMoraleChanged) == "function") then
            PlayerManager.listeners[i]:MaxMoraleChanged(PlayerManager.player);
        end
    end
end

function PlayerManager.FireMorale()
    local i;
    for i = 1, table.getn(PlayerManager.listeners) do
        if (type(PlayerManager.listeners[i].MoraleChanged) == "function") then
            PlayerManager.listeners[i]:MoraleChanged(PlayerManager.player);
        end
    end
end

function PlayerManager.FireMaxPower()
    local i;
    for i = 1, table.getn(PlayerManager.listeners) do
        if (type(PlayerManager.listeners[i].MaxPowerChanged) == "function") then
            PlayerManager.listeners[i]:MaxPowerChanged(PlayerManager.player);
        end
    end
end

function PlayerManager.FirePower()
    local i;
    for i = 1, table.getn(PlayerManager.listeners) do
        if (type(PlayerManager.listeners[i].PowerChanged) == "function") then
            PlayerManager.listeners[i]:PowerChanged(PlayerManager.player);
        end
    end
end
