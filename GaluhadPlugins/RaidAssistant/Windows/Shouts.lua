-- SHOUTS window.
function DrawShoutsWindow()

	local tempWidth = 400;
	local tempHeight = 400;


	wShoutParent = Turbine.UI.Lotro.Window();
	wShoutParent:SetSize(tempWidth,tempHeight);
	wShoutParent:SetPosition(SETTINGS.SHOUTS.X,SETTINGS.SHOUTS.Y);
	wShoutParent:SetText(_LANG.SHOUTWINTITLE[SETTINGS.LANGUAGE]);
	wShoutParent:SetVisible(SETTINGS.SHOUTS.VISIBLE);

	wShoutBack = Turbine.UI.Control();
	wShoutBack:SetParent(wShoutParent);
	wShoutBack:SetPosition(2,0);
	wShoutBack:SetSize(395,396);
	wShoutBack:SetBlendMode(4);
	wShoutBack:SetBackground(RESOURCEDIR.."Shouts_Back.tga");
	wShoutBack:SetMouseVisible(false);

	Includes.Onscreen(wShoutParent);

	chkShtShow = Turbine.UI.Lotro.CheckBox();
	chkShtShow:SetParent(wShoutParent);
	chkShtShow:SetPosition(20,40);
	chkShtShow:SetSize(200,17);
	chkShtShow:SetFont(BFONT);
	chkShtShow:SetText(" " .. _LANG.SHOUTSHOW[SETTINGS.LANGUAGE]);
	chkShtShow:SetChecked(SETTINGS.MINSHOUTS.SHOW);


	chkShtShow.CheckedChanged = function (sender, args)
		SETTINGS.MINSHOUTS.SHOW = chkShtShow:IsChecked();
		ShowMiniShouts();
	end

	chkShtShowLead = Turbine.UI.Lotro.CheckBox();
	chkShtShowLead:SetParent(wShoutParent);
	chkShtShowLead:SetPosition(20,60);
	chkShtShowLead:SetSize(200,17);
	chkShtShowLead:SetFont(BFONT);
	chkShtShowLead:SetText(" " .. _LANG.SHOUTSHOWLEAD[SETTINGS.LANGUAGE]);
	chkShtShowLead:SetChecked(SETTINGS.MINSHOUTS.SHOWLEAD);


	if chkShtShowLead:IsChecked() == true then chkShtShow:SetEnabled(false) end;

	chkShtShowLead.CheckedChanged = function (sender, args)
		local SHOWLEAD = chkShtShowLead:IsChecked();
		SETTINGS.MINSHOUTS.SHOWLEAD = SHOWLEAD;
		if SHOWLEAD == true then
			chkShtShow:SetChecked(false);
			chkShtShow:SetEnabled(false);
			SETTINGS.MINSHOUTS.SHOW = false;
		else
			chkShtShow:SetEnabled(true);
		end
		ShowMiniShouts();
	end

	local lblFilter = Turbine.UI.Label();
	lblFilter:SetParent(wShoutParent);
	lblFilter:SetText(_LANG.FILTER[SETTINGS.LANGUAGE] .. ":");
	lblFilter:SetSize(170,18);
	lblFilter:SetTextAlignment(Turbine.UI.ContentAlignment.BottomLeft);
	lblFilter:SetPosition(212,38);

	-- Drop Down
	ddShoutFilter = Includes.DropDown.Create();
	ddShoutFilter:SetParent(wShoutParent);
	ddShoutFilter:SetPosition(210,60);
	ddShoutFilter:ApplyWidth(170);
	ddShoutFilter:SetVisible(true);
	ddShoutFilter:SetMenuEnabled(true);

	ddShoutFilter.ItemChanged = function ()
		-- Filter by selection
		UpdateShouts();
	end


	lstShouts = Turbine.UI.ListBox();
	lstShouts:SetParent(wShoutParent);
	lstShouts:SetSize(wShoutParent:GetWidth()-48,wShoutParent:GetHeight()-140);
	lstShouts:SetPosition(20,90);
	--lstShouts:SetBackColor(WHITE);

	ShoutScroll = Turbine.UI.Lotro.ScrollBar();
	ShoutScroll:SetParent(wShoutParent);
	ShoutScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	ShoutScroll:SetSize(8,lstShouts:GetHeight());
	ShoutScroll:SetPosition(lstShouts:GetLeft() + lstShouts:GetWidth(),lstShouts:GetTop());
	ShoutScroll:SetVisible(false);
	ShoutScroll:SetZOrder(200000);
	lstShouts:SetVerticalScrollBar(ShoutScroll);


	local BUTTONTOP = lstShouts:GetTop() + lstShouts:GetHeight() + 10;

	ShtAddBtn = Turbine.UI.Lotro.Button();
	ShtAddBtn:SetParent(wShoutParent);
	ShtAddBtn:SetText(_LANG.ADD[SETTINGS.LANGUAGE]);
	ShtAddBtn:SetPosition(60,BUTTONTOP);
	ShtAddBtn:SetWidth(80);

	ShtAddBtn.Click = function (sender, args)
		editShout();
	end

	ShtRemoveBtn = Turbine.UI.Lotro.Button();
	ShtRemoveBtn:SetParent(wShoutParent);
	ShtRemoveBtn:SetText(_LANG.REMOVE[SETTINGS.LANGUAGE]);
	ShtRemoveBtn:SetPosition(160,BUTTONTOP);
	ShtRemoveBtn:SetWidth(80);

	ShtRemoveBtn.Click = function (sender, args)

		RemoveShout(SELECTEDSHOUT);

	end

	ShtEditBtn = Turbine.UI.Lotro.Button();
	ShtEditBtn:SetParent(wShoutParent);
	ShtEditBtn:SetText(_LANG.EDIT[SETTINGS.LANGUAGE]);
	ShtEditBtn:SetPosition(260,BUTTONTOP);
	ShtEditBtn:SetWidth(80);

	ShtEditBtn.Click = function (sender,args)

		editShout(SELECTEDSHOUT);

	end


	if SETTINGS.LANGUAGE == "GERMAN" then
		ShtAddBtn:SetLeft(20);
		ShtAddBtn:SetWidth(90);

		ShtRemoveBtn:SetLeft(120);
		ShtRemoveBtn:SetWidth(80);

		ShtEditBtn:SetLeft(210);
		ShtEditBtn:SetWidth(80);
	end


	wShoutParent.Closing = function()
		SETTINGS.SHOUTS.VISIBLE = false;

		local lang = SETTINGS.LANGUAGE;
		local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

		wMenuShouts:SetBackground(tempDir .. "Shouts_Up.jpg");
	end

	wShoutParent.PositionChanged = function()

		SETTINGS.SHOUTS.X = wShoutParent:GetLeft();
		SETTINGS.SHOUTS.Y = wShoutParent:GetTop();

	end

	DrawMiniShoutsWin();
	UpdateShoutDropDowns();
	UpdateShouts();

