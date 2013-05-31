

function RegisterCommands()

	local lang = SETTINGS.LANGUAGE;
	local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

	-- COMMAND TO DISPLAY THE ROLLS WINDOW.
	cmdRoll = Turbine.ShellCommand();

	function cmdRoll:Execute( command, arguments )

		if Windows.wRollsParent:IsVisible() == false then
			Windows.wRollsParent:SetVisible(true);
			Windows.wMenuRolls:SetBackground(tempDir .. "RollsEnabled_Up.jpg");
			SETTINGS.ROLLS.VISIBLE = true;
		else
			Windows.wRollsParent:SetVisible(false);
			Windows.wMenuRolls:SetBackground(tempDir .. "Rolls_Up.jpg");
			SETTINGS.ROLLS.VISIBLE = false;
		end
	end

	function cmdRoll:GetHelp()
		return "Raid Assistant: Shows/hides the roll window.";
	end

	function cmdRoll:GetShortHelp()
		return "Raid Assistant: Rolls.";
	end

	Turbine.Shell.AddCommand( "RARolls;RARoll", cmdRoll);


	-- COMMAND TO DISPLAY THE LOOT WINDOW.
	cmdLOOT = Turbine.ShellCommand();

	function cmdLOOT:Execute( command, arguments )

		if Windows.wLootHisParent:IsVisible() == false then
			Windows.wLootHisParent:SetVisible(true);
			Windows.wMenuLoot:SetBackground(tempDir .. "LootEnabled_Up.jpg");
			SETTINGS.LOOT.VISIBLE = true;
		else
			Windows.wLootHisParent:SetVisible(false);
			Windows.wMenuLoot:SetBackground(tempDir .. "Loot_Up.jpg");
			SETTINGS.LOOT.VISIBLE = false;
		end
	end

	function cmdLOOT:GetHelp()
		return "Raid Assistant: Shows/hides the loot history window.";
	end

	function cmdLOOT:GetShortHelp()
		return "Raid Assistant: Loot.";
	end

	Turbine.Shell.AddCommand( "RALoot", cmdLOOT);


	-- COMMAND TO DISPLAY THE BLACKLIST WINDOW.
	cmdBList = Turbine.ShellCommand();

	function cmdBList:Execute( command, arguments )

		if Windows.wBListParent:IsVisible() == false then
			Windows.wBListParent:SetVisible(true);
			Windows.wMenuBList:SetBackground(tempDir .. "BListEnabled_Up.jpg");
			SETTINGS.BLACKLIST.VISIBLE = true;
		else
			Windows.wBListParent:SetVisible(false);
			Windows.wMenuBList:SetBackground(tempDir .. "BList_Up.jpg");
			SETTINGS.BLACKLIST.VISIBLE = false;
		end
	end

	function cmdBList:GetHelp()
		return "Raid Assistant: Shows/hides the blacklist window.";
	end

	function cmdBList:GetShortHelp()
		return "Raid Assistant: Blacklist.";
	end

	Turbine.Shell.AddCommand( "RABList", cmdBList);


	-- COMMAND TO DISPLAY THE LOG WINDOW.
	cmdLOG = Turbine.ShellCommand();

	function cmdLOG:Execute( command, arguments )

		if Windows.wLogParent:IsVisible() == false then
			Windows.wLogParent:SetVisible(true);
			Windows.wMenuLog:SetBackground(tempDir .. "LogEnabled_Up.jpg");
			SETTINGS.LOG.VISIBLE = true;
		else
			Windows.wLogParent:SetVisible(false);
			Windows.wMenuLog:SetBackground(tempDir .. "Log_Up.jpg");
			SETTINGS.LOG.VISIBLE = false;
		end
	end

	function cmdLOG:GetHelp()
		return "Raid Assistant: Shows/hides the raid log window.";
	end

	function cmdLOG:GetShortHelp()
		return "Raid Assistant: Log.";
	end

	Turbine.Shell.AddCommand( "RALog", cmdLOG);


	-- COMMAND TO DISPLAY THE SHOUTS WINDOW.
	cmdSHOUT = Turbine.ShellCommand();

	function cmdSHOUT:Execute( command, arguments )

		if Windows.wShoutParent:IsVisible() == false then
			Windows.wShoutParent:SetVisible(true);
			Windows.wMenuShouts:SetBackground(tempDir .. "ShoutsEnabled_Up.jpg");
			SETTINGS.SHOUTS.VISIBLE = true;
		else
			Windows.wShoutParent:SetVisible(false);
			Windows.wMenuShouts:SetBackground(tempDir .. "Shouts_Up.jpg");
			SETTINGS.SHOUTS.VISIBLE = false;
		end
	end

	function cmdSHOUT:GetHelp()
		return "Raid Assistant: Shows/hides the main shouts window.";
	end

	function cmdSHOUT:GetShortHelp()
		return "Raid Assistant: Shouts.";
	end

	Turbine.Shell.AddCommand( "RAShout", cmdSHOUT);


	-- COMMAND TO DISPLAY THE MENU ICON.
	cmdMENU = Turbine.ShellCommand();

	function cmdMENU:Execute( command, arguments )

		if Windows.wIcon:IsVisible() == false then
			Windows.wIcon:SetVisible(true);
			SETTINGS.ICONVIS = true;
		else
			Windows.wIcon:SetVisible(false);
			SETTINGS.ICONVIS = false;
		end
	end

	function cmdMENU:GetHelp()
		return "Raid Assistant: Shows/hides the menu icon.";
	end

	function cmdMENU:GetShortHelp()
		return "Raid Assistant: Menu.";
	end

	Turbine.Shell.AddCommand( "RAMenu", cmdMENU);


	-- COMMAND TO HIDE ALL THE WINDOWS ICON.
	cmdHIDEALL = Turbine.ShellCommand();

	function cmdHIDEALL:Execute( command, arguments )

		Windows.wRollsParent:SetVisible(false);
		Windows.wMenuRolls:SetBackground(tempDir .. "Rolls_Up.jpg");
		SETTINGS.ROLLS.VISIBLE = false;

		Windows.wLootHisParent:SetVisible(false);
		Windows.wMenuLoot:SetBackground(tempDir .. "Loot_Up.jpg");
		SETTINGS.LOOT.VISIBLE = false;

		Windows.wBListParent:SetVisible(false);
		Windows.wMenuBList:SetBackground(tempDir .. "BList_Up.jpg");
		SETTINGS.BLACKLIST.VISIBLE = false;

		Windows.wLogParent:SetVisible(false);
		Windows.wMenuLog:SetBackground(tempDir .. "Log_Up.jpg");
		SETTINGS.LOG.VISIBLE = false;

	end

	function cmdHIDEALL:GetHelp()
		return "Raid Assistant: Hides all open windows.";
	end

	function cmdHIDEALL:GetShortHelp()
		return "Raid Assistant: Hides open windows.";
	end

	Turbine.Shell.AddCommand( "RAHide;RAHideAll", cmdHIDEALL);


	-- COMMAND TO RESET THE ROLLS
	cmdRESROLLS = Turbine.ShellCommand();

	function cmdRESROLLS:Execute( command, arguments )

		Windows.rollsReset();

	end

	function cmdRESROLLS:GetHelp()
		return "Raid Assistant: Resets the rolls list.";
	end

	function cmdRESROLLS:GetShortHelp()
		return "Raid Assistant: Resets the rolls list.";
	end

	Turbine.Shell.AddCommand( "RAReset", cmdRESROLLS);

end





