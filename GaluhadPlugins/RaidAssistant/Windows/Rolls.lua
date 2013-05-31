
-- Rolls window.
function DrawRollWindow()

	local tempWidth = 420;
	local tempHeight = 375;

	wRollsParent = Turbine.UI.Lotro.Window();
	wRollsParent:SetSize(tempWidth,tempHeight);
	wRollsParent:SetPosition(SETTINGS.ROLLS.X,SETTINGS.ROLLS.Y);
	wRollsParent:SetText((_LANG.RollWindowTitle[SETTINGS.LANGUAGE]));
	wRollsParent:SetVisible(SETTINGS.ROLLS.VISIBLE);

	Includes.Onscreen(wRollsParent);

	cRollsBack = Turbine.UI.Control();
	cRollsBack:SetParent(wRollsParent);
	cRollsBack:SetSize(tempWidth,tempHeight);
	cRollsBack:SetPosition(0,-2);
	cRollsBack:SetBlendMode(4);
	cRollsBack:SetBackground(RESOURCEDIR.."Rolls.tga");
	cRollsBack:SetMouseVisible(false);

	lblLootRule = Turbine.UI.Label();
	lblLootRule:SetParent(wRollsParent);
	lblLootRule:SetPosition(32,40);
	lblLootRule:SetSize(356,17);
	lblLootRule:SetFont(BFONT);
	lblLootRule:SetForeColor(WHITE);
	lblLootRule:SetFontStyle(Turbine.UI.FontStyle.Outline);
	lblLootRule:SetVisible(true);

	if SETTINGS.LANGUAGE == "GERMAN" then
		lblLootRule:SetFont(Turbine.UI.Lotro.Font.Verdana12);
	end
	-- Kiki
	if SETTINGS.LANGUAGE == "FRENCH" then
		lblLootRule:SetFont(Turbine.UI.Lotro.Font.Verdana12);
	end
	-- Kiki

	lblRolls = Turbine.UI.Label()
	lblRolls:SetParent(wRollsParent);
	lblRolls:SetPosition(32,60);
	lblRolls:SetSize(120,17);
	lblRolls:SetFont(HFONT);

	if SETTINGS.LANGUAGE == "GERMAN" then
		lblRolls:SetFont(BFONT);
	end

	lblRolls:SetForeColor(HFONTCOLOR);
	lblRolls:SetFontStyle(Turbine.UI.FontStyle.Outline);
	lblRolls:SetText(_LANG.Roll_RollLbl[SETTINGS.LANGUAGE]);

	lblRollsFS = Turbine.UI.Label()
	lblRollsFS:SetParent(wRollsParent);
	lblRollsFS:SetPosition(250,60);
	lblRollsFS:SetSize(130,17);
	lblRollsFS:SetFont(HFONT);

	if SETTINGS.LANGUAGE == "GERMAN" then
		lblRollsFS:SetFont(BFONT);
		lblRollsFS:SetLeft(240);
		lblRollsFS:SetWidth(195);
	end

	lblRollsFS:SetForeColor(HFONTCOLOR);
	lblRollsFS:SetFontStyle(Turbine.UI.FontStyle.Outline);
	lblRollsFS:SetText(_LANG.Roll_FSLbl[SETTINGS.LANGUAGE]);

	RollslistBOX = Turbine.UI.ListBox();
	RollslistBOX:SetParent(wRollsParent);
	RollslistBOX:SetSize(175,204);
	RollslistBOX:SetPosition(35,90);
	RollslistBOX:SetVisible(true);

	RollslistScroll = Turbine.UI.Lotro.ScrollBar();
	RollslistScroll:SetParent(RollslistBOX);
	RollslistScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	RollslistScroll:SetSize(8,204);
	RollslistScroll:SetPosition(RollslistBOX:GetWidth()-9,0);
	RollslistScroll:SetVisible(false);
	RollslistScroll:SetZOrder(200000);
	RollslistBOX:SetVerticalScrollBar(RollslistScroll);

	RollsFSlistBOX = Turbine.UI.ListBox();
	RollsFSlistBOX:SetParent(wRollsParent);
	RollsFSlistBOX:SetSize(138,204);
	RollsFSlistBOX:SetPosition(247,90);
	RollsFSlistBOX:SetVisible(true);

	RollsFSlistScroll = Turbine.UI.Lotro.ScrollBar();
	RollsFSlistScroll:SetParent(RollsFSlistBOX);
	RollsFSlistScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	RollsFSlistScroll:SetSize(8,204);
	RollsFSlistScroll:SetPosition(RollsFSlistBOX:GetWidth()-9,0);
	RollsFSlistScroll:SetVisible(false);
	RollsFSlistScroll:SetZOrder(200000);
	RollsFSlistBOX:SetVerticalScrollBar(RollsFSlistScroll);

	wRefreshButton = Turbine.UI.Lotro.Button();
	wRefreshButton:SetParent(wRollsParent);
	wRefreshButton:SetText("Refresh");
	wRefreshButton:SetPosition(30,332);
	wRefreshButton:SetVisible(false);

	wClearButton = Turbine.UI.Lotro.Button();
	wClearButton:SetParent(wRollsParent);
	wClearButton:SetText(_LANG.Roll_Clear[SETTINGS.LANGUAGE]);
	wClearButton:SetPosition(273,310);
	wClearButton:SetWidth(90);
	if SETTINGS.LANGUAGE == "GERMAN" then wClearButton:SetWidth(100); wClearButton:SetLeft(268) end;
	wClearButton:SetVisible(true);

	chkUnique = Turbine.UI.Lotro.CheckBox();
	chkUnique:SetParent(wRollsParent);
	chkUnique:SetFontStyle(Turbine.UI.FontStyle.Outline);
	chkUnique:SetText(_LANG.Roll_Unique[SETTINGS.LANGUAGE]);
	chkUnique:SetPosition(245,332);
	chkUnique:SetSize(150,30);
	chkUnique:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	chkUnique:SetChecked(SETTINGS.ROLLS.CHKUNIQUE);
	chkUnique:SetVisible(true);


	qsRolls = Turbine.UI.Lotro.Quickslot();
	qsRolls:SetParent(wRollsParent);
	qsRolls:SetSize(86,18);
	qsRolls:SetPosition(73,311);
	qsRolls:SetZOrder(1);
	qsRolls:SetVisible(true);

	boxROLLSCHATICON = Turbine.UI.Control();
	boxROLLSCHATICON:SetSize(qsRolls:GetSize());
	boxROLLSCHATICON:SetParent(wRollsParent);
	boxROLLSCHATICON:SetPosition(qsRolls:GetLeft(),qsRolls:GetTop());
	boxROLLSCHATICON:SetBackground(RESOURCEDIR.."Button.tga");
	boxROLLSCHATICON:SetMouseVisible(false);
	boxROLLSCHATICON:SetZOrder(10000);

	lblSEND = Turbine.UI.Label()
	lblSEND:SetParent(boxROLLSCHATICON);
	lblSEND:SetPosition(0,0);
	lblSEND:SetSize(boxROLLSCHATICON:GetSize());
	lblSEND:SetFont(BFONT);
	lblSEND:SetForeColor(BUTTONCOLOR);
	lblSEND:SetFontStyle(Turbine.UI.FontStyle.Outline);
	lblSEND:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	lblSEND:SetMouseVisible(false);
	lblSEND:SetText(_LANG.SEND[SETTINGS.LANGUAGE]);


	wRefreshButton.Click = function (sender, args)

		--Includes.GroupChanged();

		TEMPSIZE, TEMPMEMBER = Includes.GetGroup();

		Turbine.Shell.WriteLine("Group size = " .. TEMPSIZE);
		Turbine.Shell.WriteLine(dump(TEMPMEMBER));

	end


	-- Clear button pressed
	wClearButton.Click = function (sender, args)

		rollsReset();

	end


	chkUnique.CheckedChanged = function (sender, args)

		-- Clear the table and UI text
		for i=1, ROLLCOUNTER do
			table.remove(_ROLLS,ROLLCOUNTER);
		end

		ROLLCOUNTER = 1;
		RollslistBOX:ClearItems();
		rolls_RefreshFSList();

		SETTINGS.ROLLS.CHKUNIQUE = chkUnique:IsChecked();

	end


	wRollsParent.Closing = function()
		SETTINGS.ROLLS.VISIBLE = false;

		local lang = SETTINGS.LANGUAGE;
		local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

		wMenuRolls:SetBackground(tempDir .. "Rolls_Up.jpg");
	end


	wRollsParent.PositionChanged = function()

		SETTINGS.ROLLS.X = wRollsParent:GetLeft();
		SETTINGS.ROLLS.Y = wRollsParent:GetTop();

	end

	rolls_RefreshFSList();
