
-- Loot history window
function DrawLootHisWindow()

	local tempWidth = 420;
	local tempHeight = 330;

	wLootHisParent = Turbine.UI.Lotro.Window();
	wLootHisParent:SetSize(tempWidth,tempHeight);
	wLootHisParent:SetPosition(SETTINGS.LOOT.X,SETTINGS.LOOT.Y);
	wLootHisParent:SetText(_LANG.LootWindowTitle[SETTINGS.LANGUAGE]);
	wLootHisParent:SetVisible(SETTINGS.LOOT.VISIBLE);

	Includes.Onscreen(wLootHisParent);

	wLootBackground = Turbine.UI.Control()
	wLootBackground:SetParent(wLootHisParent);
	wLootBackground:SetSize(422,335);
	wLootBackground:SetPosition(-1,-6);
	wLootBackground:SetBlendMode(4);
	wLootBackground:SetBackground(RESOURCEDIR.."LootHistory.tga");
	wLootBackground:SetMouseVisible(false);

	local tPlayers = {_LANG.ALL[SETTINGS.LANGUAGE]};

	-- Drop Down
	LootPlayerDropDown = Includes.DropDown.Create(tPlayers);
	LootPlayerDropDown:SetParent(wLootHisParent);
	LootPlayerDropDown:SetPosition(30,50);
	LootPlayerDropDown:ApplyWidth(140);
	LootPlayerDropDown:SetVisible(true);
	LootPlayerDropDown:SetAlignment("left");
	LootPlayerDropDown:SetMenuEnabled(true);

	LootPlayerDropDown.ItemChanged = function ()
		-- Update items drop-down to those available to the selected player
		RefreshLootItemMenu();
		RefreshLootList();

	end

	-- Drop Down
	LootItemDropDown = Includes.DropDown.Create(tPlayers);
	LootItemDropDown:SetParent(wLootHisParent);
	LootItemDropDown:SetPosition(180,50);
	LootItemDropDown:ApplyWidth(210);
	LootItemDropDown:SetVisible(true);
	LootItemDropDown:SetMenuEnabled(true);
	LootItemDropDown:SetAlignment("left");

	LootItemDropDown.ItemChanged = function ()
		-- Filter by selection
		RefreshLootList();
	end

	lblLootEntries = Turbine.UI.Label();
	lblLootEntries:SetParent(wLootHisParent);
	lblLootEntries:SetSize(100,17);
	lblLootEntries:SetPosition(290,73);
	lblLootEntries:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
	lblLootEntries:SetText("0 " .. _LANG.Entries[SETTINGS.LANGUAGE]);

	lLootListBox = Turbine.UI.ListBox();
	lLootListBox:SetParent(wLootHisParent);
	lLootListBox:SetSize(380,150);
	lLootListBox:SetPosition(20,95);
	--lLootListBox:SetBackColor(WHITE);
	lLootListBox:SetVisible(true);

	LootlistScroll = Turbine.UI.Lotro.ScrollBar();
	LootlistScroll:SetParent(lLootListBox);
	LootlistScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	LootlistScroll:SetSize(8,lLootListBox:GetHeight());
	LootlistScroll:SetPosition(lLootListBox:GetWidth()-9,0);
	LootlistScroll:SetVisible(false);
	LootlistScroll:SetZOrder(200000);
	lLootListBox:SetVerticalScrollBar(LootlistScroll);


	chkLootLogSelf = Turbine.UI.Lotro.CheckBox();
	chkLootLogSelf:SetParent(wLootHisParent);
	chkLootLogSelf:SetPosition(30,260);
	chkLootLogSelf:SetSize(150,17);
	chkLootLogSelf:SetFont(LISTFONT);
	chkLootLogSelf:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	chkLootLogSelf:SetText(" " .. _LANG.SelfLootLog[SETTINGS.LANGUAGE]);
	chkLootLogSelf:SetChecked(SETTINGS.LOOT.SELF_ENABLED);

	chkLootLogSelf.CheckedChanged = function (sender, args)
		SETTINGS.LOOT.SELF_ENABLED = chkLootLogSelf:IsChecked();
	end


	chkLootLogFellow = Turbine.UI.Lotro.CheckBox();
	chkLootLogFellow:SetParent(wLootHisParent);
	chkLootLogFellow:SetPosition(190,260);
	chkLootLogFellow:SetSize(150,17);
	chkLootLogFellow:SetFont(LISTFONT);
	chkLootLogFellow:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	chkLootLogFellow:SetText(" " .. _LANG.FellowLootLog[SETTINGS.LANGUAGE]);
	chkLootLogFellow:SetChecked(SETTINGS.LOOT.FELLOW_ENABLED);

	chkLootLogFellow.CheckedChanged = function (sender, args)
		SETTINGS.LOOT.FELLOW_ENABLED = chkLootLogFellow:IsChecked();
	end
	

	LootExportBtn = Turbine.UI.Lotro.Button();
	LootExportBtn:SetParent(wLootHisParent);
	LootExportBtn:SetText(_LANG.Export[SETTINGS.LANGUAGE]);
	LootExportBtn:SetPosition(30,288);
	LootExportBtn:SetWidth(60);

	LootResetBtn = Turbine.UI.Lotro.Button();
	LootResetBtn:SetParent(wLootHisParent);
	LootResetBtn:SetText(_LANG.Roll_Clear[SETTINGS.LANGUAGE]);
	LootResetBtn:SetPosition(100,288);

	LootIgnoreBtn = Turbine.UI.Lotro.Button();
	LootIgnoreBtn:SetParent(wLootHisParent);
	LootIgnoreBtn:SetText(_LANG.IgnoreItemButton[SETTINGS.LANGUAGE]);
	LootIgnoreBtn:SetPosition(290,288);
	LootIgnoreBtn:SetWidth(100);

	if SETTINGS.LANGUAGE == "GERMAN" or SETTINGS.LANGUAGE == "FRENCH" then
		LootExportBtn:SetPosition(25,288);
		LootExportBtn:SetWidth(100);

		LootResetBtn:SetPosition(130,288);
		LootResetBtn:SetWidth(100);

		LootIgnoreBtn:SetPosition(270,288);
		LootIgnoreBtn:SetWidth(120);

		chkLootLogSelf:SetPosition(130,288);
	end


	lLootListBox.ItemAdded = function (sender, args)

		lblLootEntries:SetText(lLootListBox:GetItemCount() .. " " .. _LANG.Entries[SETTINGS.LANGUAGE]);

	end

	lLootListBox.ItemRemoved = function (sender, args)

		lblLootEntries:SetText(lLootListBox:GetItemCount() .. " " .. _LANG.Entries[SETTINGS.LANGUAGE]);

	end


	LootExportBtn.Click = function (sender, args)
		ExportHistory();
	end


	LootResetBtn.Click = function (sender, args)

		tempMsg = Includes.MessageBox.Create(_LANG.MESSAGE14[SETTINGS.LANGUAGE],"MBYESNO");
		tempMsg.Prompt = function ()
			if tempMsg:GetResponse() == "MBYES" then ResetItemList() end;
		end
	end


	LootIgnoreBtn.Click = function (sender, args)
		IgnoreItemList();
	end


	wLootHisParent.Closing = function()
		SETTINGS.LOOT.VISIBLE = false;

		local lang = SETTINGS.LANGUAGE;
		local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

		wMenuLoot:SetBackground(tempDir .. "Loot_Up.jpg");
	end

	wLootHisParent.PositionChanged = function()

		SETTINGS.LOOT.X = wLootHisParent:GetLeft();
		SETTINGS.LOOT.Y = wLootHisParent:GetTop();

	end


	-- EXPORT WINDOW ----------------------------------------------
	wLootExport = Turbine.UI.Lotro.Window();
	wLootExport:SetSize(500,380);
	wLootExport:SetPosition((SCREENWIDTH/2)-250,(SCREENHEIGHT/3));
	wLootExport:SetText(_LANG.LootExportTitle[SETTINGS.LANGUAGE]);
	wLootExport:SetVisible(false);

	wExportBack = Turbine.UI.Control()
	wExportBack:SetParent(wLootExport);
	wExportBack:SetSize(500,380);
	wExportBack:SetBlendMode(4);
	wExportBack:SetBackground(RESOURCEDIR.."LootExport.tga");
	wExportBack:SetMouseVisible(false);

	lblExport = Turbine.UI.Label();
	lblExport:SetParent(wLootExport);
	lblExport:SetSize(450,17);
	lblExport:SetPosition(25,50);
	lblExport:SetText(_LANG.ExportHelp[SETTINGS.LANGUAGE]);

	txtExport = Turbine.UI.TextBox();
	txtExport:SetParent(wLootExport);
	txtExport:SetSize(440,240);
	txtExport:SetPosition(30,80);
	txtExport:SetMultiline(true);
	txtExport:SetSelectable(true);
	txtExport:SetFont(LISTFONT);

	exportScroll = Turbine.UI.Lotro.ScrollBar();
	exportScroll:SetParent(txtExport);
	exportScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	exportScroll:SetSize(8,txtExport:GetHeight());
	exportScroll:SetPosition(txtExport:GetWidth()-9,0);
	exportScroll:SetVisible(false);
	exportScroll:SetZOrder(200000);
	txtExport:SetVerticalScrollBar(exportScroll);

	btnSelect = Turbine.UI.Lotro.Button();
	btnSelect:SetParent(wLootExport);
	btnSelect:SetWidth(80)
	btnSelect:SetPosition(40,338);
	btnSelect:SetText(_LANG.SelectAll[SETTINGS.LANGUAGE]);

	if SETTINGS.LANGUAGE == "GERMAN" or SETTINGS.LANGUAGE == "FRENCH" then btnSelect:SetWidth(150) end;

	btnSelect.Click = function (sender, args)

		txtExport:SelectAll();
		txtExport:Focus();

	end

	chkExportRolls = Turbine.UI.Lotro.CheckBox();
	chkExportRolls:SetParent(wLootExport);
	chkExportRolls:SetPosition(250,334);
	chkExportRolls:SetSize(200,30);
	chkExportRolls:SetFontStyle(Turbine.UI.FontStyle.Outline);
	chkExportRolls:SetText(_LANG.ExpRollsOnly[SETTINGS.LANGUAGE]);
	chkExportRolls:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	chkExportRolls:SetChecked(SETTINGS.LOOT.CHKROLLS);
	chkExportRolls:SetVisible(true);

	chkExportRolls.CheckedChanged = function (sender, args)

		SETTINGS.LOOT.CHKROLLS = chkExportRolls:IsChecked();
		RefreshExportHistory(SETTINGS.LOOT.CHKROLLS)

	end


	-- Ignored Item list Window ------------------------------------------------------------------
	wLootIgnore = Turbine.UI.Lotro.Window();
	wLootIgnore:SetSize(420,350);
	wLootIgnore:SetPosition((SCREENWIDTH/2)-210,(SCREENHEIGHT/3));
	wLootIgnore:SetText(_LANG.IgnoreItemButton[SETTINGS.LANGUAGE]);
	wLootIgnore:SetVisible(false);

	wLootIgnoreBack = Turbine.UI.Control()
	wLootIgnoreBack:SetParent(wLootIgnore);
	wLootIgnoreBack:SetSize(420,350);
	wLootIgnoreBack:SetBlendMode(4);
	wLootIgnoreBack:SetBackground(RESOURCEDIR.."LootIgnore.tga");
	wLootIgnoreBack:SetMouseVisible(false);

	lblIgnored = Turbine.UI.Label();
	lblIgnored:SetParent(wLootIgnore);
	lblIgnored:SetSize(380,36);
	lblIgnored:SetPosition(20,40);
	lblIgnored:SetMultiline(true);
	lblIgnored:SetFont(BFONT);
	lblIgnored:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	lblIgnored:SetText(_LANG.IgnoredDesc[SETTINGS.LANGUAGE]);

	--lblIgnored:SetBackColor(WHITE);
	--lblIgnored:SetForeColor(BLACK);

	LootIgnoreList = Turbine.UI.ListBox();
	LootIgnoreList:SetParent(wLootIgnore);
	LootIgnoreList:SetSize(376,216);
	LootIgnoreList:SetPosition(22,86);
	--LootIgnoreList:SetBackColor(WHITE);
	LootIgnoreList:SetVisible(true);

	LootIgnoreScroll = Turbine.UI.Lotro.ScrollBar();
	LootIgnoreScroll:SetParent(LootIgnoreList);
	LootIgnoreScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	LootIgnoreScroll:SetSize(8,LootIgnoreList:GetHeight());
	LootIgnoreScroll:SetPosition(LootIgnoreList:GetWidth()-9,0);
	LootIgnoreScroll:SetVisible(false);
	LootIgnoreScroll:SetZOrder(200000);
	LootIgnoreList:SetVerticalScrollBar(LootIgnoreScroll);

	lblIgnoreEntries = Turbine.UI.Label();
	lblIgnoreEntries:SetParent(wLootIgnore);
	lblIgnoreEntries:SetSize(100,17);
	lblIgnoreEntries:SetPosition(280,313);
	lblIgnoreEntries:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
	lblIgnoreEntries:SetText("0 " .. _LANG.Items[SETTINGS.LANGUAGE]);

	btnLootIgnoreClear = Turbine.UI.Lotro.Button();
	btnLootIgnoreClear:SetParent(wLootIgnore);
	btnLootIgnoreClear:SetWidth(80)
	btnLootIgnoreClear:SetPosition(40,313);
	btnLootIgnoreClear:SetText(_LANG.Roll_Clear[SETTINGS.LANGUAGE]);
	btnLootIgnoreClear:SetEnabled(false);

	if SETTINGS.LANGUAGE == "GERMAN"  or SETTINGS.LANGUAGE == "FRENCH" then btnLootIgnoreClear:SetWidth(100) end;

	btnLootIgnoreClear.Click = function (sender, args)
		-- Confirm reset first..
		tempMsg = Includes.MessageBox.Create(_LANG.MESSAGE10[SETTINGS.LANGUAGE],"MBYESNO");
		tempMsg.Prompt = function ()
			if tempMsg:GetResponse() == "MBYES" then

				local NumItems = 1;

				for k,v in pairs (_ITEMIGNORE) do
					NumItems = NumItems + 1;
				end

				for i=1, NumItems do
					_ITEMIGNORE[i] = nil;
				end

				_ITEMIGNORE = nil;
				_ITEMIGNORE = {};
				LootIgnoreList:ClearItems();
				btnLootIgnoreClear:SetEnabled(false);
				lblIgnoreEntries:SetText("0 " .. _LANG.Items[SETTINGS.LANGUAGE]);
			end
		end
	end

	SetStartDate();