end


function UpdateShoutDropDowns()

	local _SHOUTFILTER = {};
	table.insert(_SHOUTFILTER,_LANG.ALL[SETTINGS.LANGUAGE]);


	-- Sort through all the _SHOUTS to check each category
	for k,v in pairs (_SHOUTS) do

		local TEMPCAT = _SHOUTS[k].CAT;
		local blSHOUTEXISTS = false;

		-- Check if this category exists in _SHOUTFILTER
		-- If it doesn't then add it.

		for a,b in pairs (_SHOUTFILTER) do
			if b == TEMPCAT then -- category found in the table, no need to add.
				blSHOUTEXISTS = true;
				break;
			end;
		end

		if blSHOUTEXISTS == false then
			table.insert(_SHOUTFILTER,TEMPCAT);
		end
	end

	-- Update the drop downs with the new categories.
	local shoutFilters = ddShoutFilter:GetItemList(); -- Gets the item list so it can be modified
	local minShoutFilters = ddMiniShoutFilter:GetItemList();

	shoutFilters:Clear();
	minShoutFilters:Clear();

	for k,v in pairs (_SHOUTFILTER) do

		local myTempItem = Turbine.UI.MenuItem(v);
		shoutFilters:Add(myTempItem);
		minShoutFilters:Add(myTempItem);

	end

	ddShoutFilter:SetLabel(_LANG.ALL[SETTINGS.LANGUAGE]);
	ddMiniShoutFilter:SetLabel(_LANG.ALL[SETTINGS.LANGUAGE]);

end


function UpdateEditShoutDropDown(ddNewShoutCat,NEWCATEGORY)

	local _SHOUTFILTER = {};
	table.insert(_SHOUTFILTER,_LANG.GENERAL[SETTINGS.LANGUAGE]);


	-- Sort through all the _SHOUTS to check each category
	for k,v in pairs (_SHOUTS) do

		local TEMPCAT = _SHOUTS[k].CAT;
		local blSHOUTEXISTS = false;

		-- Check if this category exists in _SHOUTFILTER
		-- If it doesn't then add it.

		for a,b in pairs (_SHOUTFILTER) do
			if b == TEMPCAT then -- category found in the table, no need to add.
				blSHOUTEXISTS = true;
				break;
			end;
		end

		if blSHOUTEXISTS == false then
			table.insert(_SHOUTFILTER,TEMPCAT);
		end
	end

	if NEWCATEGORY ~= nil then table.insert(_SHOUTFILTER,NEWCATEGORY) end;

	table.insert(_SHOUTFILTER,".. " .. _LANG.NEWCAT[SETTINGS.LANGUAGE] .. " ..");

	-- Update the drop downs with the new categories.
	local shoutFilters = ddNewShoutCat:GetItemList(); -- Gets the item list so it can be modified

	shoutFilters:Clear();

	for k,v in pairs (_SHOUTFILTER) do

		local myTempItem = Turbine.UI.MenuItem(v);
		shoutFilters:Add(myTempItem);

	end

	ddNewShoutCat:SetLabel(_LANG.GENERAL[SETTINGS.LANGUAGE]);

