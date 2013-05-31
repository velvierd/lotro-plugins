-- LFF window.
function DrawLogWindow()

	if wLogParent == nil then

		local tempWidth = 450;
		local tempHeight = 510;

		wLogParent = Turbine.UI.Lotro.Window();
		wLogParent:SetSize(tempWidth,tempHeight);
		wLogParent:SetPosition(SETTINGS.LOG.X,SETTINGS.LOG.Y);
		wLogParent:SetText(_LANG.RAIDLOG[SETTINGS.LANGUAGE]);
		wLogParent:SetVisible(SETTINGS.LOG.VISIBLE);

		Includes.Onscreen(wLogParent);

		wLogBack = Turbine.UI.Control();
		wLogBack:SetParent(wLogParent);
		wLogBack:SetSize(tempWidth,tempHeight);
		wLogBack:SetBlendMode(4);
		wLogBack:SetBackground(RESOURCEDIR.."RaidLog.tga");
		wLogBack:SetMouseVisible(false);


		wLogParent.Closing = function()
			SETTINGS.LOG.VISIBLE = false;

			local lang = SETTINGS.LANGUAGE;
			local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

			wMenuLog:SetBackground(tempDir .. "Log_Up.jpg");
		end

		wLogParent.PositionChanged = function()
			SETTINGS.LOG.X = wLogParent:GetLeft();
			SETTINGS.LOG.Y = wLogParent:GetTop();
		end


		local _TypeDropDown = {_LANG.ALL[SETTINGS.LANGUAGE]};
		for k,v in pairs (_LOGTYPE) do
			table.insert(_TypeDropDown,v);
		end

		-- Drop Down
		logTypeDropDown = Includes.DropDown.Create(_TypeDropDown);
		logTypeDropDown:SetParent(wLogParent);
		logTypeDropDown:SetPosition(90,55);
		logTypeDropDown:ApplyWidth(100);
		logTypeDropDown:SetVisible(true);
		logTypeDropDown:SetMenuEnabled(true);

		logTypeDropDown.ItemChanged = function ()
			-- Filter by selection
			RefreshPlayerMenu();
			RefreshLogList();
		end


		local _PlayerDropDown = {_LANG.ALL[SETTINGS.LANGUAGE]};

		-- Drop Down
		logPlayerDropDown = Includes.DropDown.Create(_PlayerDropDown);
		logPlayerDropDown:SetParent(wLogParent);
		logPlayerDropDown:SetPosition(210,55);
		logPlayerDropDown:ApplyWidth(140);
		logPlayerDropDown:SetVisible(true);
		logPlayerDropDown:SetMenuEnabled(true);

		logPlayerDropDown.ItemChanged = function ()
			-- Filter by selection
			RefreshLogList();
		end


		LogStatusLabel = Turbine.UI.Label();
		LogStatusLabel:SetParent(wLogParent);
		LogStatusLabel:SetSize(tempWidth-40,17);
		LogStatusLabel:SetPosition(20,90);
		LogStatusLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		LogStatusLabel:SetText(_LANG.LOGSTATUS01[SETTINGS.LANGUAGE]);

		RaidExportTxt = Turbine.UI.Lotro.TextBox();
		RaidExportTxt:SetParent(wLogParent);
		RaidExportTxt:SetSize(tempWidth-48,332);
		RaidExportTxt:SetPosition(20,117);
		RaidExportTxt:SetMultiline(true);
		RaidExportTxt:SetSelectable(true);
		RaidExportTxt:SetFont(LISTFONT);
		--RaidExportTxt:SetBackColor(WHITE);
		RaidExportTxt:SetVisible(false);

		RaidLogList = Turbine.UI.ListBox();
		RaidLogList:SetParent(wLogParent);
		RaidLogList:SetSize(tempWidth-48,332);
		RaidLogList:SetPosition(20,117);
		--RaidLogList:SetBackColor(WHITE);
		RaidLogList:SetVisible(true);

		RaidLogVScroll = Turbine.UI.Lotro.ScrollBar();
		RaidLogVScroll:SetParent(wLogParent);
		RaidLogVScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
		RaidLogVScroll:SetSize(8,RaidLogList:GetHeight());
		RaidLogVScroll:SetPosition((RaidLogList:GetLeft() + RaidLogList:GetWidth()),RaidLogList:GetTop());
		RaidLogVScroll:SetVisible(false);
		RaidLogVScroll:SetZOrder(200001);
		RaidLogList:SetVerticalScrollBar(RaidLogVScroll);

		RaidLogHScroll = Turbine.UI.Lotro.ScrollBar();
		RaidLogHScroll:SetParent(wLogParent);
		RaidLogHScroll:SetOrientation(Turbine.UI.Orientation.Horizontal);
		RaidLogHScroll:SetSize(RaidLogList:GetWidth(),8);
		RaidLogHScroll:SetPosition(RaidLogList:GetLeft(),(RaidLogList:GetTop() + RaidLogList:GetHeight()));
		RaidLogHScroll:SetVisible(false);
		RaidLogHScroll:SetZOrder(200000);
		RaidLogList:SetHorizontalScrollBar(RaidLogHScroll);

		RaidExportTxt:SetVerticalScrollBar(RaidLogVScroll);
		RaidExportTxt:SetHorizontalScrollBar(RaidLogHScroll);

		RaidExportBtn = Turbine.UI.Lotro.Button();
		RaidExportBtn:SetParent(wLogParent);
		RaidExportBtn:SetText(_LANG.Export[SETTINGS.LANGUAGE]);
		RaidExportBtn:SetPosition(40,472);
		RaidExportBtn:SetWidth(60);
		RaidExportBtn:SetVisible(false);

		RaidExportBtn.Click = function (sender, args)

			if RaidExportBtn:GetText() == _LANG.Export[SETTINGS.LANGUAGE] then
				RaidExportTxt:SetVisible(true);
				RaidLogList:SetVisible(false);
				RaidSelectBtn:SetVisible(true);
				RaidExportBtn:SetText(_LANG.BACK[SETTINGS.LANGUAGE]);
				logTypeDropDown:SetMenuEnabled(false);
				logPlayerDropDown:SetMenuEnabled(false);

				GenerateLogExport();
			else
				RaidExportTxt:SetVisible(false);
				RaidLogList:SetVisible(true);
				RaidSelectBtn:SetVisible(false);
				RaidExportBtn:SetText(_LANG.Export[SETTINGS.LANGUAGE]);
				logTypeDropDown:SetMenuEnabled(true);
				logPlayerDropDown:SetMenuEnabled(true);
			end
		end

		RaidSelectBtn = Turbine.UI.Lotro.Button();
		RaidSelectBtn:SetParent(wLogParent);
		RaidSelectBtn:SetText(_LANG.SelectAll[SETTINGS.LANGUAGE]);
		RaidSelectBtn:SetPosition(120,472);
		RaidSelectBtn:SetWidth(80);
		RaidSelectBtn:SetVisible(false);

		if SETTINGS.LANGUAGE == "GERMAN" then RaidSelectBtn:SetWidth(100) end;

		RaidSelectBtn.Click = function (sender, args)
			RaidExportTxt:SelectAll();
			RaidExportTxt:Focus();
		end
	end