end


function SetStartDate()

	local tempDate = Turbine.Engine.GetDate();
	local tempHour = tostring(tempDate.Hour);
	local tempMinute = tostring(tempDate.Minute);
	local tempDay = tostring(tempDate.Day);
	local tempMonth = tostring(tempDate.Month);
	if string.len(tempHour) == 1 then tempHour = "0" .. tempHour end;
	if string.len(tempMinute) == 1 then tempMinute = "0" .. tempMinute end;
	if string.len(tempDay) == 1 then tempDay = "0" .. tempDay end;
	if string.len(tempMonth) == 1 then tempMonth = "0" .. tempMonth end;

	local strDate = tempHour .. ":" .. tempMinute .. " " .. tempDay .. "/" .. tempMonth .. "/" .. tempDate.Year;

	LOOTSTARTDATE = strDate;

end


function RefreshLootPlayerMenu()

	-- Get and hold the current value for the menu. If it still exists in the menu after the change
	-- then use as default.
	local tempOldValue = LootPlayerDropDown:GetText();
	local oldValueExists = false;
	local blEXISTS = false;

	local _LOOTPLAYERS = {_LANG.ALL[SETTINGS.LANGUAGE]};

	for k,v in pairs (_LOOT) do

		blEXISTS = false;

		local tempPlayer = _LOOT[k].PLAYER;

		if tempPlayer == tempOldValue then oldValueExists = true end;

		-- Check the player name to see if it exists in the table already, if not add it.
		for a,b in pairs(_LOOTPLAYERS) do
			if b == tempPlayer then
				blEXISTS = true;
				break;
			end
		end

		if blEXISTS == false then table.insert(_LOOTPLAYERS,tempPlayer) end;

	end

	-- Get the dropdown list and apply the new menu items
	local tempList = LootPlayerDropDown:GetItemList();
	tempList:Clear();

	for k,v in pairs(_LOOTPLAYERS) do
		local myTempItem = Turbine.UI.MenuItem(v);
		tempList:Add(myTempItem);
	end

	if oldValueExists == true then
		LootPlayerDropDown:SetLabel(tempOldValue);
	else
		LootPlayerDropDown:SetLabel(_LANG.ALL[SETTINGS.LANGUAGE]);
	end
