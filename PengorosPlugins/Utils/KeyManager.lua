import "Turbine.Gameplay";

KeyManager = {};

-- listeners
KeyManager.listeners = {};

-- state
KeyManager.locked = true;
KeyManager.hidden = false;

-- hack control to get update/key events, remove when we can get updates without being a control
KeyManager.update = Turbine.UI.Control();
KeyManager.update:SetVisible(false);
KeyManager.update:SetWantsKeyEvents(true);
KeyManager.update.KeyDown = function(sender, args)
    if (args.Action == 0x1000007B) then
        -- unlock the control for movement
        KeyManager.FireUnlock();
    elseif (args.Action == 0x100000B3) then
        -- hide ui elements
        KeyManager.FireHidden();
    elseif (args.Action == Turbine.UI.Lotro.Action.Escape) then
        KeyManager.FireEscape();
    end
end

function KeyManager.RegisterUnloadEvent(pluginName, callback)
    KeyManager.update:SetWantsUpdates(true);
    KeyManager.update.Update = function(sender, args)
        if (Plugins[pluginName] ~= nil) then
            Plugins[pluginName].Unload = callback;
            KeyManager.update:SetWantsUpdates(false);
        end
    end
end

function KeyManager.IsLocked()
    return KeyManager.locked;
end

function KeyManager.IsHidden()
    return KeyManager.hidden;
end

function KeyManager.AddListener(listener)
    -- make sure it isn't in the list already
    KeyManager.RemoveListener(listener);
    table.insert(KeyManager.listeners, listener);
end

function KeyManager.RemoveListener(listener)
    for i = 1, table.getn(KeyManager.listeners) do
        if (KeyManager.listeners[i] == listener) then
            table.remove(KeyManager.listeners, i);
            break;
        end
    end
end

function KeyManager.FireUnlock()
    KeyManager.locked = not KeyManager.locked;
    for i = 1, table.getn(KeyManager.listeners) do
        if (type(KeyManager.listeners[i].UiLocked) == "function") then
            KeyManager.listeners[i]:UiLocked(KeyManager.locked);
        end
    end
end

function KeyManager.FireHidden()
    KeyManager.hidden = not KeyManager.hidden;
    for i = 1, table.getn(KeyManager.listeners) do
        if (type(KeyManager.listeners[i].UiHidden) == "function") then
            KeyManager.listeners[i]:UiHidden(KeyManager.hidden);
        end
    end
end

function KeyManager.FireEscape()
    for i = 1, table.getn(KeyManager.listeners) do
        if (type(KeyManager.listeners[i].EscapePressed) == "function") then
            KeyManager.listeners[i]:EscapePressed();
        end
    end
end