end


function rollsReset()

	-- Clear the table and UI text
	for i=1, ROLLCOUNTER do
		_ROLLS[i] = nil;
	end

	ROLLCOUNTER = 1;
	RollslistBOX:ClearItems();
	rolls_RefreshFSList();

end


function rolls_RefreshFSList()

	RollsFSlistBOX:ClearItems();
	TEMPSIZE = nil;
	TEMPMEMBER = {};
	GROUPLEADER = Includes.GetLeader();

	TEMPSIZE, TEMPMEMBER = Includes.GetGroup();

	--Turbine.Shell.WriteLine("call to: function rolls_RefreshFSList() \nSize = " .. TEMPSIZE);

	if TEMPSIZE > 1 then

		local sName = "";

		for i=1, TEMPSIZE, 1 do
			--sName = TEMPMEMBER[i]:GetName();
			sName = TEMPMEMBER[i];

			local tempParent = Turbine.UI.Control();
			tempParent:SetSize(RollsFSlistBOX:GetWidth()-8,17);
			tempParent:SetVisible(true);

			local tempLabel = Turbine.UI.Label();
			tempLabel:SetParent(tempParent);
			tempLabel:SetSize(tempParent:GetWidth()-15,17);
			tempLabel:SetLeft(15);
			tempLabel:SetText(sName);

			if IsBlacklisted(sName) == true then
				if sName ~= GROUPLEADER then
					local tempIcon = Turbine.UI.Control();
					tempIcon:SetParent(tempParent);
					tempIcon:SetSize(12,12);
					tempIcon:SetTop(-1);
					tempIcon:SetBackground(RESOURCEDIR.."Blacklisted.tga");
					tempIcon:SetBlendMode(4);
					tempIcon:SetVisible(true);
				end

				tempLabel:SetForeColor(ROLLSBLISTED);
			end

			if sName == GROUPLEADER then
				local tempIcon = Turbine.UI.Control();
				tempIcon:SetParent(tempParent);
				tempIcon:SetSize(12,12);
				tempIcon:SetTop(-3);
				tempIcon:SetBackground(RESOURCEDIR.."GroupLeader.tga");
				tempIcon:SetBlendMode(4);
				tempIcon:SetVisible(true);

				tempLabel:SetForeColor(GREEN);
			end

			if IsBlacklisted(sName) == true and sName == GROUPLEADER then
				tempLabel:SetForeColor(ROLLSBLISTED);
			end

			if sName == MYNAME then
				tempLabel:SetForeColor(YELLOW);
			end

			tempLabel:SetVisible(true);

			RollsFSlistBOX:AddItem(tempParent);
		end

	else

		local tempItem = Turbine.UI.Label();
		tempItem:SetSize(RollsFSlistBOX:GetWidth()-8,17);
		tempItem:SetText(" " .. _LANG.NoGroup[SETTINGS.LANGUAGE]);
		tempItem:SetVisible(true);
		--lblLootRule:SetText("");
		RollsFSlistBOX:AddItem(tempItem);
	end

