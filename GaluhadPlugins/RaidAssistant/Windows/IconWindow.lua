
function DrawIconWindow()

	wIcon = Turbine.UI.Window();
	wIcon:SetSize(32,32);
	wIcon:SetPosition(SETTINGS.ICONX,SETTINGS.ICONY);
	wIcon:SetBackground(RESOURCEDIR .. "MainIcon.tga");
	wIcon:SetBlendMode(0);
	wIcon:SetVisible(SETTINGS.ICONVIS);

	Includes.Onscreen(wIcon);

	if SETTINGS.ICONVIS == false then GAMessage("Menu is currently disabled, /ramenu to show") end;

	wIcon.MouseEnter = function (sender, args)

		wIcon:SetBackground(RESOURCEDIR .. "MainIcon_Over.tga");

	end

	wIcon.MouseLeave = function (sender, args)

		wIcon:SetBackground(RESOURCEDIR .. "MainIcon.tga");

	end

	wIcon.MouseDown = function (sender, args)
		blDRAGGING = true;
		relX = args.X;
		relY = args.Y;
	end

	wIcon.MouseUp = function (sender, args)
		blDRAGGING = false;
	end

	wIcon.MouseMove = function (sender, args)
		if blDRAGGING == true then
			local scX = Turbine.UI.Display.GetMouseX();
			local scY = Turbine.UI.Display.GetMouseY();
			SETTINGS.ICONX = scX - relX;
			SETTINGS.ICONY = scY - relY;

			if SETTINGS.ICONX < 0 then SETTINGS.ICONX = 0 end
			if SETTINGS.ICONX > (SCREENWIDTH-32) then SETTINGS.ICONX = (SCREENWIDTH-32) end
			if SETTINGS.ICONY < 0 then SETTINGS.ICONY = 0 end
			if SETTINGS.ICONY > (SCREENHEIGHT-32) then SETTINGS.ICONY = (SCREENHEIGHT-32) end

			wIcon:SetPosition(SETTINGS.ICONX,SETTINGS.ICONY);
		end
	end

	wIcon.MouseClick = function (sender, args)
		-- Display Pop-Up menu on right-click
		if (args.Button == Turbine.UI.MouseButton.Right) then
			if (SETTINGS.ICONX + wMainPopupParent:GetWidth() + 32) >= SCREENWIDTH then
				wMainPopupParent:SetPosition(SETTINGS.ICONX-wMainPopupParent:GetWidth(),SETTINGS.ICONY-2);
			else
				wMainPopupParent:SetPosition(SETTINGS.ICONX+32,SETTINGS.ICONY-2);
			end

			if (SETTINGS.ICONY + wMainPopupParent:GetHeight()) >= SCREENHEIGHT then
				wMainPopupParent:SetTop(SETTINGS.ICONY - (wMainPopupParent:GetHeight()-32));
			else
				wMainPopupParent:SetTop(SETTINGS.ICONY-2);
			end

			wBigBackground:SetVisible(true);
		end
	end

	DrawMainPopup();

end


