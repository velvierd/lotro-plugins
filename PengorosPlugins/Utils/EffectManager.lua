import "Turbine.Gameplay";
import "PengorosPlugins.Utils";

EffectManager = {};

-- listeners
EffectManager.listeners = {};

-- effect hooks
function EffectManager.HookEffects(effects, player)
	PengorosPlugins.Utils.AddListener(effects, "EffectAdded", function(sender, args)
	    EffectManager.AddEffect(player:GetEffects():Get(args.Index), player);
	end);
	PengorosPlugins.Utils.AddListener(effects, "EffectRemoved", function(sender, args)
	    EffectManager.RemoveEffect(args.Effect, player);
	end);
	PengorosPlugins.Utils.AddListener(effects, "EffectsCleared", function(sender, args)
	    EffectManager.ClearEffects(player);
	end);
end

EffectManager.player = Turbine.Gameplay.LocalPlayer.GetInstance();
EffectManager.HookEffects(EffectManager.player:GetEffects(), EffectManager.player);

--[[
party = EffectManager.player:GetParty();
if (party ~= nil) then
	for memberIndex=1,party:GetMemberCount() do
		member = party:GetMember(memberIndex);
		if (member ~= EffectManager.player) then
	    	EffectManager.HookEffects(member:GetEffects(), member);
		end
	end
end
--]]

function EffectManager.AddListener(listener)
    -- make sure it isn't in the list already
    EffectManager.RemoveListener(listener);
    table.insert(EffectManager.listeners, listener);
end

function EffectManager.RemoveListener(listener)
    local i;
    for i = 1, table.getn(EffectManager.listeners) do
        if (EffectManager.listeners[i] == listener) then
            table.remove(EffectManager.listeners, i);
            break;
        end
    end
end

function EffectManager.GetEffects()
    return EffectManager.player:GetEffects();
end

function EffectManager.AddEffect(effect, player)
    local i;
    for i = 1, table.getn(EffectManager.listeners) do
        if (type(EffectManager.listeners[i].EffectAdded) == "function") then
            EffectManager.listeners[i]:EffectAdded(effect, player);
        end
    end
end

function EffectManager.RemoveEffect(effect, player)
    local i;
    for i = 1, table.getn(EffectManager.listeners) do
        if (type(EffectManager.listeners[i].EffectRemoved) == "function") then
            EffectManager.listeners[i]:EffectRemoved(effect, player);
        end
    end
end

function EffectManager.ClearEffects(player)
    local i;
    for i = 1, table.getn(EffectManager.listeners) do
        if (type(EffectManager.listeners[i].EffectsCleared) == "function") then
            EffectManager.listeners[i]:EffectsCleared(player);
        end
    end
end
