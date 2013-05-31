-- Blacklist window.
function DrawBListWindow()

	local tempWidth = 400;
	local tempHeight = 500;
	local MAXCOMMENTLENGTH = 100;

	wBListParent = Turbine.UI.Lotro.Window();
	wBListParent:SetSize(tempWidth,tempHeight);
	wBListParent:SetPosition(SETTINGS.BLACKLIST.X,SETTINGS.BLACKLIST.Y);
	wBListParent:SetText(_LANG.BListWindowTitle[SETTINGS.LANGUAGE]);
	wBListParent:SetVisible(SETTINGS.BLACKLIST.VISIBLE);

	Includes.Onscreen(wBListParent);

	wBListBack = Turbine.UI.Control();
	wBListBack:SetParent(wBListParent);
	wBListBack:SetSize(tempWidth,tempHeight);
	wBListBack:SetBlendMode(4);
	wBListBack:SetBackground(RESOURCEDIR.."Blacklist.tga");
	wBListBack:SetMouseVisible(false);

	lblSort = Turbine.UI.Label();
	lblSort:SetParent(wBListParent);
	lblSort:SetSize(80,17);
	lblSort:SetPosition(190,50);
	lblSort:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
	lblSort:SetText(_LANG.SORT[SETTINGS.LANGUAGE]..": ");


	local tSORT = {_LANG.AZ[SETTINGS.LANGUAGE], _LANG.ZA[SETTINGS.LANGUAGE]};

	-- Drop Down
	blSortDropDown = Includes.DropDown.Create(tSORT);
	blSortDropDown:SetParent(wBListParent);
	blSortDropDown:SetPosition(270,50);
	blSortDropDown:ApplyWidth(100);
	blSortDropDown:SetVisible(true);
	blSortDropDown:SetAlignment("center");
	blSortDropDown:SetMenuEnabled(true);

	blSortDropDown.ItemChanged = function ()
		-- Sort by selection
		SortBlacklist(blSortDropDown:GetText());
	end


	treeBlacklist = Turbine.UI.ListBox();
	treeBlacklist:SetParent(wBListParent);
	treeBlacklist:SetSize(tempWidth-23,tempHeight-160);
	treeBlacklist:SetPosition(13,90);
	--treeBlacklist:SetBackColor(WHITE);

	blacklistScroll = Turbine.UI.Lotro.ScrollBar();
	blacklistScroll:SetParent(treeBlacklist);
	blacklistScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	blacklistScroll:SetSize(8,treeBlacklist:GetHeight());
	blacklistScroll:SetPosition(treeBlacklist:GetWidth()-9,0);
	blacklistScroll:SetVisible(false);
	blacklistScroll:SetZOrder(200000);
	treeBlacklist:SetVerticalScrollBar(blacklistScroll);

	BlAddBtn = Turbine.UI.Lotro.Button();
	BlAddBtn:SetParent(wBListParent);
	BlAddBtn:SetText(_LANG.ADD[SETTINGS.LANGUAGE]);
	BlAddBtn:SetPosition(30,450);
	BlAddBtn:SetWidth(60);

	BlAddBtn.Click = function (sender, args)

		wBLedit:SetVisible(true);
		wBLedit:Activate();

	end

	BlRemoveBtn = Turbine.UI.Lotro.Button();
	BlRemoveBtn:SetParent(wBListParent);
	BlRemoveBtn:SetText(_LANG.REMOVE[SETTINGS.LANGUAGE]);
	BlRemoveBtn:SetPosition(100,450);
	BlRemoveBtn:SetWidth(70);

	BlRemoveBtn.Click = function (sender, args)
		RemoveSelectedBL(SELECTEDBL);
	end

	BlEditBtn = Turbine.UI.Lotro.Button();
	BlEditBtn:SetParent(wBListParent);
	BlEditBtn:SetText(_LANG.EDIT[SETTINGS.LANGUAGE]);
	BlEditBtn:SetPosition(310,450);
	BlEditBtn:SetWidth(60);

	BlEditBtn.Click = function (sender,args)
		EditSelectedBL(SELECTEDBL);
	end


	if SETTINGS.LANGUAGE == "GERMAN" or SETTINGS.LANGUAGE == "FRENCH" then
		BlAddBtn:SetLeft(25);
		BlAddBtn:SetWidth(90);

		BlRemoveBtn:SetLeft(120);
		BlRemoveBtn:SetWidth(80);

		BlEditBtn:SetLeft(290);
		BlEditBtn:SetWidth(80);
	end


	wBListParent.Closing = function()
		SETTINGS.BLACKLIST.VISIBLE = false;

		local lang = SETTINGS.LANGUAGE;
		local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

		wMenuBList:SetBackground(tempDir .. "BList_Up.jpg");
	end

	wBListParent.PositionChanged = function()

		SETTINGS.BLACKLIST.X = wBListParent:GetLeft();
		SETTINGS.BLACKLIST.Y = wBListParent:GetTop();

	end


	-- Add/Edit entry window..
	wBLedit = Turbine.UI.Lotro.Window();
	wBLedit:SetSize(300,200);
	wBLedit:SetPosition((SCREENWIDTH/2)-150,SCREENHEIGHT/3);
	wBLedit:SetText(_LANG.BListWindowTitle[SETTINGS.LANGUAGE]);
	wBLedit:SetVisible(false);

	bgBLedit = Turbine.UI.Control();
	bgBLedit:SetParent(wBLedit);
	bgBLedit:SetSize(300,200);
	bgBLedit:SetBackground(RESOURCEDIR.."BList_Edit.tga");
	bgBLedit:SetBlendMode(4);
	bgBLedit:SetMouseVisible(false);


	txtBLeditName = Turbine.UI.TextBox();
	txtBLeditName:SetParent(wBLedit);
	txtBLeditName:SetSize(240,17);
	txtBLeditName:SetPosition(30,50);
	txtBLeditName:SetMultiline(false);
	txtBLeditName:SetVisible(true);
	txtBLeditName:SetSelectable(true);
	txtBLeditName:SetFont(HFONT);
	txtBLeditName:SetText(_LANG.NAME[SETTINGS.LANGUAGE]);

	txtBLeditReason = Turbine.UI.TextBox();
	txtBLeditReason:SetParent(wBLedit);
	txtBLeditReason:SetSize(240,68);
	txtBLeditReason:SetPosition(30,80);
	txtBLeditReason:SetMultiline(true);
	txtBLeditReason:SetVisible(true);
	txtBLeditReason:SetSelectable(true);
	txtBLeditReason:SetFont(HFONT);
	txtBLeditReason:SetText(_LANG.REASON[SETTINGS.LANGUAGE]);
	txtBLeditReason:SetWantsUpdates(true);

	txtBLeditReason.FocusGained = function (sender, args)
		txtBLeditReason:SetWantsUpdates(true);
	end

	txtBLeditReason.FocusLost = function (sender, args)
		txtBLeditReason:SetWantsUpdates(false);
	end

	txtBLeditReason.Update = function (sender, args)
		if string.len(txtBLeditReason:GetText()) > MAXCOMMENTLENGTH then txtBLeditReason:SetText(string.sub(txtBLeditReason:GetText(),1,MAXCOMMENTLENGTH)) end;
	end