end


function StartLogging()
	-- Reset Log table.
	for k,v in pairs (_RAIDLOG) do
		_RAIDLOG[k] = nil;
	end

	if wLogParent:IsVisible() == true then
		RefreshLogList();
	end

	-- Begin log.
	blLOGGING = true;

	RaidExportBtn:SetVisible(false);

	LogStatusLabel:SetText(_LANG.LOGSTATUS02[SETTINGS.LANGUAGE]);

	local tempDate = Turbine.Engine.GetDate();
	local tempHour = tostring(tempDate.Hour);
	local tempMinute = tostring(tempDate.Minute);
	local tempDay = tostring(tempDate.Day);
	local tempMonth = tostring(tempDate.Month);
	if string.len(tempHour) == 1 then tempHour = "0" .. tempHour end;
	if string.len(tempMinute) == 1 then tempMinute = "0" .. tempMinute end;
	if string.len(tempDay) == 1 then tempDay = "0" .. tempDay end;
	if string.len(tempMonth) == 1 then tempMonth = "0" .. tempMonth end;

	LOGSTART = tempHour .. ":" .. tempMinute .. " " .. tempDay .. "/" .. tempMonth .. "/" .. tempDate.Year;
end


function StopLogging()
	-- End logging.
	blLOGGING = false;

	RaidExportBtn:SetVisible(true);

	local tempDate = Turbine.Engine.GetDate();
	local tempHour = tostring(tempDate.Hour);
	local tempMinute = tostring(tempDate.Minute);
	local tempDay = tostring(tempDate.Day);
	local tempMonth = tostring(tempDate.Month);
	if string.len(tempHour) == 1 then tempHour = "0" .. tempHour end;
	if string.len(tempMinute) == 1 then tempMinute = "0" .. tempMinute end;
	if string.len(tempDay) == 1 then tempDay = "0" .. tempDay end;
	if string.len(tempMonth) == 1 then tempMonth = "0" .. tempMonth end;

	LOGFINISH = tempHour .. ":" .. tempMinute .. " " .. tempDay .. "/" .. tempMonth .. "/" .. tempDate.Year;

	LogStatusLabel:SetText(_LANG.RAIDLOG[SETTINGS.LANGUAGE] .. ": " .. LOGSTART .. " - " .. LOGFINISH);
