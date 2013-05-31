import "Equendil.Utils";
import "Equendil.QuickBars.Mng";

-- create the bar manager and setup window
mng = Equendil.QuickBars.Mng();

-- add a command to bring up the setup window
command = Turbine.ShellCommand();

function command:Execute( command, arguments )
	if arguments == "show" then
		mng:ShowSetup( true );
	elseif arguments == "hide" then
		mng:ShowSetup( false );
	elseif arguments == "toggle" or arguments == "setup" or arguments == "" then
		mng:ToggleSetup();
	elseif arguments == "add" then
		mng:NewBar();
	end
end

function command:GetHelp()
	return "baruk usage:\n/baruk show : displays the setup window\n/baruk hide : hides the setup window\n/baruk or /baruk toggle : toggles the setup window\n/baruk add : add a new custom bar";
end

function command:GetShortHelp()
	return "baruk [show|hide|toggle|add] Show/hide the setup window or create a new bar (add)";
end

Turbine.Shell.AddCommand( "baruk", command );

-- and load existing configuration if any
mng:Load();

--[[
local window = Turbine.UI.Lotro.Window();
window.dummy = Turbine.UI.Control();
window.dummy:SetParent( window );
window.dummy.foo = function() return window end
window:SetVisible( true );
--]]