end


function RefreshLootItemMenu()

	-- Get and hold the current value for the menu. If it still exists in the menu after the change
	-- then use as default.
	local tempOldValue = LootItemDropDown:GetText();
	local oldValueExists = false;
	local blEXISTS = false;

	local _TEMPITEMS = {_LANG.ALL[SETTINGS.LANGUAGE]};
	local tempPlayer = LootPlayerDropDown:GetText();

	for k,v in pairs (_LOOT) do

		blEXISTS = false;

		-- Only add entries that match the type dropdown
		if (tempPlayer == _LOOT[k].PLAYER) or (tempPlayer == _LANG.ALL[SETTINGS.LANGUAGE]) then

			local tempItem = _LOOT[k].ITEM;
			if tempItem == tempOldValue then oldValueExists = true end;

			-- Check the item name to see if it exists in the table already, if not add it.
			for a,b in pairs(_TEMPITEMS) do
				if b == tempItem then
					blEXISTS = true;
					break;
				end
			end

			if blEXISTS == false then table.insert(_TEMPITEMS,tempItem) end;
		end
	end

	-- Get the dropdown list and apply the new menu items
	local tempList = LootItemDropDown:GetItemList();
	tempList:Clear();

	for k,v in pairs(_TEMPITEMS) do
		local myTempItem = Turbine.UI.MenuItem(v);
		tempList:Add(myTempItem);
	end

	if oldValueExists == true then
		LootItemDropDown:SetLabel(tempOldValue);
	else
		LootItemDropDown:SetLabel(_LANG.ALL[SETTINGS.LANGUAGE]);
	end