end


function RaidLog(TYPE,MESSAGE,PLAYER) -- TYPES: 1 = Roll; 2 = Item; 3 = Group; 4 = Win

	if blLOGGING == true then

		local tempDate = Turbine.Engine.GetDate();
		local tempHour = tostring(tempDate.Hour);
		local tempMinute = tostring(tempDate.Minute);

		if string.len(tempHour) == 1 then tempHour = "0" .. tempHour end;
		if string.len(tempMinute) == 1 then tempMinute = "0" .. tempMinute end;

		local tempTime = tempHour .. ":" .. tempMinute;

		table.insert(_RAIDLOG, {["TIME"] = tempTime; ["TYPE"] = TYPE; ["MESSAGE"] = MESSAGE; ["PLAYER"] = PLAYER;});

		if wLogParent:IsVisible() == true then
			RefreshLogList();
		end

		RefreshPlayerMenu();

	end
end


function RefreshPlayerMenu()

	-- Get and hold the current value for the menu. If it still exists in the menu after the change
	-- then use as default.
	local tempOldValue = logPlayerDropDown:GetText();
	local oldValueExists = false;
	local blEXISTS = false;

	local _TEMPPLAYERS = {_LANG.ALL[SETTINGS.LANGUAGE]};
	local tempType = logTypeDropDown:GetText();

	for k,v in pairs (_RAIDLOG) do

		local tempRAIDLOGTYPE = _LOGTYPE[_RAIDLOG[k].TYPE];
		blEXISTS = false;

		-- Only add entries that match the type dropdown
		if (tempType == tempRAIDLOGTYPE) or (tempType == _LANG.ALL[SETTINGS.LANGUAGE]) then

			local tempPlayer = _RAIDLOG[k].PLAYER;
			if tempPlayer == tempOldValue then oldValueExists = true end;

			-- Check the player name to see if it exists in the table already, if not add it.
			for a,b in pairs(_TEMPPLAYERS) do
				if b == tempPlayer then
					blEXISTS = true;
					break;
				end
			end

			if blEXISTS == false then table.insert(_TEMPPLAYERS,tempPlayer) end;
		end
	end

	-- Get the dropdown list and apply the new menu items
	local tempList = logPlayerDropDown:GetItemList();
	tempList:Clear();

	for k,v in pairs(_TEMPPLAYERS) do
		local myTempItem = Turbine.UI.MenuItem(v);
		tempList:Add(myTempItem);
	end

	if oldValueExists == true then
		logPlayerDropDown:SetLabel(tempOldValue);
	else
		logPlayerDropDown:SetLabel(_LANG.ALL[SETTINGS.LANGUAGE]);
	end