end


function DrawMiniShoutsWin()

	-- Mini shouts window
	wMinShouts = Turbine.UI.Window();
	wMinShouts:SetSize(SETTINGS.MINSHOUTS.WIDTH,SETTINGS.MINSHOUTS.HEIGHT);
	wMinShouts:SetPosition(SETTINGS.MINSHOUTS.X,SETTINGS.MINSHOUTS.Y);
	wMinShouts:SetBackColor(clrSHOUTOVER);
	wMinShouts:SetOpacity(0.1);
	wMinShouts:SetVisible(false);

	Includes.Onscreen(wMinShouts);

	-- Drop Down
	ddMiniShoutFilter = Includes.DropDown.Create();
	ddMiniShoutFilter:SetParent(wMinShouts);
	ddMiniShoutFilter:SetPosition(5,9);
	ddMiniShoutFilter:ApplyWidth(170);
	ddMiniShoutFilter:SetTransparency(0.1);
	ddMiniShoutFilter:SetVisible(true);
	ddMiniShoutFilter:SetMenuEnabled(true);

	ddMiniShoutFilter.ItemChanged = function ()
		-- Filter by selection
		UpdateMiniShouts();
	end


	cMinShoutRepos=Turbine.UI.Window();
	cMinShoutRepos:SetParent(wMinShouts);
	cMinShoutRepos:SetSize(32,32);
	cMinShoutRepos:SetPosition(wMinShouts:GetWidth()-32,0);
	cMinShoutRepos:SetBackground(0x410000DD)
	cMinShoutRepos:SetStretchMode(2);
	cMinShoutRepos:SetOpacity(0.2);
	cMinShoutRepos:SetVisible(true);
	cMinShoutRepos:SetMouseVisible(true);
	cMinShoutRepos:SetZOrder(1000);


	wMinShouts.MouseEnter = function (sender, args)

		wMinShouts:SetOpacity(0.8);
		ddMiniShoutFilter:SetTransparency(0.9);

	end

	wMinShouts.MouseLeave = function (sender, args)

		wMinShouts:SetOpacity(0.2);
		ddMiniShoutFilter:SetTransparency(0.1);

	end

	cMinShoutRepos.MouseEnter = function (sender, args)

		cMinShoutRepos:SetOpacity(0.85);

	end

	cMinShoutRepos.MouseLeave = function (sender, args)

		cMinShoutRepos:SetOpacity(0.1);

	end

	cMinShoutRepos.MouseDown = function (sender, args)
		blDRAGGING = true;
		relX = args.X + cMinShoutRepos:GetLeft();
		relY = args.Y + cMinShoutRepos:GetTop();
	end

	cMinShoutRepos.MouseUp = function (sender, args)
		blDRAGGING = false;
	end

	cMinShoutRepos.MouseMove = function (sender, args)
		if blDRAGGING == true then
			local scX = Turbine.UI.Display.GetMouseX();
			local scY = Turbine.UI.Display.GetMouseY();
			SETTINGS.MINSHOUTS.X = scX - relX;
			SETTINGS.MINSHOUTS.Y = scY - relY;

			wMinShouts:SetPosition(SETTINGS.MINSHOUTS.X,SETTINGS.MINSHOUTS.Y);
			Includes.Onscreen(wMinShouts);
		end

	end


	lstMiniShouts = Turbine.UI.ListBox();
	lstMiniShouts:SetParent(wMinShouts);
	lstMiniShouts:SetSize(wMinShouts:GetWidth()-18,wMinShouts:GetHeight()-40);
	lstMiniShouts:SetPosition(5,35);
	--lstMiniShouts:SetBackColor(WHITE);

	MiniShoutScroll = Turbine.UI.Lotro.ScrollBar();
	MiniShoutScroll:SetParent(wMinShouts);
	MiniShoutScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	MiniShoutScroll:SetSize(8,lstMiniShouts:GetHeight());
	MiniShoutScroll:SetPosition(lstMiniShouts:GetLeft() + lstMiniShouts:GetWidth(),lstMiniShouts:GetTop());
	MiniShoutScroll:SetVisible(false);
	MiniShoutScroll:SetZOrder(200000);
	lstMiniShouts:SetVerticalScrollBar(MiniShoutScroll);


	cMinResize=Turbine.UI.Window();
	cMinResize:SetSize(32,32);
	cMinResize:SetBackground(0x41007e20)
	cMinResize:SetStretchMode(2);
	cMinResize:SetVisible(false);
	cMinResize:SetMouseVisible(false);
	cMinResize:SetZOrder(1000);

	wTransResize = Turbine.UI.Window()
	wTransResize:SetParent(wMinShouts);
	wTransResize:SetSize(SHOUTRESIZECTRL,SHOUTRESIZECTRL);
	wTransResize:SetPosition(wMinShouts:GetWidth()-SHOUTRESIZECTRL,wMinShouts:GetHeight()-SHOUTRESIZECTRL);
	wTransResize:SetBackColor(Turbine.UI.Color(0,0,0,0));
	wTransResize:SetZOrder(999);
	wTransResize:SetVisible(true);

	local blMinResizing = false;
	local minResizeOrgX = 0;
	local minResizeOrgY = 0;
	local initWidth = 0;
	local initHeight = 0;

	wTransResize.MouseEnter = function (sender, args)

		local curX = Turbine.UI.Display.GetMouseX();
		local curY = Turbine.UI.Display.GetMouseY();

		cMinResize:SetPosition(curX-(cMinResize:GetWidth()/2),curY-(cMinResize:GetHeight()/2));
		cMinResize:SetVisible(true);

	end

	wTransResize.MouseLeave = function (sender, args)

		if blMinResizing == false then cMinResize:SetVisible(false) end;

	end

	wTransResize.MouseDown = function (sender, args)

		blMinResizing = true;
		minResizeOrgX = Turbine.UI.Display.GetMouseX();
		minResizeOrgY = Turbine.UI.Display.GetMouseY();
		initWidth = wMinShouts:GetWidth();
		initHeight = wMinShouts:GetHeight();

	end

	wTransResize.MouseUp = function (sender, args)

		blMinResizing = false;
		cMinResize:SetVisible(false)

	end

	wTransResize.MouseMove = function (sender, args)

		if blMinResizing == true then

			-- Resize main win.. minResize(newWidth)
			local curX = Turbine.UI.Display.GetMouseX();
			local curY = Turbine.UI.Display.GetMouseY();
			local transWinX,transWinY = wTransResize:PointToScreen(x,y);

			local ResizeArrowTop = curY-(cMinResize:GetHeight()/2);

			if ResizeArrowTop < (transWinY-12) then ResizeArrowTop = transWinY-12 end;
			if ResizeArrowTop > (transWinY+2) then ResizeArrowTop = transWinY+2 end;

			cMinResize:SetTop(ResizeArrowTop);

			local widthVar = curX-minResizeOrgX;
			local heightVar = curY-minResizeOrgY;

			ResizeMiniShouts(initWidth+widthVar,initHeight+heightVar);



			cMinResize:SetLeft(transWinX-(cMinResize:GetWidth()/2));

		else

			local curX = Turbine.UI.Display.GetMouseX();
			local curY = Turbine.UI.Display.GetMouseY();
			local transWinX,transWinY = wTransResize:PointToScreen(x,y);

			local ResizeArrowTop = curY-(cMinResize:GetHeight()/2);

			if ResizeArrowTop < (transWinY-12) then ResizeArrowTop = transWinY-12 end;
			if ResizeArrowTop > (transWinY+2) then ResizeArrowTop = transWinY+2 end;

			cMinResize:SetTop(ResizeArrowTop);

		end

	end

	UpdateMiniShouts();

	ShowMiniShouts();

