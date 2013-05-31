-- LFF window.
function DrawLFFWindow()

	local tempWidth = 200;
	local tempHeight = 300;


	wLFFParent = Turbine.UI.Lotro.Window();
	wLFFParent:SetSize(tempWidth,tempHeight);
	wLFFParent:SetPosition(SETTINGS.LFF.X,SETTINGS.LFF.Y);
	wLFFParent:SetText(_LANG.LFFWindowTitle[SETTINGS.LANGUAGE]);
	wLFFParent:SetVisible(SETTINGS.LFF.VISIBLE);

	Includes.Onscreen(wLFFParent);




	wLFFParent.Closing = function()
		SETTINGS.LFF.VISIBLE = false;

		local lang = SETTINGS.LANGUAGE;
		local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

		wMenuLFF:SetBackground(tempDir .. "LFF_Up.jpg");
	end

	wLFFParent.PositionChanged = function()

		SETTINGS.LFF.X = wLFFParent:GetLeft();
		SETTINGS.LFF.Y = wLFFParent:GetTop();

	end

end