end


function RefreshLogList()

	RaidLogList:ClearItems();

	local LineHeight = 17;

	logHeader = Turbine.UI.Control();
	--logHeader:SetParent(wLogParent);
	logHeader:SetSize(RaidLogList:GetWidth(),17);
	--logHeader:SetPosition(20,183);

	logHeaderTime = Turbine.UI.Label();
	logHeaderTime:SetParent(logHeader);
	logHeaderTime:SetSize(43,17);
	logHeaderTime:SetPosition(0,0);
	logHeaderTime:SetFont(BFONT);
	logHeaderTime:SetForeColor(HFONTCOLOR);
	logHeaderTime:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	logHeaderTime:SetText(_LANG.LOGHEADERTIME[SETTINGS.LANGUAGE]);

	logHeaderType = Turbine.UI.Label();
	logHeaderType:SetParent(logHeader);
	logHeaderType:SetSize(50,17);
	logHeaderType:SetPosition(48,0);
	logHeaderType:SetFont(BFONT);
	logHeaderType:SetForeColor(HFONTCOLOR);
	logHeaderType:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	logHeaderType:SetText(_LANG.LOGHEADERTYPE[SETTINGS.LANGUAGE]);

	logHeaderPlayer = Turbine.UI.Label();
	logHeaderPlayer:SetParent(logHeader);
	logHeaderPlayer:SetSize(95,17);
	logHeaderPlayer:SetPosition(103,0);
	logHeaderPlayer:SetFont(BFONT);
	logHeaderPlayer:SetForeColor(HFONTCOLOR);
	logHeaderPlayer:SetMultiline(false);
	logHeaderPlayer:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	logHeaderPlayer:SetText(_LANG.LOGHEADERPLAYER[SETTINGS.LANGUAGE]);

	logHeaderMsg = Turbine.UI.Label();
	logHeaderMsg:SetParent(logHeader);
	logHeaderMsg:SetSize(247,17);
	logHeaderMsg:SetPosition(203,0);
	logHeaderMsg:SetFont(BFONT);
	logHeaderMsg:SetForeColor(HFONTCOLOR);
	logHeaderMsg:SetMultiline(false);
	logHeaderMsg:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	logHeaderMsg:SetText(_LANG.LOGHEADERMSG[SETTINGS.LANGUAGE]);

	RaidLogList:AddItem(logHeader);

	local tempType = logTypeDropDown:GetText();
	local tempPlayer = logPlayerDropDown:GetText();

	for k,v in pairs(_RAIDLOG) do

		local tempRAIDLOGTYPE = _LOGTYPE[_RAIDLOG[k].TYPE];

		-- Apply selected filters and generate list.
		if ((tempType == tempRAIDLOGTYPE) or (tempType == _LANG.ALL[SETTINGS.LANGUAGE])) and ((tempPlayer == _RAIDLOG[k].PLAYER) or (tempPlayer == _LANG.ALL[SETTINGS.LANGUAGE])) then

			-- List Item parent
			local tempLogHolder = Turbine.UI.Control();
			tempLogHolder:SetSize(600,LineHeight);


			-- List controls.
			local tempTimeStamp = Turbine.UI.Label();
			tempTimeStamp:SetParent(tempLogHolder);
			tempTimeStamp:SetSize(43,LineHeight);
			tempTimeStamp:SetPosition(0,0);
			tempTimeStamp:SetFont(LISTFONT);
			tempTimeStamp:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
			tempTimeStamp:SetText("[" .. _RAIDLOG[k].TIME .. "]");

			local tempLogType = Turbine.UI.Label();
			tempLogType:SetParent(tempLogHolder);
			tempLogType:SetSize(50,LineHeight);
			tempLogType:SetPosition(48,0);
			tempLogType:SetFont(LISTFONT);
			tempLogType:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
			tempLogType:SetText(_LOGTYPE[_RAIDLOG[k].TYPE]);

			local tempLogPlayer = Turbine.UI.Label();
			tempLogPlayer:SetParent(tempLogHolder);
			tempLogPlayer:SetSize(95,LineHeight);
			tempLogPlayer:SetPosition(103,0);
			tempLogPlayer:SetFont(LISTFONT);
			tempLogPlayer:SetMultiline(false);
			tempLogPlayer:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
			tempLogPlayer:SetText(_RAIDLOG[k].PLAYER);

			local tempLogMessage = Turbine.UI.Label();
			tempLogMessage:SetParent(tempLogHolder);
			tempLogMessage:SetSize(412,LineHeight);
			tempLogMessage:SetPosition(203,0);
			tempLogMessage:SetFont(LISTFONT);
			tempLogMessage:SetMultiline(false);
			tempLogMessage:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
			tempLogMessage:SetText(_RAIDLOG[k].MESSAGE);

			if _RAIDLOG[k].TYPE == 1 then --Roll
				tempTimeStamp:SetForeColor(SETTINGS.LOG.COLOR_ROLLS);
				tempLogType:SetForeColor(SETTINGS.LOG.COLOR_ROLLS);
				tempLogPlayer:SetForeColor(SETTINGS.LOG.COLOR_ROLLS);
				tempLogMessage:SetForeColor(SETTINGS.LOG.COLOR_ROLLS);
			elseif _RAIDLOG[k].TYPE == 2 then -- Item
				tempTimeStamp:SetForeColor(SETTINGS.LOG.COLOR_ITEMS);
				tempLogType:SetForeColor(SETTINGS.LOG.COLOR_ITEMS);
				tempLogPlayer:SetForeColor(SETTINGS.LOG.COLOR_ITEMS);
				tempLogMessage:SetForeColor(SETTINGS.LOG.COLOR_ITEMS);
			elseif _RAIDLOG[k].TYPE == 3 then -- Group
				tempTimeStamp:SetForeColor(SETTINGS.LOG.COLOR_GROUP);
				tempLogType:SetForeColor(SETTINGS.LOG.COLOR_GROUP);
				tempLogPlayer:SetForeColor(SETTINGS.LOG.COLOR_GROUP);
				tempLogMessage:SetForeColor(SETTINGS.LOG.COLOR_GROUP);
			elseif _RAIDLOG[k].TYPE == 4 then -- Win
				tempTimeStamp:SetForeColor(SETTINGS.LOG.COLOR_WIN);
				tempLogType:SetForeColor(SETTINGS.LOG.COLOR_WIN);
				tempLogPlayer:SetForeColor(SETTINGS.LOG.COLOR_WIN);
				tempLogMessage:SetForeColor(SETTINGS.LOG.COLOR_WIN);
			end

			RaidLogList:AddItem(tempLogHolder);

		end
	end