function DrawMainPopup()

	local lang = SETTINGS.LANGUAGE;
	local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

	local MenuElements = 6;	-- plugin default: 5
	local ElementWidth = 150;
	local ElementHeight=30;

	wBigBackground = Turbine.UI.Window();
	wBigBackground:SetSize(SCREENWIDTH,SCREENHEIGHT);
	wBigBackground:SetPosition(0,0);
	wBigBackground:SetZOrder(10000);
	wBigBackground:SetVisible(false);

	wBigBackground.MouseClick = function (sender, args)
		-- Hides the pop-up menu
		wBigBackground:SetVisible(false);

	end

	wMainPopupParent = Turbine.UI.Window();
	wMainPopupParent:SetParent(wBigBackground);
	wMainPopupParent:SetSize((ElementWidth+4),(MenuElements*32)+2);
	wMainPopupParent:SetBackColor(BLACK);
	wMainPopupParent:SetVisible(true);

	if (SETTINGS.ICONX + wMainPopupParent:GetWidth() + 32) >= SCREENWIDTH then
		wMainPopupParent:SetLeft(SETTINGS.ICONX-wMainPopupParent:GetWidth());
	else
		wMainPopupParent:SetLeft(SETTINGS.ICONX+32);
	end

	if (SETTINGS.ICONY + wMainPopupParent:GetHeight()) >= SCREENHEIGHT then
		wMainPopupParent:SetTop(SETTINGS.ICONY - (wMainPopupParent:GetHeight()-32));
	else
		wMainPopupParent:SetTop(SETTINGS.ICONY-2);
	end

	-- First menu element
	-- Rolls.

	if SETTINGS.ROLLS.VISIBLE == true then
		RollsBackImage = tempDir .. "RollsEnabled_Up.jpg";
	else
		RollsBackImage = tempDir .. "Rolls_Up.jpg";
	end

	wMenuRolls = Turbine.UI.Window()
	wMenuRolls:SetParent(wMainPopupParent);
	wMenuRolls:SetSize(ElementWidth,ElementHeight);
	wMenuRolls:SetBackground(RollsBackImage);
	wMenuRolls:SetBlendMode(0);

	wMenuRolls.MouseEnter = function (sender, args)
		if SETTINGS.ROLLS.VISIBLE == true then
			wMenuRolls:SetBackground(tempDir .. "RollsEnabled_Over.jpg");
		else
			wMenuRolls:SetBackground(tempDir .. "Rolls_Over.jpg");
		end
	end

	wMenuRolls.MouseUp = function (sender, args)
		if SETTINGS.ROLLS.VISIBLE == true then
			wMenuRolls:SetBackground(tempDir .. "Rolls_Over.jpg");
		else
			wMenuRolls:SetBackground(tempDir .. "RollsEnabled_Over.jpg");
		end
	end

	wMenuRolls.MouseLeave = function (sender, args)
		if SETTINGS.ROLLS.VISIBLE == true then
			wMenuRolls:SetBackground(tempDir .. "RollsEnabled_Up.jpg");
		else
			wMenuRolls:SetBackground(tempDir .. "Rolls_Up.jpg");
		end
	end

	wMenuRolls.MouseClick = function (sender, args)
		-- Show and enable Rolls window
		if SETTINGS.ROLLS.VISIBLE == true then
			SETTINGS.ROLLS.VISIBLE = false;
			-- Hide window here ::::
			wRollsParent:SetVisible(false);
		else
			SETTINGS.ROLLS.VISIBLE = true;
			-- Show window here ::::
			wRollsParent:SetVisible(true);
		end

		wBigBackground:SetVisible(false);
	end


	-- Second menu element
	-- LFF.

	if SETTINGS.LFF.VISIBLE == true then
		LFFBackImage = tempDir .. "LFFEnabled_Up.jpg";
	else
		LFFBackImage = tempDir .. "LFF_Up.jpg";
	end

	wMenuLFF = Turbine.UI.Window()
	wMenuLFF:SetParent(wMainPopupParent);
	wMenuLFF:SetSize(ElementWidth,ElementHeight);
	wMenuLFF:SetBackground(LFFBackImage);
	wMenuLFF:SetBlendMode(0);

	wMenuLFF.MouseEnter = function (sender, args)
		if SETTINGS.LFF.VISIBLE == true then
			wMenuLFF:SetBackground(tempDir .. "LFFEnabled_Over.jpg");
		else
			wMenuLFF:SetBackground(tempDir .. "LFF_Over.jpg");
		end
	end

	wMenuLFF.MouseUp = function (sender, args)
		if SETTINGS.LFF.VISIBLE == true then
			wMenuLFF:SetBackground(tempDir .. "LFF_Over.jpg");
		else
			wMenuLFF:SetBackground(tempDir .. "LFFEnabled_Over.jpg");
		end
	end

	wMenuLFF.MouseLeave = function (sender, args)
		if SETTINGS.LFF.VISIBLE == true then
			wMenuLFF:SetBackground(tempDir .. "LFFEnabled_Up.jpg");
		else
			wMenuLFF:SetBackground(tempDir .. "LFF_Up.jpg");
		end
	end

	wMenuLFF.MouseClick = function (sender, args)
		-- Show and enable Rolls window
		if SETTINGS.LFF.VISIBLE == true then
			SETTINGS.LFF.VISIBLE = false;
			-- Hide window here ::::
			wLFFParent:SetVisible(false);
		else
			SETTINGS.LFF.VISIBLE = true;
			-- Show window here ::::
			wLFFParent:SetVisible(true);
		end

		wBigBackground:SetVisible(false);
	end


	-- Third menu element
	-- Blacklist.

	if SETTINGS.BLACKLIST.VISIBLE == true then
		BlacklistBackImage = tempDir .. "BListEnabled_Up.jpg";
	else
		BlacklistBackImage = tempDir .. "BList_Up.jpg";
	end

	wMenuBList = Turbine.UI.Window()
	wMenuBList:SetParent(wMainPopupParent);
	wMenuBList:SetSize(ElementWidth,ElementHeight);
	wMenuBList:SetBackground(BlacklistBackImage);
	wMenuBList:SetBlendMode(0);

	wMenuBList.MouseEnter = function (sender, args)
		if SETTINGS.BLACKLIST.VISIBLE == true then
			wMenuBList:SetBackground(tempDir .. "BListEnabled_Over.jpg");
		else
			wMenuBList:SetBackground(tempDir .. "BList_Over.jpg");
		end
	end

	wMenuBList.MouseUp = function (sender, args)
		if SETTINGS.BLACKLIST.VISIBLE == true then
			wMenuBList:SetBackground(tempDir .. "BList_Over.jpg");
		else
			wMenuBList:SetBackground(tempDir .. "BListEnabled_Over.jpg");
		end
	end

	wMenuBList.MouseLeave = function (sender, args)
		if SETTINGS.BLACKLIST.VISIBLE == true then
			wMenuBList:SetBackground(tempDir .. "BListEnabled_Up.jpg");
		else
			wMenuBList:SetBackground(tempDir .. "BList_Up.jpg");
		end
	end

	wMenuBList.MouseClick = function (sender, args)
		-- Show and enable Rolls window
		if SETTINGS.BLACKLIST.VISIBLE == true then
			SETTINGS.BLACKLIST.VISIBLE = false;
			-- Hide window here ::::
			wBListParent:SetVisible(false);
		else
			SETTINGS.BLACKLIST.VISIBLE = true;
			-- Show window here ::::
			wBListParent:SetVisible(true);
		end

		wBigBackground:SetVisible(false);
	end


	-- Fourth menu element
	-- Instance Tracker.

	if SETTINGS.INSTANCES.VISIBLE == true then
		InstBackImage = tempDir .. "InstEnabled_Up.jpg";
	else
		InstBackImage = tempDir .. "Inst_Up.jpg";
	end

	wMenuInst = Turbine.UI.Window()
	wMenuInst:SetParent(wMainPopupParent);
	wMenuInst:SetSize(ElementWidth,ElementHeight);
	wMenuInst:SetBackground(InstBackImage);
	wMenuInst:SetBlendMode(0);

	wMenuInst.MouseEnter = function (sender, args)
		if SETTINGS.INSTANCES.VISIBLE == true then
			wMenuInst:SetBackground(tempDir .. "InstEnabled_Over.jpg");
		else
			wMenuInst:SetBackground(tempDir .. "Inst_Over.jpg");
		end
	end

	wMenuInst.MouseUp = function (sender, args)
		if SETTINGS.INSTANCES.VISIBLE == true then
			wMenuInst:SetBackground(tempDir .. "Inst_Over.jpg");
		else
			wMenuInst:SetBackground(tempDir .. "InstEnabled_Over.jpg");
		end
	end

	wMenuInst.MouseLeave = function (sender, args)
		if SETTINGS.INSTANCES.VISIBLE == true then
			wMenuInst:SetBackground(tempDir .. "InstEnabled_Up.jpg");
		else
			wMenuInst:SetBackground(tempDir .. "Inst_Up.jpg");
		end
	end

	wMenuInst.MouseClick = function (sender, args)
		-- Show and enable Rolls window
		if SETTINGS.INSTANCES.VISIBLE == true then
			SETTINGS.INSTANCES.VISIBLE = false;
			-- Hide window here ::::
			wInstParent:SetVisible(false);
		else
			SETTINGS.INSTANCES.VISIBLE = true;
			-- Show window here ::::
			wInstParent:SetVisible(true);
		end

		wBigBackground:SetVisible(false);
	end


	-- Fifth menu element
	-- Loot window.

	if SETTINGS.LOOT.VISIBLE == true then
		LootBackImage = tempDir .. "LootEnabled_Up.jpg";
	else
		LootBackImage = tempDir .. "Loot_Up.jpg";
	end

	wMenuLoot = Turbine.UI.Window()
	wMenuLoot:SetParent(wMainPopupParent);
	wMenuLoot:SetSize(ElementWidth,ElementHeight);
	wMenuLoot:SetBackground(LootBackImage);
	wMenuLoot:SetBlendMode(0);

	wMenuLoot.MouseEnter = function (sender, args)
		if SETTINGS.LOOT.VISIBLE == true then
			wMenuLoot:SetBackground(tempDir .. "LootEnabled_Over.jpg");
		else
			wMenuLoot:SetBackground(tempDir .. "Loot_Over.jpg");
		end
	end

	wMenuLoot.MouseUp = function (sender, args)
		if SETTINGS.LOOT.VISIBLE == true then
			wMenuLoot:SetBackground(tempDir .. "Loot_Over.jpg");
		else
			wMenuLoot:SetBackground(tempDir .. "LootEnabled_Over.jpg");
		end
	end

	wMenuLoot.MouseLeave = function (sender, args)
		if SETTINGS.LOOT.VISIBLE == true then
			wMenuLoot:SetBackground(tempDir .. "LootEnabled_Up.jpg");
		else
			wMenuLoot:SetBackground(tempDir .. "Loot_Up.jpg");
		end
	end

	wMenuLoot.MouseClick = function (sender, args)
		-- Show and enable Rolls window
		if SETTINGS.LOOT.VISIBLE == true then
			SETTINGS.LOOT.VISIBLE = false;
			-- Hide window here ::::
			wLootHisParent:SetVisible(false);
		else
			SETTINGS.LOOT.VISIBLE = true;
			-- Show window here ::::
			wLootHisParent:SetVisible(true);
		end

		wBigBackground:SetVisible(false);
	end


	-- Sixth menu element
	-- Settings window.

	if SETTINGS.SETTWIN.VISIBLE == true then
		SettBackImage = tempDir .. "SettingsEnabled_Up.jpg";
	else
		SettBackImage = tempDir .. "Settings_Up.jpg";
	end

	wMenuSett = Turbine.UI.Window()
	wMenuSett:SetParent(wMainPopupParent);
	wMenuSett:SetSize(ElementWidth,ElementHeight);
	wMenuSett:SetBackground(SettBackImage);
	wMenuSett:SetBlendMode(0);

	wMenuSett.MouseEnter = function (sender, args)
		if SETTINGS.SETTWIN.VISIBLE == true then
			wMenuSett:SetBackground(tempDir .. "SettingsEnabled_Over.jpg");
		else
			wMenuSett:SetBackground(tempDir .. "Settings_Over.jpg");
		end
	end

	wMenuSett.MouseUp = function (sender, args)
		if SETTINGS.SETTWIN.VISIBLE == true then
			wMenuSett:SetBackground(tempDir .. "Settings_Over.jpg");
		else
			wMenuSett:SetBackground(tempDir .. "SettingsEnabled_Over.jpg");
		end
	end

	wMenuSett.MouseLeave = function (sender, args)
		if SETTINGS.SETTWIN.VISIBLE == true then
			wMenuSett:SetBackground(tempDir .. "SettingsEnabled_Up.jpg");
		else
			wMenuSett:SetBackground(tempDir .. "Settings_Up.jpg");
		end
	end

	wMenuSett.MouseClick = function (sender, args)
		-- Show and enable Rolls window
		if SETTINGS.SETTWIN.VISIBLE == true then
			SETTINGS.SETTWIN.VISIBLE = false;
			-- Hide window here ::::
			wSettParent:SetVisible(false);
		else
			SETTINGS.SETTWIN.VISIBLE = true;
			-- Show window here ::::
			wSettParent:SetVisible(true);
		end

		wBigBackground:SetVisible(false);
	end


	-- Seventh menu element
	-- Log window.

	if SETTINGS.LOG.VISIBLE == true then
		SettBackImage = tempDir .. "LogEnabled_Up.jpg";
	else
		SettBackImage = tempDir .. "Log_Up.jpg";
	end

	wMenuLog = Turbine.UI.Window()
	wMenuLog:SetParent(wMainPopupParent);
	wMenuLog:SetSize(ElementWidth,ElementHeight);
	wMenuLog:SetBackground(SettBackImage);
	wMenuLog:SetBlendMode(0);

	wMenuLog.MouseEnter = function (sender, args)
		if SETTINGS.LOG.VISIBLE == true then
			wMenuLog:SetBackground(tempDir .. "LogEnabled_Over.jpg");
		else
			wMenuLog:SetBackground(tempDir .. "Log_Over.jpg");
		end
	end

	wMenuLog.MouseUp = function (sender, args)
		if SETTINGS.LOG.VISIBLE == true then
			wMenuLog:SetBackground(tempDir .. "Log_Over.jpg");
		else
			wMenuLog:SetBackground(tempDir .. "LogEnabled_Over.jpg");
		end
	end

	wMenuLog.MouseLeave = function (sender, args)
		if SETTINGS.LOG.VISIBLE == true then
			wMenuLog:SetBackground(tempDir .. "LogEnabled_Up.jpg");
		else
			wMenuLog:SetBackground(tempDir .. "Log_Up.jpg");
		end
	end

	wMenuLog.MouseClick = function (sender, args)
		-- Show and enable Rolls window
		if SETTINGS.LOG.VISIBLE == true then
			SETTINGS.LOG.VISIBLE = false;
			-- Hide window here ::::
			wLogParent:SetVisible(false);
		else
			SETTINGS.LOG.VISIBLE = true;
			-- Show window here ::::
			RefreshLogList();
			wLogParent:SetVisible(true);
		end

		wBigBackground:SetVisible(false);
	end


	-- Eighth menu element
	-- Shouts window.

	if SETTINGS.SHOUTS.VISIBLE == true then
		SettBackImage = tempDir .. "ShoutsEnabled_Up.jpg";
	else
		SettBackImage = tempDir .. "Shouts_Up.jpg";
	end

	wMenuShouts = Turbine.UI.Window()
	wMenuShouts:SetParent(wMainPopupParent);
	wMenuShouts:SetSize(ElementWidth,ElementHeight);
	wMenuShouts:SetBackground(SettBackImage);
	wMenuShouts:SetBlendMode(0);

	wMenuShouts.MouseEnter = function (sender, args)
		if SETTINGS.SHOUTS.VISIBLE == true then
			wMenuShouts:SetBackground(tempDir .. "ShoutsEnabled_Over.jpg");
		else
			wMenuShouts:SetBackground(tempDir .. "Shouts_Over.jpg");
		end
	end

	wMenuShouts.MouseUp = function (sender, args)
		if SETTINGS.SHOUTS.VISIBLE == true then
			wMenuShouts:SetBackground(tempDir .. "Shouts_Over.jpg");
		else
			wMenuShouts:SetBackground(tempDir .. "ShoutsEnabled_Over.jpg");
		end
	end

	wMenuShouts.MouseLeave = function (sender, args)
		if SETTINGS.SHOUTS.VISIBLE == true then
			wMenuShouts:SetBackground(tempDir .. "ShoutsEnabled_Up.jpg");
		else
			wMenuShouts:SetBackground(tempDir .. "Shouts_Up.jpg");
		end
	end

	wMenuShouts.MouseClick = function (sender, args)
		-- Show and enable Rolls window
		if SETTINGS.SHOUTS.VISIBLE == true then
			SETTINGS.SHOUTS.VISIBLE = false;
			-- Hide window here ::::
			wShoutParent:SetVisible(false);
		else
			SETTINGS.SHOUTS.VISIBLE = true;
			-- Show window here ::::
			RefreshLogList();
			wShoutParent:SetVisible(true);
		end

		wBigBackground:SetVisible(false);
	end


	-- List ordering

	wMenuRolls:SetPosition(2,2); 	-- 1 = 2
	wMenuLoot:SetPosition(2,34); 	-- 2 = 34
	wMenuBList:SetPosition(2,66);	-- 3 = 66
	wMenuLog:SetPosition(2,98);		-- 4 = 98
	wMenuShouts:SetPosition(2,130);	-- 5 = 130
	wMenuLFF:SetPosition(2,162);	-- 6 = 162
	wMenuInst:SetPosition(2,194);	-- 7 = 194
	wMenuSett:SetPosition(2,162);	-- 8 = 226

	wMenuRolls:SetVisible(true);
	wMenuLoot:SetVisible(true);
	wMenuBList:SetVisible(true);
	wMenuLog:SetVisible(true);
	wMenuLFF:SetVisible(false);
	wMenuInst:SetVisible(false);
	wMenuShouts:SetVisible(true);
	wMenuSett:SetVisible(true);

end