--~ 	txtBLeditName:SetBackColor(WHITE);
--~ 	txtBLeditName:SetForeColor(BLACK);
--~ 	txtBLeditReason:SetBackColor(WHITE);
--~ 	txtBLeditReason:SetForeColor(BLACK);

	btnBLeditSave = Turbine.UI.Lotro.Button();
	btnBLeditSave:SetParent(wBLedit);
	btnBLeditSave:SetPosition(30,160);
	btnBLeditSave:SetWidth(60);
	btnBLeditSave:SetText(_LANG.SAVE[SETTINGS.LANGUAGE]);

	btnBLeditCancel = Turbine.UI.Lotro.Button();
	btnBLeditCancel:SetParent(wBLedit);
	btnBLeditCancel:SetPosition(100,160);
	btnBLeditCancel:SetWidth(60);
	btnBLeditCancel:SetText(_LANG.CANCEL[SETTINGS.LANGUAGE]);


	if SETTINGS.LANGUAGE == "GERMAN" or SETTINGS.LANGUAGE == "FRENCH" then
		btnBLeditSave:SetWidth(90);

		btnBLeditCancel:SetLeft(130);
		btnBLeditCancel:SetWidth(80);
	end


	btnBLeditSave.Click = function (sender, args)
		-- Save information
		SaveBlackList();
	end

	btnBLeditCancel.Click = function (sender, args)
		-- Close without saving.
		CloseEditBL();
	end

	wBLedit.Closing = function()
		-- Close without saving.
		CloseEditBL();
	end

	txtBLeditName.FocusGained = function (sender, args)
		if txtBLeditName:GetText() == _LANG.NAME[SETTINGS.LANGUAGE] then txtBLeditName:SetText("") end;
	end

	txtBLeditReason.FocusGained = function (sender, args)
		if txtBLeditReason:GetText() == _LANG.REASON[SETTINGS.LANGUAGE] then txtBLeditReason:SetText("") end;
	end

	SortBlacklist(blSortDropDown:GetText());

