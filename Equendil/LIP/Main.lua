import "Equendil.Utils";

-- create localization
L = Equendil.Utils.MakeLocale();

Equendil.Utils.ImportLocale( "Equendil.LIP" );

-- create the application
import "Equendil.LIP.App";

lip = Equendil.LIP.App();

-- add a command to bring up the window
command = Turbine.ShellCommand();

function command:Execute( command, arguments )
	if arguments == L["show"] then
		lip:SetVisible( true );
		lip:Activate();
	elseif arguments == L["hide"] then
		lip:Close();
	elseif arguments == "" then
		-- toggle the application window by default
		if lip:IsVisible() then
			lip:SetVisible( false );
		else
			lip:SetVisible( true );
			lip:Activate();
		end
	end
end

function command:GetHelp()
	return L["usage: /lip [show|hide|toggle]: show/hide/toggles the Legendary Item Planner interface"];
end

function command:GetShortHelp()
	return L["/lip [show|hide|toggle]: show/hide/toggles the Legendary Item Planner interface"];
end


Turbine.Shell.AddCommand( "lip", command );
