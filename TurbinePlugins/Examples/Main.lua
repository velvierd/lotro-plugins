
import "Turbine";
import "TurbinePlugins.Examples";

-- Create a command that can be used to execute an example.
RunExampleCommand = class( Turbine.ShellCommand );

function RunExampleCommand:Execute( command, arguments )
	-- No arguments, display help.
	if ( ( arguments == nil ) or ( string.len( arguments ) == 0 ) ) then
		Turbine.Shell.WriteLine( self:GetHelp() );
		return;
	end

	-- Parse the arguments into a list.
	local argumentList = { };
	local index = 1;
	
	for word in arguments:gmatch( "%w+" ) do
		argumentList[index] = word;
		index = index + 1;
	end

	-- Extract the operation and example name.
	local operation = string.lower( argumentList[1] );
	local exampleName = argumentList[2];

	-- Should we list the examples available?
	if ( operation == "list" ) then
		self:ShowExamplesList();
		return;
	end

	-- Was an example specified.
	if ( exampleName == nil ) then
		Turbine.Shell.WriteLine( "No example specified. Use \"/lua_examples list\" to get a list of available examples." );
		return;
	end

	exampleName = string.lower( tostring( exampleName ) );

	if ( examples[exampleName] == nil ) then
		Turbine.Shell.WriteLine( "Unknown example: " .. exampleName );
		return;
	end

	if ( operation == "start" ) then
		examples[exampleName]:Start();
	elseif ( operation == "stop" ) then
		examples[exampleName]:Stop();
	else
		Turbine.Shell.WriteLine( "Invalid operation: " .. operation );
	end
end

function RunExampleCommand:GetHelp()
	local helpText = "/lua_example [start|stop|list] [example name]\n\n";
	helpText = helpText .. "Executes an example script that demonstrates the functionality of the API.";
	helpText = helpText .. "To get a list of all the available test, specify \"list\" for example name.";
	
	return helpText;
end

function RunExampleCommand:GetShortHelp()
	return "Execute an example lua script.";
end

function RunExampleCommand:ShowExamplesList()
	Turbine.Shell.WriteLine( "Examples:" );

	for key, value in pairs( examples ) do
		Turbine.Shell.WriteLine( "  " .. value:GetName() );
	end
end

-- Create an instance of the command and register it with the shell.
runExampleCommand = RunExampleCommand();
Turbine.Shell.AddCommand( "lua_example", runExampleCommand );

examplesRunner = ExamplesRunner();
examplesRunner:SetVisible( true );