end


function UpdateMiniShouts()

	lstMiniShouts:ClearItems();

	-- This function updates the mini shouts list
	local tempFILTER = ddMiniShoutFilter:GetText();

	local tempPartySize, TEMPMEMBER = Includes.GetGroup();

	--Turbine.Shell.WriteLine("From MiniShouts: tempPartySize = " .. tempPartySize);

	-- Add to list only those in _SHOUTS where _SHOUTS[i].CAT == tempFILTER
	for k,v in pairs (_SHOUTS) do

		if _SHOUTS[k].CAT == tempFILTER or tempFILTER == _LANG.ALL[SETTINGS.LANGUAGE] then

			-- Add to list

			local shoutHolder = Turbine.UI.Control();
			shoutHolder:SetSize(lstMiniShouts:GetWidth(),20);


			local shoutQS = Turbine.UI.Lotro.Quickslot();
			shoutQS:SetParent(shoutHolder);
			shoutQS:SetSize(16,16);
			shoutQS:SetPosition(0,2);
			shoutQS:SetZOrder(1);
			shoutQS:SetVisible(true);

			shoutQSICON = Turbine.UI.Control();
			shoutQSICON:SetSize(16,16);
			shoutQSICON:SetParent(shoutHolder);
			shoutQSICON:SetPosition(shoutQS:GetLeft(),shoutQS:GetTop());
			shoutQSICON:SetBackground(RESOURCEDIR.."Shout.tga");
			shoutQSICON:SetMouseVisible(false);
			shoutQSICON:SetZOrder(10000);

			local tempCHANNEL = "/raidshout"; -- Will take from settings when added.

			GROUPLEADER = Includes.GetLeader();

			if tempPartySize > 6 then
				if string.len(_SHOUTS[k].MESSAGE) > MAXRAIDSHOUTLENGTH or MYNAME ~= GROUPLEADER then
					tempCHANNEL = "/ra";
				end
			else
				tempCHANNEL = "/f";
			end


			local tempString = tempCHANNEL .. " " .. _SHOUTS[k].MESSAGE;
			-- DToX Start
			if SETTINGS.LANGUAGE == "RUSSIAN" then -- Shamanism
				local sc = Turbine.UI.Lotro.Shortcut(Turbine.UI.Lotro.ShortcutType.Alias,'');
				sc:SetData(tempString);
				shoutQS:SetShortcut(sc);
			else
				shoutQS:SetShortcut(Turbine.UI.Lotro.Shortcut(Turbine.UI.Lotro.ShortcutType.Alias, tempString)); -- Plugin default
			end
			-- DToX End

			if tempCHANNEL == "/raidshout" then -- As raid shouts aren't displayed to the sender, send it to the chat window so they can be sure they sent the right one
				shoutQS.MouseClick = function (sender,args)
					Turbine.Shell.WriteLine(_SHOUTS[k].MESSAGE);
				end
			end


			local shoutLabel = Turbine.UI.Label();
			shoutLabel:SetParent(shoutHolder);
			shoutLabel:SetSize(shoutHolder:GetWidth()-19,16);
			shoutLabel:SetPosition(19,2);
			shoutLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
			shoutLabel:SetMultiline(false);
			shoutLabel:SetText(_SHOUTS[k].MESSAGE);
			shoutLabel:SetMouseVisible(false);


			lstMiniShouts:AddItem(shoutHolder);

		end
	end