end

--[[
TABLE STRUCTURE

_LOOT[X] =
	{
	["ID"] = 1;
	["TIME"] = "00:00";
	["PLAYER"] = "Galuhad";
	["ITEM"] = "[ItemName]";
	["ROLLED"] = 100;
	["ROLL"] = 27;
	};

]]--

function ItemLog(MESSAGE)

	-- DToX Start
	if (string.find(MESSAGE, "%[") == nil) then	-- Ignores RU level up string and Sarumans' rings
		do return end;
	end;
	-- DToX End
	
	local IgnoreItem = false;

	local Space = string.find(MESSAGE, " ");
	local OpenBrack = string.find(MESSAGE, "%[");
	local CloseBrack = string.find(MESSAGE, "%]");

	local acqName = string.sub(MESSAGE,1,Space-1);
	local acqItem = string.sub(MESSAGE,OpenBrack,CloseBrack);

	if acqName == _LANG.You[SETTINGS.LANGUAGE] then acqName = MYNAME end;
	-- DToX Start
	if acqName == "Получено:" then acqName = MYNAME end;
	-- DToX End

	RaidLog(2,acqItem,acqName); -- TYPES: 1 = Roll; 2 = Item; 3 = Group

	-- Check if item is on ignore list, if it isn't then proceed to add.
	for k,v in pairs(_ITEMIGNORE) do
		if v == acqItem then IgnoreItem = true end;
	end

	-- If not ignored, add to the table.
	if IgnoreItem == false then

		local tempLootID = LOOTID;

		if acqName == "Erhalten:" then acqName = MYNAME end;

		local tempDate = Turbine.Engine.GetDate();
		local tempHour = tostring(tempDate.Hour);
		local tempMinute = tostring(tempDate.Minute);

		if string.len(tempHour) == 1 then tempHour = "0" .. tempHour end;
		if string.len(tempMinute) == 1 then tempMinute = "0" .. tempMinute end;

		local tempTime = tempHour .. ":" .. tempMinute;

		-- COPY INTO A TABLE THAT WE CAN FILTER THROUGH LATER.
		table.insert(_LOOT,1,{["ID"] = tempLootID;["TIME"] = tempTime; ["PLAYER"] = acqName; ["ITEM"] = acqItem; ["ROLLED"] = ""; ["ROLL"] = "";});

		LOOTID = LOOTID + 1;

		RefreshLootPlayerMenu();
		RefreshLootItemMenu();
		--RefreshLootList(); -- too laggy
		
		local tempRow = BuildLootListRow(1);
		lLootListBox:InsertItem(1,tempRow);

	end
