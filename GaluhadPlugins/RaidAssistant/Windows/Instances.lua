-- Instances window.
function DrawInstWindow()

	local tempWidth = 200;
	local tempHeight = 300;


	wInstParent = Turbine.UI.Lotro.Window();
	wInstParent:SetSize(tempWidth,tempHeight);
	wInstParent:SetPosition(SETTINGS.INSTANCES.X,SETTINGS.INSTANCES.Y);
	wInstParent:SetText(_LANG.InstWindowTitle[SETTINGS.LANGUAGE]);
	wInstParent:SetVisible(SETTINGS.INSTANCES.VISIBLE);

	Includes.Onscreen(wInstParent);




	wInstParent.Closing = function()
		SETTINGS.INSTANCES.VISIBLE = false;

		local lang = SETTINGS.LANGUAGE;
		local tempDir = RESOURCEDIR .. "/" .. lang .. "/";

		wMenuInst:SetBackground(tempDir .. "Inst_Up.jpg");
	end

	wInstParent.PositionChanged = function()

		SETTINGS.INSTANCES.X = wInstParent:GetLeft();
		SETTINGS.INSTANCES.Y = wInstParent:GetTop();

	end

end