end


function ShowMiniShouts()

	local LEADERONLY = chkShtShowLead:IsChecked();
	local SHOWSHOUTS = chkShtShow:IsChecked();
	local ISLEADER = false;

	GROUPLEADER = Includes.GetLeader();


	if MYNAME == GROUPLEADER then ISLEADER = true end;

	if SHOWSHOUTS == true or (LEADERONLY == true and ISLEADER == true) then
		-- Show mini shouts window
		wMinShouts:SetVisible(true);
	else
		-- Hide mini shouts window
		wMinShouts:SetVisible(false);
	end
end


function UpdateShouts()
	-- This function will update the shouts windows when shouts are added/removed/editted
	lstShouts:ClearItems();

	local tempFILTER = ddShoutFilter:GetText();

	for k,v in pairs (_SHOUTS) do

		if _SHOUTS[k].CAT == tempFILTER or tempFILTER == _LANG.ALL[SETTINGS.LANGUAGE] then

			local _CURTABLE = v;

			local shoutHolder = Turbine.UI.Control();
			shoutHolder:SetSize(lstShouts:GetWidth(),20);

			local shoutBack = Turbine.UI.Control();
			shoutBack:SetParent(shoutHolder);
			shoutBack:SetSize(shoutHolder:GetWidth(),18);
			shoutBack:SetBackColor(SHOUTNORM);

			shoutBack.MouseEnter = function(sender,args)
				if SELECTEDSHOUT ~= k then
					shoutBack:SetBackColor(SHOUTOVER);
				end
			end

			shoutBack.MouseLeave = function(sender,args)
				if SELECTEDSHOUT ~= k then
					shoutBack:SetBackColor(SHOUTNORM);
				end
			end

			shoutBack.MouseClick = function(sender,args)
				if SELECTEDSHOUT ~= k then
					ReColourList();
					shoutBack:SetBackColor(SHOUTSEL);
					SELECTEDSHOUT = k;
				else
					shoutBack:SetBackColor(SHOUTOVER);
					SELECTEDSHOUT = 0;
				end
			end


			local shoutLabel = Turbine.UI.Label();
			shoutLabel:SetParent(shoutHolder);
			shoutLabel:SetSize(shoutHolder:GetWidth()-8,16);
			shoutLabel:SetPosition(4,3);
			shoutLabel:SetText(_CURTABLE.MESSAGE);
			shoutLabel:SetMultiline(false);
			shoutLabel:SetMouseVisible(false);

			lstShouts:AddItem(shoutHolder);

		end

	end

	UpdateMiniShouts();