end


function ChatRolls(ChatMessage)

	-- extract name and rolled amount, and roll.
	i = string.find(ChatMessage,(" " .. _LANG.rolled[SETTINGS.LANGUAGE]));

	-- Name
	local tempName = string.sub(ChatMessage,0,(i-1));
	local originalName = tempName;

	-- Rolled amount
	a = string.find(ChatMessage,"%(");
	b = string.find(ChatMessage,"%)");

	if a ~= nil then

		local tempAmount = string.sub(ChatMessage,(a+1),(b-1));

		-- Final Roll
		-- KIKI START : changed string to find  from ): to : because there is a space before the colon in french, add start find at pos b too
		i,j = string.find(ChatMessage,": ", b);
		-- KIKI END
		
		-- DToX Start
		local finalRoll;
		if SETTINGS.LANGUAGE == "RUSSIAN" then
			finalRoll = tonumber(string.match(ChatMessage, "%s+(%d+)%s+"));
		else
			finalRoll = tonumber(string.sub(ChatMessage, j)); -- Plugin default
		end
		-- DToX End
		

		local _TEMPROLLS = {["PLAYER"] = tempName;["AMOUNT"] = tempAmount;["ROLLED"] = finalRoll;};

		local INSERTPOS = 1;
		local NAMEREPEAT = false;

		-- loop to see where to insert the new value.. also use the same loop to check for name repeats.
		if ROLLCOUNTER > 1 then

			local r = 1;

			while r < ROLLCOUNTER do

				if finalRoll < _ROLLS[r].ROLLED then
					INSERTPOS = r+1;
				end

				if originalName == _ROLLS[r].PLAYER then
					-- Player already registered a roll.
					NAMEREPEAT = true;
				end

				r = r + 1;

			end

		end

		if chkUnique:IsChecked() == true then
			-- Unique rolls only, so ignore unless NAMEREPEAT == false.
			if NAMEREPEAT == false then -- Ok to add.
				table.insert(_ROLLS, INSERTPOS, _TEMPROLLS);
				RaidLog(1,("(" .. _TEMPROLLS.AMOUNT .. "): " .. _TEMPROLLS.ROLLED), _TEMPROLLS.PLAYER); -- TYPES: 1 = Roll; 2 = Item; 3 = Group
				ROLLCOUNTER = ROLLCOUNTER + 1;
			end
		else
			-- All rolls count
			table.insert(_ROLLS, INSERTPOS, _TEMPROLLS);
			RaidLog(1,("(" .. _TEMPROLLS.AMOUNT .. "): " .. _TEMPROLLS.ROLLED), _TEMPROLLS.PLAYER); -- TYPES: 1 = Roll; 2 = Item; 3 = Group
			ROLLCOUNTER = ROLLCOUNTER + 1;
		end

		-- Clear the textbox, then update with new roll order
		RollslistBOX:ClearItems();

		local tempPartySize, TEMPMEMBER = Includes.GetGroup();

		--Turbine.Shell.WriteLine("tempPartySize = " .. tempPartySize);

		local tempCHANNEL = "";

		if tempPartySize > 6 then
			if SETTINGS.LANGUAGE == "GERMAN" then
				tempCHANNEL = "/szc";
			else
				tempCHANNEL = "/ra";
			end
		else
			if SETTINGS.LANGUAGE == "GERMAN" then
				tempCHANNEL = "/g";
			else
				tempCHANNEL = "/f";
			end
		end


		local tempString = tempCHANNEL .. " <rgb=#5599FF>\n<u>".. _LANG.ROLLRESULTS[SETTINGS.LANGUAGE] .. "</u> (Raid Assistant): </rgb><rgb=#7cabbd>";

		for c=1, (ROLLCOUNTER-1) do

			local tempItem = Turbine.UI.Label();
			tempItem:SetSize(RollslistBOX:GetWidth()-8,17);

			if _ROLLS[c].PLAYER == GROUPLEADER then
				tempItem:SetForeColor(GREEN);
			end

			if IsBlacklisted(_ROLLS[c].PLAYER) == true then
				tempItem:SetForeColor(ROLLSBLISTED);
			end

			if _ROLLS[c].PLAYER == MYNAME then
				tempItem:SetForeColor(YELLOW);
			end

			local PlayerName = _ROLLS[c].PLAYER;

			-- LINK TO CHAT SHORTCUT
			tempString = tempString .. "\n" .. _ROLLS[c].ROLLED .. " - " .. PlayerName .. " (" .. _ROLLS[c].AMOUNT .. ") ";


			local NAMEMAXLEN = 10;
			-- DToX Start
			if SETTINGS.LANGUAGE == "RUSSIAN" then NAMEMAXLEN = 25 end
			-- DToX End
			
			if string.len(PlayerName) > NAMEMAXLEN then PlayerName = string.sub(PlayerName,1,(NAMEMAXLEN-1)) .. ".." end;

			tempItem:SetText(_ROLLS[c].ROLLED .. " - " .. PlayerName .. " (" .. _ROLLS[c].AMOUNT .. ")");
			RollslistBOX:AddItem(tempItem);

		end


		-- Search the names list box and delete the player name.
		local listCount = RollsFSlistBOX:GetItemCount();

		for x=1, listCount do

			local listITEM = RollsFSlistBOX:GetItem(x);
			local listCHILDS = listITEM:GetControls();
			local listLABEL = listCHILDS:Get(1);

			local labelText = listLABEL:GetText();

			if labelText == originalName then
				RollsFSlistBOX:RemoveItem(listITEM)
				break;
			end

		end


		-- Create list of players not rolled.

		local listCount = RollsFSlistBOX:GetItemCount();


		if listCount > 0 then
			tempString = tempString .. "\n <rgb=#5599FF>\n<u>".. _LANG.PASS[SETTINGS.LANGUAGE] .. "</u>: </rgb><rgb=#7cabbd>";
		end

		for x=1, listCount do

			local listITEM = RollsFSlistBOX:GetItem(x);
			local listCHILDS = listITEM:GetControls();
			local listLABEL = listCHILDS:Get(1);

			local labelText = listLABEL:GetText();

			tempString = tempString .. "\n" .. labelText .. " ";

		end


		tempString = tempString .."</rgb>\n \n ";

		-- DToX Start
		if SETTINGS.LANGUAGE == "RUSSIAN" then -- Shamanism
			local sc = Turbine.UI.Lotro.Shortcut(Turbine.UI.Lotro.ShortcutType.Alias,'');
			sc:SetData(tempString);
			qsRolls:SetShortcut(sc);
		else
			qsRolls:SetShortcut(Turbine.UI.Lotro.Shortcut( Turbine.UI.Lotro.ShortcutType.Alias, tempString)); -- Plugin default
		end
		-- DToX End
		
		end