end


function EditSelectedBL(SELECTEDNODE)

	if SELECTEDNODE ~= nil then

		local CHILDCONTROLS = SELECTEDNODE:GetControls();
		local TEMPCHILD = CHILDCONTROLS:Get(1);

		if TEMPCHILD:GetText() ~= nil then
			SELBLNAME = TEMPCHILD:GetText();

			txtBLeditName:SetText(SELBLNAME);
			txtBLeditReason:SetText(_BLACKLIST[SELBLNAME].REASON);

			wBLedit:SetVisible(true);
			wBLedit:Activate();
		end
	else
		GAMessage(_LANG.MESSAGE05[SETTINGS.LANGUAGE]);
	end
end


function RemoveSelectedBL(SELECTEDNODE)

	if SELECTEDNODE ~= nil then

		local CHILDCONTROLS = SELECTEDNODE:GetControls();
		local TEMPCHILD = CHILDCONTROLS:Get(1);

		if TEMPCHILD:GetText() ~= nil then

			SELBLNAME = TEMPCHILD:GetText();

			-- Confirm removal first..
			tempMsg = Includes.MessageBox.Create(_LANG.MESSAGE06[SETTINGS.LANGUAGE] .. SELBLNAME .. _LANG.MESSAGE07[SETTINGS.LANGUAGE],"MBYESNO");
			tempMsg.Prompt = function ()
				if tempMsg:GetResponse() == "MBYES" then

					local TABLEINDEX = 1;

					for k,v in pairs(_BLACKLIST) do

						if k == SELBLNAME then
							GAMessage(_LANG.REMOVEDBLIST[SETTINGS.LANGUAGE] .. ": " .. k);
							break;
						else
							TABLEINDEX = TABLEINDEX + 1;
						end
					end

					_BLACKLIST[SELBLNAME] = nil;
					table.remove(_BLACKLIST,TABLEINDEX);
					rolls_RefreshFSList();
					RefreshLootList();

					SELECTEDBL = nil;
					SortBlacklist(blSortDropDown:GetText());

				end
			end
		end
	else
		GAMessage(_LANG.MESSAGE08[SETTINGS.LANGUAGE]);
	end
end


function SaveBlackList()

	if string.len(txtBLeditName:GetText()) > 0 and string.upper(txtBLeditName:GetText()) ~= _LANG.NAME[SETTINGS.LANGUAGE] then

		-- DToX Start
		local tempName;
		if SETTINGS.LANGUAGE == "RUSSIAN" then
			tempName = txtBLeditName:GetText(); -- Upper/lower isn't working for RU strings. Using raw input.
		else
			tempName = string.upper(string.sub(txtBLeditName:GetText(),1,1)) .. string.lower(string.sub(txtBLeditName:GetText(),2)); -- Plugin default
		end
		-- DToX End
		
		local tempReason = txtBLeditReason:GetText();

		local tempDate = Turbine.Engine.GetDate();
		local tempDay = tostring(tempDate.Day);
		local tempMonth = tostring(tempDate.Month);
		if string.len(tempDay) == 1 then tempDay = "0" .. tempDay end;
		if string.len(tempMonth) == 1 then tempMonth = "0" .. tempMonth end;

		local strDate = tempDay .. "/" .. tempMonth .. "/" .. tempDate.Year;

		local blExists = false;

		-- Check if the name already exists in the list.
		for k,v in pairs (_BLACKLIST) do

			if k == tempName then
				-- exists
				_BLACKLIST[k].REASON = tempReason;
				blExists = true;

				break
			end
		end

		if blExists == false then

			_BLACKLIST[tempName] = {["DATE"] = strDate, ["REASON"] = tempReason};
			GAMessage(tempName .. _LANG.MESSAGE09[SETTINGS.LANGUAGE]);
			RefreshLootList();
			rolls_RefreshFSList();

		end

		SELECTEDBL = nil;
		SortBlacklist(blSortDropDown:GetText());
		CloseEditBL();

		--[[

		_BLACKLIST =
			{
			["Galuhad"] =
				{
				["DATE"] = "12/11/2011";
				["REASON"] = "because..";
				};
			};

		]]

	end
end