end


function ReColourList()

	-- This function adjusts the back colours for the shouts list back to the default colour.
	for i=1, lstShouts:GetItemCount() do
		local tempItem = lstShouts:GetItem(i);
		local tempBack = tempItem:GetControls():Get(1);
		tempBack:SetBackColor(SHOUTNORM);
	end

end


function editShout(SHOUT)

	local SHOUTSELCAT = "";

	local shoutEditWin = Turbine.UI.Lotro.Window();
	shoutEditWin:SetSize(500,220);
	shoutEditWin:SetPosition((SCREENWIDTH/2)-250,(SCREENHEIGHT/2)-110);
	shoutEditWin:SetVisible(false);

	shoutEditWin.Closing = function (sender,args)
		shoutEditWin = nil;
	end

	local wShoutNewBack = Turbine.UI.Control();
	wShoutNewBack:SetParent(shoutEditWin);
	wShoutNewBack:SetPosition(1,-3);
	wShoutNewBack:SetSize(499,221);
	wShoutNewBack:SetBlendMode(4);
	wShoutNewBack:SetBackground(RESOURCEDIR.."Shouts_New_Back.tga");
	wShoutNewBack:SetMouseVisible(false);

	local lblLENGTH = Turbine.UI.Label();
	lblLENGTH:SetParent(shoutEditWin);
	lblLENGTH:SetText("0/" .. MAXSHOUTLENGTH);
	lblLENGTH:SetSize(50,20);
	lblLENGTH:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	lblLENGTH:SetPosition(20,43);

	local lblCategory = Turbine.UI.Label();
	lblCategory:SetParent(shoutEditWin);
	lblCategory:SetText(_LANG.CATEGORY[SETTINGS.LANGUAGE] .. ":");
	lblCategory:SetSize(100,20);
	lblCategory:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
	lblCategory:SetPosition(200,43);

	local editfield = Turbine.UI.Lotro.TextBox();
	editfield:SetParent(shoutEditWin);
	editfield:SetPosition(10,70);
	editfield:SetSize(shoutEditWin:GetWidth()-20,110);
	editfield:SetFont(EDITFONT);
	editfield:SetSelectable(true);
	editfield:SetMultiline(true);

	editfield.FocusGained = function (sender, args)
		editfield:SetWantsUpdates(true);
	end

	editfield.FocusLost = function (sender, args)
		editfield:SetWantsUpdates(false);
	end

	editfield.Update = function (sender, args)

		-- This function is only active when the text box has the focus..
		-- The purpose of this is to restrict the length of the text to 384 characters (the max the chat channels can send).
		local tempSTRING = editfield:GetText();
		local sLen = string.len(tempSTRING);


		if sLen > MAXRAIDSHOUTLENGTH then lblLENGTH:SetForeColor(RED) else lblLENGTH:SetForeColor(WHITE) end;


		if sLen > MAXSHOUTLENGTH then
			-- Message to long, clip the end
			editfield:SetText(string.sub(tempSTRING,1,MAXSHOUTLENGTH));
		end

		lblLENGTH:SetText(tostring(sLen) .. "/" .. MAXSHOUTLENGTH);

	end


	local btnshoutsave = Turbine.UI.Lotro.Button();
	btnshoutsave:SetParent(shoutEditWin);
	btnshoutsave:SetText(_LANG.SAVE[SETTINGS.LANGUAGE]);
	btnshoutsave:SetWidth(80);
	btnshoutsave:SetPosition(365,185);


	if SETTINGS.LANGUAGE == "GERMAN"  or SETTINGS.LANGUAGE == "FRENCH" then
		btnshoutsave:SetWidth(120);
		btnshoutsave:SetLeft(345);
	end


	local btnshoutTarget = Turbine.UI.Lotro.Button();
	btnshoutTarget:SetParent(shoutEditWin);
	btnshoutTarget:SetText(_LANG.TARGET[SETTINGS.LANGUAGE]);
	btnshoutTarget:SetWidth(80);
	btnshoutTarget:SetPosition(60,185);

	btnshoutTarget.Click = function(sender,args)
		editfield:InsertText(_LANG.TARGET[SETTINGS.LANGUAGE]);
	end


	-- Drop Down
	local ddNewShoutCat = Includes.DropDown.Create();
	ddNewShoutCat:SetParent(shoutEditWin);
	ddNewShoutCat:SetPosition(310,42);
	ddNewShoutCat:ApplyWidth(170);
	ddNewShoutCat:SetVisible(true);
	ddNewShoutCat:SetMenuEnabled(true);

	ddNewShoutCat.ItemChanged = function ()
		-- Check if user selected to create a new category.
		if ddNewShoutCat:GetText() == (".. " .. _LANG.NEWCAT[SETTINGS.LANGUAGE] .. " ..") then
			PromptNewShoutCat(ddNewShoutCat);
		end
	end

	UpdateEditShoutDropDown(ddNewShoutCat);

	-- Logic ----------------------------------------------
	if SHOUT == nil then
		shoutEditWin:SetText(_LANG.SHOUTADD[SETTINGS.LANGUAGE]); -- Add Shout
		shoutEditWin:SetVisible(true);
		editfield:Focus();

		btnshoutsave.Click = function (sender,args)

			-- Validate, then save if valid
			if ValidateShout(editfield:GetText()) == true then

				-- loop to find first free position
				local i = 1;
				while type(_SHOUTS[i]) == 'table' do
					i = i + 1;
				end

				_SHOUTS[i] = {
					["CAT"] = ddNewShoutCat:GetText();
					["MESSAGE"] = editfield:GetText();
				};

				UpdateShoutDropDowns();
				UpdateShouts();
				shoutEditWin:Close();

			end

		end
	else

		if SHOUT ~= nil and SHOUT ~= 0 then

			shoutEditWin:SetText(_LANG.SHOUTEDIT[SETTINGS.LANGUAGE]); -- Edit Shout
			shoutEditWin:SetVisible(true);
			editfield:Focus();

			-- Get the Message
			editfield:SetText(_SHOUTS[SHOUT].MESSAGE);
			lblLENGTH:SetText(tostring(string.len(_SHOUTS[SHOUT].MESSAGE)  .. "/" .. MAXSHOUTLENGTH));
			if string.len(_SHOUTS[SHOUT].MESSAGE) > MAXRAIDSHOUTLENGTH then lblLENGTH:SetForeColor(RED) else lblLENGTH:SetForeColor(WHITE) end;

			ddNewShoutCat:SetLabel(_SHOUTS[SHOUT].CAT);

			btnshoutsave.Click = function (sender,args)

				-- Validate, then save if valid
				if ValidateShout(editfield:GetText()) == true then

					-- Saves over the current selected
					_SHOUTS[SHOUT] = {
						["CAT"] = ddNewShoutCat:GetText();
						["MESSAGE"] = editfield:GetText();
					};

					UpdateShoutDropDowns();
					UpdateShouts();
					shoutEditWin:Close();

				end
			end
		end
	end