end


function RefreshLootList()

	-- This function is called when the user selects either a player or item from the filter drop-downs.
	-- It searches the loot history table for items matching the selected player and item names.
	lLootListBox:ClearItems();

	local selPlayer = LootPlayerDropDown:GetText();
	local selItem = LootItemDropDown:GetText();

	for k,v in pairs(_LOOT) do
		if (_LOOT[k].PLAYER == selPlayer or selPlayer == _LANG.ALL[SETTINGS.LANGUAGE]) and (_LOOT[k].ITEM == selItem or selItem ==  _LANG.ALL[SETTINGS.LANGUAGE]) then
			local tempRow = BuildLootListRow(k);
			lLootListBox:AddItem(tempRow);
		end
	end
end


function BuildLootListRow(k)

	local LineHeight = 17;

	local tempLootID = _LOOT[k].ID;

	local acqItem = _LOOT[k].ITEM;
	local acqName = _LOOT[k].PLAYER;

	local tempHolder = Turbine.UI.Control();
	tempHolder:SetSize(370,LineHeight);
	tempHolder:SetVisible(true);

	local tempTimeLbl = Turbine.UI.Label();
	tempTimeLbl:SetParent(tempHolder);
	tempTimeLbl:SetSize(43,LineHeight);
	tempTimeLbl:SetPosition(0,0);
	tempTimeLbl:SetFont(LISTFONT);
	tempTimeLbl:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	tempTimeLbl:SetText("[" .. _LOOT[k].TIME .. "]");

	local tempNameLbl = Turbine.UI.Label();
	tempNameLbl:SetParent(tempHolder);
	tempNameLbl:SetSize(75,LineHeight);
	tempNameLbl:SetPosition(47,0);
	tempNameLbl:SetFont(LISTFONT);
	tempNameLbl:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	tempNameLbl:SetText(_LOOT[k].PLAYER);

	local tempItemLbl = Turbine.UI.Label();
	tempItemLbl:SetParent(tempHolder);
	tempItemLbl:SetSize(252,LineHeight);
	tempItemLbl:SetPosition(127,0);
	tempItemLbl:SetMultiline(false);
	tempItemLbl:SetFont(LISTFONT);
	tempItemLbl:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	tempItemLbl:SetText(_LOOT[k].ITEM);
	tempItemLbl:SetMouseVisible(true);

	if _LOOT[k].ROLLED ~= "" then tempItemLbl:SetForeColor(ORANGE) end;

	tempItemLbl.MouseClick = function (sender, args)

		if args.Button == Turbine.UI.MouseButton.Right then

			local contextMenu = Turbine.UI.ContextMenu();

			-- Populate the menu with some items.
			local menuItems = contextMenu:GetItems();
			menuItems:Add(Turbine.UI.MenuItem(_LANG.MESSAGE11[SETTINGS.LANGUAGE] .. acqItem));

			-- Get recent roll (if any)
			for k,v in pairs (_ROLLS) do
				if _ROLLS[k].PLAYER == acqName then
					strRoll = "(" .. _ROLLS[k].AMOUNT .. "): " .. _ROLLS[k].ROLLED;
					menuItems:Add(Turbine.UI.MenuItem(_LANG.MESSAGE13[SETTINGS.LANGUAGE] .. strRoll));

					local contextMenuItem = menuItems:Get(2);
					contextMenuItem.Click = function(sender, args)

						-- Add the roll to the history list as clicked
						for a,b in pairs(_LOOT) do
							if _LOOT[a].ID == tempLootID then
								_LOOT[a].ROLLED = _ROLLS[k].ROLLED;
								_LOOT[a].ROLL = _ROLLS[k].AMOUNT;

								local tempLogString = _LOOT[a].ITEM .. " - (" .. _LOOT[a].ROLLED .. "): " .. _LOOT[a].ROLL;

								RaidLog(4,tempLogString,acqName);
								tempItemLbl:SetForeColor(ORANGE);

								break;
							end
						end
					end
					break;
				end
			end

			local contextMenuItem = menuItems:Get(1);
			contextMenuItem.Click = function(sender, args)
				GAMessage(_LANG.MESSAGE12[SETTINGS.LANGUAGE] .. acqItem);

				-- Add to ignore list
				AddItemIgnore(_LOOT[k].ITEM);

				-- Remove from current _LOOT table.
				for ak,av in pairs (_LOOT) do
					if _LOOT[ak].ITEM == acqItem then
						_LOOT[ak] = nil;
						RefreshLootList();
					end
				end

				-- remove from item drop-downs
				RefreshLootItemMenu();
				RefreshLootPlayerMenu();
			end

			-- Display the menu at the current mouse location.
			contextMenu:ShowMenu();

		end

	end

	if IsBlacklisted(_LOOT[k].PLAYER) == true then
		tempNameLbl:SetForeColor(ROLLSBLISTED);
	end

	return tempHolder;

