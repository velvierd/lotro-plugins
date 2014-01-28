import "Turbine";
import "Turbine.UI";
import "PTweety.BuffMonitor";


-- load the plugin settings
Settings.Load();

-- plugin windows
effectWindows = {};
options = nil;

-- reset windows
function ResetWindows()
	local i;

	-- destroy the existing effect windows
	for i = 1, table.getn(effectWindows) do
		effectWindows[i]:Destroy();
		effectWindows[i] = nil;
	end
	effectWindows = nil;
	
	EffectManager:SetEnabled( false );
	PlayerManager:SetEnabled( false );

	-- create new effect windows	
	effectWindows = {};
	for i = 1, table.getn(Settings.instance.windows) do
		if (Settings.instance.windows[i].visible) then
			table.insert(effectWindows, EffectWindow( Settings.instance.windows[i], i ));
		end
	end

	PlayerManager:SetEnabled( true );
	EffectManager:SetEnabled( true );
end

-- setup command line interface
BuffMonitorCommand = Turbine.ShellCommand();
function BuffMonitorCommand:Execute( command, args )
	if (args == "options" or args == "setup") then
		Turbine.PluginManager.ShowOptions(Plugins.BuffMonitor);
	else
		Turbine.Shell.WriteLine(self:GetShortHelp());
	end
end
function BuffMonitorCommand:GetHelp()
	return L'help';
end
function BuffMonitorCommand:GetShortHelp()
	return L'shorthelp';
end
Turbine.Shell.AddCommand( "bm;buffmonitor", BuffMonitorCommand );

-- plugin unload event
plugin.Unload = function()
	Turbine.Shell.RemoveCommand(BuffMonitorCommand);
	local i;
	for i = 1, table.getn(effectWindows) do
		effectWindows[i]:Destroy();
		effectWindows[i] = nil;
	end
	Settings.Save();
	options:Destroy();
end

-- options panel
options = Options();

plugin.GetOptionsPanel = function( self )
	return options:GetOptionsPanel();
end

function ResetOptions()
	if (options ~= nil) then
		options:SetOptions();
	end
end

-- show user interface
ResetWindows();

Turbine.Shell.WriteLine( ( "%s v%s by %s" ):format( plugin:GetName(), plugin:GetVersion(), plugin:GetAuthor() ) );