end


function PromptNewShoutCat(DROPDOWNHANDLE)

	-- This function is called when the user selects from the dropdown to create a new category.
	local tempCATEGORY = "";

	-- Create pop-up window prompting for user to enter a category name:
	wShoutCatPrompt = Turbine.UI.Lotro.Window();
	wShoutCatPrompt:SetSize(300,120);
	wShoutCatPrompt:SetPosition((SCREENWIDTH/2)-(wShoutCatPrompt:GetWidth()/2),(SCREENHEIGHT/2)-(wShoutCatPrompt:GetHeight()/2));
	wShoutCatPrompt:SetText(_LANG.NEWCAT[SETTINGS.LANGUAGE]);
	wShoutCatPrompt:SetVisible(true);

	wShoutCatPrompt.Closed = function (sender,args)
		NewShoutCat(DROPDOWNHANDLE,tempCATEGORY);
		wShoutCatPrompt = nil;
	end

	local txtShoutCat = Turbine.UI.Lotro.TextBox();
	txtShoutCat:SetParent(wShoutCatPrompt);
	txtShoutCat:SetPosition(30,40);
	txtShoutCat:SetSize(wShoutCatPrompt:GetWidth()-60,30);
	txtShoutCat:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	txtShoutCat:SetFont(EDITFONT);
	txtShoutCat:SetSelectable(true);
	txtShoutCat:SetMultiline(false);


	txtShoutCat.FocusGained = function (sender, args)
		txtShoutCat:SetWantsUpdates(true);
	end

	txtShoutCat.FocusLost = function (sender, args)
		txtShoutCat:SetWantsUpdates(false);
	end

	txtShoutCat.Update = function (sender, args)

		-- The purpose of this is to restrict the length of the text
		local tempSTRING = txtShoutCat:GetText();
		local sLen = string.len(tempSTRING);


		if sLen > MAXCATLENGTH then
			-- Message to long, clip the end
			txtShoutCat:SetText(string.sub(tempSTRING,1,MAXCATLENGTH));
		end

	end


	local btnShoutCatSave = Turbine.UI.Lotro.Button();
	btnShoutCatSave:SetParent(wShoutCatPrompt);
	btnShoutCatSave:SetText(_LANG.SAVE[SETTINGS.LANGUAGE]);
	btnShoutCatSave:SetWidth(80);
	btnShoutCatSave:SetPosition(60,80);

	btnShoutCatSave.MouseClick = function (sender,args)
		tempCATEGORY = txtShoutCat:GetText();
		wShoutCatPrompt:Close();
	end

	local btnShoutCatCancel = Turbine.UI.Lotro.Button();
	btnShoutCatCancel:SetParent(wShoutCatPrompt);
	btnShoutCatCancel:SetText(_LANG.CANCEL[SETTINGS.LANGUAGE]);
	btnShoutCatCancel:SetWidth(80);
	btnShoutCatCancel:SetPosition(160,80);

	btnShoutCatCancel.MouseClick = function (sender,args)
		tempCATEGORY = "";
		wShoutCatPrompt:Close();
	end