end


function AddItemIgnore(ITEM)

	local ExistsAlready = false;

	for k,v in pairs (_ITEMIGNORE) do
		if v==ITEM then ExistsAlready = true end;
	end

	if ExistsAlready == false then table.insert(_ITEMIGNORE,ITEM) end;

end


function ExportHistory()

	RefreshExportHistory(SETTINGS.LOOT.CHKROLLS);

	wLootExport:SetVisible(true);
	wLootExport:Activate();

end


function RefreshExportHistory(ROLLSONLY)

	local tempDate = Turbine.Engine.GetDate();
	local tempHour = tostring(tempDate.Hour);
	local tempMinute = tostring(tempDate.Minute);
	local tempDay = tostring(tempDate.Day);
	local tempMonth = tostring(tempDate.Month);
	if string.len(tempHour) == 1 then tempHour = "0" .. tempHour end;
	if string.len(tempMinute) == 1 then tempMinute = "0" .. tempMinute end;
	if string.len(tempDay) == 1 then tempDay = "0" .. tempDay end;
	if string.len(tempMonth) == 1 then tempMonth = "0" .. tempMonth end;

	local strDate = tempHour .. ":" .. tempMinute .. " " .. tempDay .. "/" .. tempMonth .. "/" .. tempDate.Year;

	local strHeader = PLUGINNAME .. " loot history \nFrom " .. LOOTSTARTDATE .. " to " .. strDate .. "\n\n";

	txtExport:SetText(strHeader);

	for k,v in pairs(_LOOT) do
		if ROLLSONLY == true then
			if _LOOT[k].ROLLED ~= "" then
				local expString = "[" .. _LOOT[k].TIME .. "] " .. _LOOT[k].PLAYER .. " - " .. _LOOT[k].ITEM;
				expString = expString .. " - (" .. _LOOT[k].ROLL .. "): " .. _LOOT[k].ROLLED;

				txtExport:AppendText(expString.."\n");
			end
		else
			local expString = "[" .. _LOOT[k].TIME .. "] " .. _LOOT[k].PLAYER .. " - " .. _LOOT[k].ITEM;

			if _LOOT[k].ROLL ~= "" then
				expString = expString .. " - (" .. _LOOT[k].ROLL .. "): " .. _LOOT[k].ROLLED;
			end

			txtExport:AppendText(expString.."\n");
		end
	end