end


function ChangeRules(RuleMessage)

	-- Handles changes in loot rules
	-- Determine if it was a change in rule or quality
	local lr = string.find(RuleMessage,(_LANG.LootRule[SETTINGS.LANGUAGE]));

	if lr == nil then

		-- Could not find change in loot rule so change must have been in quality.
		for i=1, 6 do
			local tq = string.find(RuleMessage,(_LANG.LOOTQUALITIES[i][SETTINGS.LANGUAGE]));
			if tq ~= nil then
				CURLOOTQUAL = _LANG.LOOTQUALITIES[i][SETTINGS.LANGUAGE];

				Windows.RaidLog(3,_LANG.LOGLOOTQUAL[SETTINGS.LANGUAGE] .. CURLOOTQUAL, Includes.GetLeader());
				break
			end;
		end

	else

		-- Found so change is in loot rule.
		for i=1, 7 do
			local tr = string.find(RuleMessage,(_LANG.LOOTRULES[i][SETTINGS.LANGUAGE]).."%.");
			if tr ~= nil then
				CURLOOTRULE = _LANG.LOOTRULES[i][SETTINGS.LANGUAGE];
				CURLOOTRULE = string.gsub(CURLOOTRULE,"%%","");

				Windows.RaidLog(3,_LANG.LOGLOOTRULE[SETTINGS.LANGUAGE] .. CURLOOTRULE, Includes.GetLeader());
				break
			end;
		end
	end


	lblLootRule:SetText(CURLOOTRULE .. " [" .. CURLOOTQUAL .. "]");

	-- CURLOOTQUAL = loot quality
	-- CURLOOTRULE = loot rule

end
