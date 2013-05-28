
import "TurbinePlugins.TheOneBag";

theOneBag = TheOneBagWindow();
theOneBag:SetVisible( true );

Turbine.UI.Lotro.LotroUI.SetEnabled( Turbine.UI.Lotro.LotroUIElement.Backpack1, false );
Turbine.UI.Lotro.LotroUI.SetEnabled( Turbine.UI.Lotro.LotroUIElement.Backpack2, false );
Turbine.UI.Lotro.LotroUI.SetEnabled( Turbine.UI.Lotro.LotroUIElement.Backpack3, false );
Turbine.UI.Lotro.LotroUI.SetEnabled( Turbine.UI.Lotro.LotroUIElement.Backpack4, false );
Turbine.UI.Lotro.LotroUI.SetEnabled( Turbine.UI.Lotro.LotroUIElement.Backpack5, false );


theOneBagCommand = Turbine.ShellCommand();

function theOneBagCommand:Execute( command, arguments )
	if ( arguments == "show" ) then
		theOneBag:SetVisible( true );
	elseif ( arguments == "hide" ) then
		theOneBag:SetVisible( false );
	elseif ( arguments == "toggle" ) then
		theOneBag:SetVisible( not theOneBag:IsVisible() );
	elseif ( arguments == "refresh" ) then
		theOneBag:Refresh();
	elseif ( arguments ~= nil ) then
		local opacity = tonumber( arguments )

		if ( ( opacity ~= nil ) and ( opacity > 0 ) ) then
			theOneBag:SetOpacity( opacity );
		end
	end
end

function theOneBagCommand:GetHelp()
	return "The One Bag\n\ntob show: Display the one bag\ntob hide: Hides the one bag";
end

function theOneBagCommand:GetShortHelp()
	return "Shows or hides The One Bag.";
end

Turbine.Shell.AddCommand( "tob;theonebag", theOneBagCommand );

listCommandsCommand = Turbine.ShellCommand();

function listCommandsCommand:Execute( command, arguments )
	local commands = Turbine.Shell.GetCommands();

	local allCommands = ""

	for key, value in pairs(commands) do
		allCommands = allCommands .. ", " .. value
	end
	
	Turbine.Shell.WriteLine( allCommands )
end

Turbine.Shell.AddCommand( "listcommands", listCommandsCommand );

myDanceCommand = Turbine.ShellCommand();

function myDanceCommand:Execute( command, arguments )
	Turbine.Shell.Execute( "/dance1" );
end

Turbine.Shell.AddCommand( "mydance", myDanceCommand );

doomCommand = Turbine.ShellCommand();

function doomCommand:Execute( command, arguments )
	Turbine.Shell.Execute( "/plugins unload theonebag" );
end

Turbine.Shell.AddCommand( "doom", doomCommand );