end


function ResetItemList()

	lLootListBox:ClearItems();
	_LOOT = nil;
	_LOOT = {};
	RefreshLootPlayerMenu();
	RefreshLootItemMenu();
	SetStartDate();

end


function IgnoreItemList()

	local IgnoreCount = 0;
	LootIgnoreList:ClearItems();

	for k,v in pairs (_ITEMIGNORE) do

		local TempItemName = v;

		local tempLabel = Turbine.UI.Label();
		tempLabel:SetSize(370,17);
		tempLabel:SetFont(LISTFONT);
		tempLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		tempLabel:SetMultiline(false);
		tempLabel:SetText(v);

		tempLabel.MouseClick = function (sender, args)

			if args.Button == Turbine.UI.MouseButton.Right then

				local contextMenu = Turbine.UI.ContextMenu();

				-- Populate the menu with some items.
				local menuItems = contextMenu:GetItems();
				menuItems:Add(Turbine.UI.MenuItem(_LANG.REMOVE[SETTINGS.LANGUAGE] .. ": " .. TempItemName));

				local contextMenuItem = menuItems:Get(1);
				contextMenuItem.Click = function(sender, args)
					GAMessage(_LANG.REMOVEIGNORELOOT[SETTINGS.LANGUAGE] .. ": " .. TempItemName);

					-- Remove from the ignore list
					for k,v in pairs (_ITEMIGNORE) do
						if v == TempItemName then
							_ITEMIGNORE[k] = nil;
						end
					end

					-- Refresh the ignore list
					IgnoreItemList();
				end

				-- Display the menu at the current mouse location.
				contextMenu:ShowMenu();

			end
		end

		LootIgnoreList:AddItem(tempLabel);

		IgnoreCount = IgnoreCount + 1;

	end

	lblIgnoreEntries:SetText(IgnoreCount .. " " .. _LANG.Items[SETTINGS.LANGUAGE]);

	if IgnoreCount > 0 then
		btnLootIgnoreClear:SetEnabled(true);
	else
		btnLootIgnoreClear:SetEnabled(false);
	end

	wLootIgnore:SetVisible(true);
	wLootIgnore:Activate();

end