end


function GenerateLogExport()

	local strHeader = PLUGINNAME .. " Log \nFrom " .. LOGSTART .. " to " .. LOGFINISH .. "\n\n";

	RaidExportTxt:SetText(strHeader);

	local tempType = logTypeDropDown:GetText();
	local tempPlayer = logPlayerDropDown:GetText();

	for k,v in pairs (_RAIDLOG) do

		local tempRAIDLOGTYPE = _LOGTYPE[_RAIDLOG[k].TYPE];

		-- Apply selected filters and generate list.
		if ((tempType == tempRAIDLOGTYPE) or (tempType == _LANG.ALL[SETTINGS.LANGUAGE])) and ((tempPlayer == _RAIDLOG[k].PLAYER) or (tempPlayer == _LANG.ALL[SETTINGS.LANGUAGE])) then

			local sLogExport = "[" .. _RAIDLOG[k].TIME .. "] - " .. tempRAIDLOGTYPE .. " - " .. _RAIDLOG[k].PLAYER .. ": " .. _RAIDLOG[k].MESSAGE;
			RaidExportTxt:AppendText(sLogExport.."\n");
		end
	end
end

--[[

_RAIDLOG =
{
	["TIME"] = "18:02";
	["TYPE"] = 2;
	["MESSAGE"] = "Acquired [Some Item]";
	["PLAYER"] = "Galuhad";
};

--]]

