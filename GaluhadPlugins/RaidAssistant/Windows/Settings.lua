-- LFF window.
function DrawSettWindow()

	local tempWidth = 310;
	local tempHeight = 200;


	wSettParent = Turbine.UI.Lotro.Window();
	wSettParent:SetSize(tempWidth,tempHeight);
	wSettParent:SetPosition(SETTINGS.SETTWIN.X,SETTINGS.SETTWIN.Y);
	wSettParent:SetText(_LANG.SettWindowTitle[SETTINGS.LANGUAGE]);
	wSettParent:SetVisible(SETTINGS.SETTWIN.VISIBLE);

	Includes.Onscreen(wSettParent);


	lblLang = Turbine.UI.Label();
	lblLang:SetParent(wSettParent);
	lblLang:SetText("Language:");
	lblLang:SetPosition(50,62);
	lblLang:SetSize(80,17);

	-- Drop Down
	local langOpt = {"English", "Francais", "Deutsch", "Русский"};
	local curLanguage = "";

	if SETTINGS.LANGUAGE == "ENGLISH" then
		curLanguage = "English";
	elseif SETTINGS.LANGUAGE == "FRENCH" then
		curLanguage = "Francais";
	elseif SETTINGS.LANGUAGE == "GERMAN" then
		curLanguage = "Deutsch";
	elseif SETTINGS.LANGUAGE == "RUSSIAN" then
		curLanguage = "Русский";
	else
		curLanguage = "English";
	end

	local LangDropDown = Includes.DropDown.Create(langOpt,curLanguage);
	LangDropDown:SetParent(wSettParent);
	LangDropDown:SetPosition(120,60);
	LangDropDown:ApplyWidth(110);
	LangDropDown:SetVisible(true);
	LangDropDown:SetMenuEnabled(true); -- Need to disable until languages are translated

	LangDropDown.ItemChanged = function ()
		selectedItem = LangDropDown:GetText();
		if selectedItem == "English" then SETTINGS.LANGUAGE = "ENGLISH" end;
		if selectedItem == "Francais" then SETTINGS.LANGUAGE = "FRENCH" end;
		if selectedItem == "Deutsch" then SETTINGS.LANGUAGE = "GERMAN" end;
		if selectedItem == "Русский" then SETTINGS.LANGUAGE = "RUSSIAN" end;

	end





	wSettParent.Closing = function()
		SETTINGS.SETTWIN.VISIBLE = false;

		local lang = SETTINGS.LANGUAGE;
		local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

		wMenuSett:SetBackground(tempDir .. "Settings_Up.jpg");
	end

	wSettParent.PositionChanged = function()

		SETTINGS.SETTWIN.X = wSettParent:GetLeft();
		SETTINGS.SETTWIN.Y = wSettParent:GetTop();

	end

end