function CloseEditBL()

	txtBLeditName:SetText(_LANG.NAME[SETTINGS.LANGUAGE]);
	txtBLeditReason:SetText(_LANG.REASON[SETTINGS.LANGUAGE]);
	wBLedit:SetVisible(false);

end


function FillBLTree()

	local SORT = blSortDropDown:GetText(); -- Organise by sort preference

	treeBlacklist:ClearItems(); -- Reset the list

	for k,v in pairs (_BL2) do

		local tempName = v;

		-- Main node -----------------------------------
		local tempNode = Turbine.UI.Control();
		tempNode:SetSize(360,83);
		tempNode:SetBackground(RESOURCEDIR.."Blacklist_Up_Normal.tga");
		tempNode:SetBlendMode(4);

		tempNode.MouseEnter = function (sender,args)
			if SELECTEDBL == tempNode then
				tempNode:SetBackground(RESOURCEDIR.."Blacklist_Over_Select.tga");
			else
				tempNode:SetBackground(RESOURCEDIR.."Blacklist_Up_Over.tga");
			end
		end

		tempNode.MouseLeave = function (sender,args)
			if SELECTEDBL == tempNode then
				tempNode:SetBackground(RESOURCEDIR.."Blacklist_Up_Select.tga");
			else
				tempNode:SetBackground(RESOURCEDIR.."Blacklist_Up_Normal.tga");
			end
		end

		tempNode.MouseClick = function (sender, args)

			local NODECOUNT = treeBlacklist:GetItemCount();



			for i=1, NODECOUNT do
				local CURNODE = treeBlacklist:GetItem(i);
				if CURNODE ~= tempNode then
					CURNODE:SetBackground(RESOURCEDIR.."Blacklist_Up_Normal.tga");
				end
			end

			if SELECTEDBL ~= tempNode then
				tempNode:SetBackground(RESOURCEDIR.."Blacklist_Over_Select.tga");
				SELECTEDBL = tempNode;
			else
				tempNode:SetBackground(RESOURCEDIR.."Blacklist_Up_Over.tga");
				SELECTEDBL = nil;
			end
		end

		local lblTempName = Turbine.UI.Label();
		lblTempName:SetParent(tempNode);
		lblTempName:SetPosition(10,3);
		lblTempName:SetSize(248,22);
		lblTempName:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		lblTempName:SetFont(HFONT);
		lblTempName:SetText(v);
		lblTempName:SetMouseVisible(false);

		local lblTempDate = Turbine.UI.Label();
		lblTempDate:SetParent(tempNode);
		lblTempDate:SetPosition(249,4);
		lblTempDate:SetSize(90,22);
		lblTempDate:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
		lblTempDate:SetFont(BFONT);
		lblTempDate:SetText(_BLACKLIST[v].DATE);
		lblTempDate:SetMouseVisible(false);

		local lblTempReason = Turbine.UI.Label();
		lblTempReason:SetParent(tempNode);
		lblTempReason:SetPosition(10,35);
		lblTempReason:SetSize(340,40);
		lblTempReason:SetFont(BFONT);
		lblTempReason:SetMultiline(true);
		lblTempReason:SetMouseVisible(false);
		lblTempReason:SetText(_BLACKLIST[v].REASON);

--~ 		lblTempName:SetBackColor(WHITE);
--~ 		lblTempName:SetForeColor(BLACK);
--~ 		lblTempReason:SetBackColor(WHITE);
--~ 		lblTempReason:SetForeColor(BLACK);

		treeBlacklist:AddItem(tempNode);

	end
end


function IsBlacklisted(PLAYERNAME)

	-- This function checks a player name to see if it's Blacklisted and returns true or false
	local blBlacklisted = false;

	for k,v in pairs(_BLACKLIST) do
		if k == PLAYERNAME then
			blBlacklisted = true;
			break;
		end
	end

	return blBlacklisted;
end


function SortBlacklist(ORDER)

	_BL2 = {};

	-- ORDER
	if ORDER == _LANG.AZ[SETTINGS.LANGUAGE] then

		-- A to Z
		table.foreach (_BLACKLIST, function (k) table.insert (_BL2, k) end );
		table.sort (_BL2);

	elseif ORDER == _LANG.ZA[SETTINGS.LANGUAGE] then

		-- Z to A
		table.foreach (_BLACKLIST, function (k) table.insert (_BL2, k) end );
		table.sort 	(_BL2,
					function (v1, v2)
					return v1 > v2
					end -- function
					)

	end

	FillBLTree();

end
