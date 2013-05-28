import "Turbine.UI";
import "Turbine.UI.Lotro";
import "PengorosPlugins.Utils";
import "PengorosPlugins.BuffBars";

-- load the plugin settings
Settings.Load();

-- plugin windows
local effectWindows = {};
local effectSliders = {};
local quickslotBars = {};
local effectLogger = nil;
local options = nil;

-- reset windows
function ResetState()
    local i;
    -- destroy the existing effect windows
    for i = 1, table.getn(effectWindows) do
        effectWindows[i]:Destroy();
        effectWindows[i] = nil;
    end
    effectWindows = nil;
    
    -- destroy the existing effect sliders
    for i = 1, table.getn(effectSliders) do
        effectSliders[i]:Destroy();
        effectSliders[i] = nil;
    end
    effectSliders = nil;

    -- destroy existing quick slots
    for i = 1, table.getn(quickslotBars) do
        quickslotBars[i]:Destroy();
        quickslotBars[i] = nil;
    end
    quickslotBars = nil;
    
    -- destroy the existing logger
    if (effectLogger ~= nil) then
        effectLogger:Destroy();
        effectLogger = nil;
    end

    -- create new effect windows    
    effectWindows = {};
    local windows = Settings.GetWindows();
    for i = 1, #windows do
        if (windows[i].enabled) then
            table.insert(effectWindows, EffectWindow(windows[i]));
        end
    end

    -- create new effect sliders    
    effectSliders = {};
    local sliders = Settings.GetSliders();
    for i = 1, #sliders do
        if (sliders[i].enabled) then
            table.insert(effectSliders, SliderWindow(sliders[i]));
        end
    end

    -- create new quickslot bars    
    quickslotBars = {};
    local qs = Settings.GetQuickslots();
    for i = 1, #qs do
        if (qs[i].enabled) then
            table.insert(quickslotBars, QuickslotBar(qs[i]));
        end
    end

    -- effect logger
    local log = Settings.GetLog();
    if (log.enabled) then
        effectLogger = Log(log);
    end
end

-- logging
local function EnableLogging(enable)
    local log = Settings.GetLog();
    if (log.enabled ~= enable) then
        log.enabled = enable;
        if (enable) then
            Turbine.Shell.WriteLine(L["Effect Logging Enabled"]);
            effectLogger = Log(log);
        else
            Turbine.Shell.WriteLine(L["Effect Logging Disabled"]);
            effectLogger:Destroy();
            effectLogger = nil;
        end
    end
end

-- commands
buffBarsCommand = Turbine.ShellCommand();
Turbine.Shell.AddCommand("buffbars", buffBarsCommand);
function buffBarsCommand:GetShortHelp()
    return L["usage: /buffbars options | log <enable|disable>"];
end
function buffBarsCommand:GetHelp()
    return self:GetShortHelp();
end
function buffBarsCommand:Execute(cmd, args)
    if (args == L["options"] or args == L["setup"]) then
        Turbine.PluginManager.ShowOptions(Plugins.BuffBars);
    elseif (args == L["log enable"]) then
        EnableLogging(true);
    elseif (args == L["log disable"]) then
        EnableLogging(false);
    else
        Turbine.Shell.WriteLine(self:GetShortHelp());
    end
end

-- plugin unload event
plugin.Unload = function()
    local i;
    for i = 1, table.getn(effectWindows) do
        effectWindows[i]:Destroy();
        effectWindows[i] = nil;
    end
    for i = 1, table.getn(effectSliders) do
        effectSliders[i]:Destroy();
        effectSliders[i] = nil;
    end
    for i = 1, table.getn(quickslotBars) do
        quickslotBars[i]:Destroy();
        quickslotBars[i] = nil;
    end
    if (effectLogger ~= nil) then
        effectLogger:Destroy();
        effectLogger = nil;
    end
    if (options ~= nil) then
        options:Cleanup(); -- this will prevent a client crash in certain situations
    end
    Settings.Save();
end

-- options panel
plugin.GetOptionsPanel = function(self)
	if (options == nil) then
	    if (not pcall(function() options = OptionsPanel(); end)) then
	    	-- the options panel didn't load due to a settings corruption, reset and try again
            Turbine.Shell.WriteLine(L["BuffBars settings were corrupted, reseting them."]);
	    	Settings.Reset();
	    	options = OptionsPanel();
	    end
	else
		RevertOptions();
	end
	return options;
end

-- TODO this is kinda hacky because it will overwrite any changes in the current panel but the plugin manager doesn't leave me any other options...
function RevertOptions()
	if (options ~= nil) then
		options:Destroy();
		options:Revert();
	end
end

-- set the initial state
ResetState();

-- mark it as loaded
_G.buffBarsLoaded = true;

Turbine.Shell.WriteLine("BuffBars("..PengorosPlugins.Utils.GetLocale()..") v2.1.0 by Pengoros");