end


function NewShoutCat(DROPDOWNHANDLE,NEWCATEGORY)

	if NEWCATEGORY ~= nil and NEWCATEGORY ~= "" then
		UpdateEditShoutDropDown(DROPDOWNHANDLE,NEWCATEGORY);
		DROPDOWNHANDLE:SetLabel(NEWCATEGORY);
	else
		DROPDOWNHANDLE:SetLabel(_LANG.GENERAL[SETTINGS.LANGUAGE]);
	end

end


function ResizeMiniShouts(newWidth,newHeight)

	-- Width settings
	local maxWidth = Turbine.UI.Display.GetWidth();
	maxWidth = maxWidth - wMinShouts:GetLeft()-20;

	if newWidth < 250 then newWidth = 250 end;
	if newWidth > maxWidth then newWidth = maxWidth end;

	-- Height settings
	local maxHeight = Turbine.UI.Display.GetHeight();
	maxHeight = maxHeight - wMinShouts:GetTop()-20;

	if newHeight < 100 then newHeight = 100 end;
	if newHeight > maxHeight then newHeight = maxHeight end;


	-- Resize & reposition controls.
	wMinShouts:SetSize(newWidth,newHeight);
	lstMiniShouts:SetSize(wMinShouts:GetWidth()-18,wMinShouts:GetHeight()-40);
	MiniShoutScroll:SetSize(8,lstMiniShouts:GetHeight());
	MiniShoutScroll:SetPosition(lstMiniShouts:GetLeft() + lstMiniShouts:GetWidth(),lstMiniShouts:GetTop());
	wTransResize:SetPosition(wMinShouts:GetWidth()-SHOUTRESIZECTRL,wMinShouts:GetHeight()-SHOUTRESIZECTRL);
	cMinShoutRepos:SetPosition(wMinShouts:GetWidth()-32,0);

	local tempLISTCOUNT = lstMiniShouts:GetItemCount();

	for i=1, tempLISTCOUNT do
		local tempLISTCONTROLS = lstMiniShouts:GetItem(i);
		tempLISTCONTROLS:SetWidth(lstMiniShouts:GetWidth());

		local tempLISTLABEL = tempLISTCONTROLS:GetControls():Get(3);
		tempLISTLABEL:SetWidth(tempLISTCONTROLS:GetWidth()-19);
	end

	-- Save new dimensions into settings
	SETTINGS.MINSHOUTS.WIDTH = newWidth;
	SETTINGS.MINSHOUTS.HEIGHT = newHeight;

end


function RemoveShout(SHOUT)

	if SHOUT ~= nil and SHOUT ~= 0 then

		-- This function removes the selected SHOUT from the database.
		local tempMsg = Includes.MessageBox.Create(_LANG.DELETESHOUT[SETTINGS.LANGUAGE] .. ":\n" .. _SHOUTS[SHOUT].MESSAGE,"MBYESNO");
		tempMsg.Prompt = function ()
			if tempMsg:GetResponse() == "MBYES" then
				-- User clicked yes, so remove from database and update.
				_SHOUTS[SHOUT] = nil;
				UpdateShoutDropDowns();
				UpdateShouts();
			end
		end
	end
end


function ValidateShout(SHOUT)

	-- Checks the shout, if it's valid it returns true, if not it returns false.
	local blVALID = true;

	if SHOUT == "" then
		blVALID = false;
	end



	--------------------------------------------------------------------------------------
	-- Message displayed to warn user ----------------------------------------------------
	if blVALID == false then
		local tempMsg = Includes.MessageBox.Create(_LANG.INVALIDSHOUT[SETTINGS.LANGUAGE]);
	end

	return blVALID;
end

