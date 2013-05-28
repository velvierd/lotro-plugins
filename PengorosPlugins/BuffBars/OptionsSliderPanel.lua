import "Turbine.UI";

OptionsSliderPanel = class(Turbine.UI.ListBox);

OptionsSliderPanel.Border = 1;
OptionsSliderPanel.Background = 2;
OptionsSliderPanel.Font = 3;
OptionsSliderPanel.Outline = 4;

local holder = function(parent, height)
    local container = Turbine.UI.Control();
    container:SetSize(400, height);
    parent:AddItem(container);
    return container;
end

function OptionsSliderPanel:Constructor()
    Turbine.UI.ListBox.Constructor(self);

    self.current = nil;
    self:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self:SetMaxItemsPerLine(1);
    
    local line = holder(self, 35);
    self.sliderTitle = PengorosPlugins.UI.PanelDivider();
    self.sliderTitle:SetParent(line);
    self.sliderTitle:SetText(L["Effect Sliders"]);
    self.sliderTitle:SetSize(400, 30);
    
    line = holder(self, 30);
    self.sliderLabel = PengorosPlugins.UI.Label();
    self.sliderLabel:SetParent(line);
    self.sliderLabel:SetSize(176, 20);
    self.sliderLabel:SetPosition(20, 0);
    self.sliderLabel:SetText(L["Slider"]);
    PengorosPlugins.UI.Tooltip(self.sliderLabel, L["Select the Effect Slider you would like to modify."]);
    
    self.sliderCombo = PengorosPlugins.UI.ComboBox();
    self.sliderCombo:SetParent(line);
    self.sliderCombo:SetSize(204, 20);
    self.sliderCombo:SetPosition(196, 0);
    self.sliderCombo.SelectedIndexChanged = function(sender, args)
        if (self.current ~= nil) then
            self:SaveSliderOptions(self.current);
        end
        if (args.selection ~= nil) then
	        self:SetSliderOptions(args.selection);
	        self.current = args.selection;
	    end
    end

    line = holder(self, 30);    
    self.newButton  = Turbine.UI.Lotro.Button();
    self.newButton:SetParent(line);
    self.newButton:SetPosition(89, 0);
    self.newButton:SetSize(100, 22);
    self.newButton:SetText(L["New"]);
    PengorosPlugins.UI.Tooltip(self.newButton, L["Create a new Effect Slider."]);
    self.newButton.Click = function(sender, args)
        self:AddNewSlider();
    end

    self.copyButton  = Turbine.UI.Lotro.Button();
    self.copyButton:SetParent(line);
    self.copyButton:SetPosition(196, 0);
    self.copyButton:SetSize(100, 22);
    self.copyButton:SetText(L["Copy"]);
    PengorosPlugins.UI.Tooltip(self.copyButton, L["Copy the current Effect Slider."]);
    self.copyButton.Click = function(sender, args)
        self:CopyCurrentSlider();
    end

    self.removeButton  = Turbine.UI.Lotro.Button();
    self.removeButton:SetParent(line);
    self.removeButton:SetPosition(303, 0);
    self.removeButton:SetSize(100, 22);
    self.removeButton:SetText(L["Remove"]);
    PengorosPlugins.UI.Tooltip(self.removeButton, L["Remove the current Effect Slider."]);
    self.removeButton.Click = function(sender, args)
        self:RemoveCurrentSlider();
    end

    line = holder(self, 35);
    self.generalTitle = PengorosPlugins.UI.PanelDivider();
    self.generalTitle:SetParent(line);
    self.generalTitle:SetText(L["General"]);
    self.generalTitle:SetSize(400, 30);

    line = holder(self, 30);    
    self.nameLabel = PengorosPlugins.UI.Label();
    self.nameLabel:SetParent(line);
    self.nameLabel:SetSize(100, 20);
    self.nameLabel:SetPosition(20, 0);
    self.nameLabel:SetText(L["Name"]);
    PengorosPlugins.UI.Tooltip(self.nameLabel, L["The descriptive name of the current Effect Slider."]);
    
    self.nameText = Turbine.UI.Lotro.TextBox();
    self.nameText:SetParent(line);
    self.nameText:SetSize(280, 20);
    self.nameText:SetPosition(120, 0);
    self.nameText:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.nameText:SetMultiline(false);
    self.nameText:SetWantsUpdates(true);
    self.nameText.Update = function(sender, args)
        self.sliderCombo:UpdateSelectionText(self.nameText:GetText());
    end
    
    line = holder(self, 25);    
    self.showSliderCB = PengorosPlugins.UI.CheckBox();
    self.showSliderCB:SetParent(line);
    self.showSliderCB:SetText(L["Enabled"]);
    self.showSliderCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showSliderCB, L["When checked, this Effect Slider will be enabled."]);

    line = holder(self, 30);
    self.scopeLabel = PengorosPlugins.UI.Label();
    self.scopeLabel:SetParent(line);
    self.scopeLabel:SetSize(190, 20);
    self.scopeLabel:SetPosition(20, 0);
    self.scopeLabel:SetText(L["Load For"]);
    PengorosPlugins.UI.Tooltip(self.scopeLabel, L["Select which characters this Effect Slider will be loaded for."]);
    
    self.scopeCombo = PengorosPlugins.UI.ComboBox();
    self.scopeCombo:SetParent(line);
    self.scopeCombo:SetSize(190, 20);
    self.scopeCombo:SetPosition(210, 0);
    self.scopeCombo:AddItem(PengorosPlugins.Utils.PlayerManager.GetPlayer():GetName(), WindowScope.Character);
    self.scopeCombo:AddItem(L["All Characters"], WindowScope.Account);

    line = holder(self, 30);
    self.visibleTypeLabel = PengorosPlugins.UI.Label();
    self.visibleTypeLabel:SetParent(line);
    self.visibleTypeLabel:SetSize(190, 20);
    self.visibleTypeLabel:SetPosition(20, 0);
    self.visibleTypeLabel:SetText(L["Show Slider"]);
    PengorosPlugins.UI.Tooltip(self.visibleTypeLabel, L["Select when the slider is visible."]);
    
    self.visibleTypeCombo = PengorosPlugins.UI.ComboBox();
    self.visibleTypeCombo:SetParent(line);
    self.visibleTypeCombo:SetSize(190, 20);
    self.visibleTypeCombo:SetPosition(210, 0);
    self.visibleTypeCombo:AddItem(L["Always"], WindowVisibility.Always);
    self.visibleTypeCombo:AddItem(L["Only In Combat"], WindowVisibility.InCombat);
    self.visibleTypeCombo:AddItem(L["Only Out Of Combat"], WindowVisibility.OutOfCombat);
    self.visibleTypeCombo:AddItem(L["Has Effects"], WindowVisibility.HasEffects);
    self.visibleTypeCombo:AddItem(L["Only when mounted"], WindowVisibility.OnMount);
    self.visibleTypeCombo:AddItem(L["Only on a war-steed"], WindowVisibility.OnCombatMount);
    self.visibleTypeCombo:AddItem(L["Only when not mounted"], WindowVisibility.NotMounted);

    line = holder(self, 50);    
    self.timeMaxSlider = PengorosPlugins.UI.Slider();
    self.timeMaxSlider:SetParent(line);
    self.timeMaxSlider:SetText(L["Maximum Time (seconds)"]);
    self.timeMaxSlider:SetPosition(49, 0);
    self.timeMaxSlider:SetSize(350, 40);
    self.timeMaxSlider:SetStep(1);
    self.timeMaxSlider:SetMin(10);
    self.timeMaxSlider:SetMax(1800);
    PengorosPlugins.UI.Tooltip(self.timeMaxSlider.label, L["Adjust the maximum time to display in seconds.  Effects longer than this will sit at the end of the bar until they drop below the threshold."]);

    line = holder(self, 50);    
    self.timeCompressionSlider = PengorosPlugins.UI.Slider();
    self.timeCompressionSlider:SetParent(line);
    self.timeCompressionSlider:SetText(L["Time Compression"]);
    self.timeCompressionSlider:SetPosition(49, 0);
    self.timeCompressionSlider:SetSize(350, 40);
    self.timeCompressionSlider:SetStep(0.005);
    self.timeCompressionSlider:SetMin(0.01);
    self.timeCompressionSlider:SetMax(1.0);
    self.timeCompressionSlider:SetFormat("%.3f");
    PengorosPlugins.UI.Tooltip(self.timeCompressionSlider.label, L["Adjust the time display scaling factor.  Setting this to 1 will result in linear scaling, as you get closer to 0 larger time values are compressed into a smaller area."]);

    line = holder(self, 35);    
    self.filterTitle = PengorosPlugins.UI.PanelDivider();
    self.filterTitle:SetParent(line);
    self.filterTitle:SetText(L["Effect Triggers"]);
    self.filterTitle:SetSize(400, 30);
    
    line = holder(self, 155);
    self.triggerList = PengorosPlugins.UI.ListBox()
    self.triggerList:SetParent(line);
    self.triggerList:SetSize(355, 150);
    self.triggerList:SetPosition(45, 0);
    self.triggerList.SelectedIndexChanged = function(sender, args)
        self:TriggerSelected(args.selection);
    end
    self.triggerList.SelectionDoubleClick = function(sender, args)
        self:EditTrigger();
    end
    self.triggerList.SetEnabled = function(sender, enabled)
        PengorosPlugins.UI.ListBox.SetEnabled(sender, enabled);
        local hasSelection = self.triggerList:GetSelection() ~= nil;
        self.addTriggerButton:SetEnabled(enabled);
        self.editTriggerButton:SetEnabled(enabled and hasSelection);
        self.deleteTriggerButton:SetEnabled(enabled and hasSelection);
    end

    line = holder(self, 30);
    self.addTriggerButton = Turbine.UI.Lotro.Button();
    self.addTriggerButton:SetParent(line);
    self.addTriggerButton:SetPosition(44, 0);
    self.addTriggerButton:SetSize(50, 22);
    self.addTriggerButton:SetText(L["Add"]);
    PengorosPlugins.UI.Tooltip(self.addTriggerButton, L["Add a new trigger."]);
    self.addTriggerButton.Click = function(sender, args)
        self:AddTrigger();
    end

    self.editTriggerButton = Turbine.UI.Lotro.Button();
    self.editTriggerButton:SetParent(line);
    self.editTriggerButton:SetPosition(99, 0);
    self.editTriggerButton:SetSize(50, 22);
    self.editTriggerButton:SetText(L["Edit"]);
    self.editTriggerButton:SetEnabled(false);
    PengorosPlugins.UI.Tooltip(self.editTriggerButton, L["Edit the current trigger."]);
    self.editTriggerButton.Click = function(sender, args)
        self:EditTrigger();
    end

    self.deleteTriggerButton = Turbine.UI.Lotro.Button();
    self.deleteTriggerButton:SetParent(line);
    self.deleteTriggerButton:SetPosition(154, 0);
    self.deleteTriggerButton:SetSize(60, 22);
    self.deleteTriggerButton:SetText(L["Delete"]);
    self.deleteTriggerButton:SetEnabled(false);
    PengorosPlugins.UI.Tooltip(self.deleteTriggerButton, L["Remove the current trigger."]);
    self.deleteTriggerButton.Click = function(sender, args)
        self:DeleteTrigger();
    end

    self.moveUpTriggerButton = Turbine.UI.Lotro.Button();
    self.moveUpTriggerButton:SetParent(line);
    self.moveUpTriggerButton:SetPosition(219, 0);
    self.moveUpTriggerButton:SetSize(72, 22);
    self.moveUpTriggerButton:SetText(L["Move Up"]);
    self.moveUpTriggerButton:SetEnabled(false);
    PengorosPlugins.UI.Tooltip(self.moveUpTriggerButton, L["Move the current trigger up."]);
    self.moveUpTriggerButton.Click = function(sender, args)
        self.triggerList:MoveSelectionUp();
    end

    self.moveDownTriggerButton = Turbine.UI.Lotro.Button();
    self.moveDownTriggerButton:SetParent(line);
    self.moveDownTriggerButton:SetPosition(298, 0);
    self.moveDownTriggerButton:SetSize(92, 22);
    self.moveDownTriggerButton:SetText(L["Move Down"]);
    self.moveDownTriggerButton:SetEnabled(false);
    PengorosPlugins.UI.Tooltip(self.moveDownTriggerButton, L["Move the current trigger down."]);
    self.moveDownTriggerButton.Click = function(sender, args)
        self.triggerList:MoveSelectionDown();
    end

    line = holder(self, 70);
    self.orderLabel = PengorosPlugins.UI.Label();
    self.orderLabel:SetParent(line);
    self.orderLabel:SetSize(340, 60);
    self.orderLabel:SetPosition(45, 0);
    self.orderLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.orderLabel:SetText(L["Triggers are processed in the order they appear in this list.  It is a good idea to put very specific triggers at the top and more generalized ones at the bottom."]);

    line = holder(self, 35);    
    self.uiTitle = PengorosPlugins.UI.PanelDivider();
    self.uiTitle:SetParent(line);
    self.uiTitle:SetText(L["UI Elements"]);
    self.uiTitle:SetSize(400, 30);

    line = holder(self, 25);    
    self.showEffectTimerCB = PengorosPlugins.UI.CheckBox();
    self.showEffectTimerCB:SetParent(line);
    self.showEffectTimerCB:SetText(L["Effect Timer"]);
    self.showEffectTimerCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showEffectTimerCB, L["When checked, the timer for the effect will be placed on the slider."]);
    self.showEffectTimerCB.SetEnabled = function(sender, enabled)
        PengorosPlugins.UI.CheckBox.SetEnabled(sender, enabled);
        self.formatLabel:SetEnabled(enabled and sender:IsChecked());
        self.formatCombo:SetEnabled(enabled and sender:IsChecked());
    end
    self.showEffectTimerCB.CheckedChanged = function(sender, args)
        self.formatLabel:SetEnabled(sender:IsChecked());
        self.formatCombo:SetEnabled(sender:IsChecked());
    end

    line = holder(self, 30);    
    self.formatLabel = PengorosPlugins.UI.Label();
    self.formatLabel:SetParent(line);
    self.formatLabel:SetSize(190, 20);
    self.formatLabel:SetPosition(20, 0);
    self.formatLabel:SetText(L["Timer Format"]);
    PengorosPlugins.UI.Tooltip(self.formatLabel, L["Select the display format for the timers."]);
    
    self.formatCombo = PengorosPlugins.UI.ComboBox();
    self.formatCombo:SetParent(line);
    self.formatCombo:SetSize(190, 20);
    self.formatCombo:SetPosition(210, 0);
    self.formatCombo:AddItem(L["Clock: "]..PengorosPlugins.Utils.TimeFormat.CLOCK(75), TimeDisplayFormat.Clock);
    self.formatCombo:AddItem(L["Truncated: "]..PengorosPlugins.Utils.TimeFormat.TRUNCATED(75), TimeDisplayFormat.Truncated);
    self.formatCombo:AddItem(L["Literal: "]..PengorosPlugins.Utils.TimeFormat.LITERAL(75), TimeDisplayFormat.Literal);

    line = holder(self, 30);    
    self.fontLabel = PengorosPlugins.UI.Label();
    self.fontLabel:SetParent(line);
    self.fontLabel:SetSize(190, 20);
    self.fontLabel:SetPosition(20, 0);
    self.fontLabel:SetText(L["Font Size"]);
    PengorosPlugins.UI.Tooltip(self.fontLabel, L["Select the font size to use for the text."]);
    
    self.fontCombo = PengorosPlugins.UI.FontComboBox();
    self.fontCombo:SetParent(line);
    self.fontCombo:SetSize(190, 20);
    self.fontCombo:SetPosition(210, 0);
    self.fontCombo:AddItem(L["23px tall"], Turbine.UI.Lotro.Font.Verdana23, 27);
    self.fontCombo:AddItem(L["22px tall"], Turbine.UI.Lotro.Font.Verdana22, 26);
    self.fontCombo:AddItem(L["20px tall"], Turbine.UI.Lotro.Font.Verdana20, 24);
    self.fontCombo:AddItem(L["18px tall"], Turbine.UI.Lotro.Font.Verdana18, 22);
    self.fontCombo:AddItem(L["16px tall"], Turbine.UI.Lotro.Font.Verdana16, 20);
    self.fontCombo:AddItem(L["14px tall"], Turbine.UI.Lotro.Font.Verdana14, 18);
    self.fontCombo:AddItem(L["12px tall"], Turbine.UI.Lotro.Font.Verdana12, 16);
    self.fontCombo:AddItem(L["10px tall"], Turbine.UI.Lotro.Font.Verdana10, 14);

    line = holder(self, 30);    
    self.orientationLabel = PengorosPlugins.UI.Label();
    self.orientationLabel:SetParent(line);
    self.orientationLabel:SetSize(190, 20);
    self.orientationLabel:SetPosition(20, 0);
    self.orientationLabel:SetText(L["Slider Orientation"]);
    PengorosPlugins.UI.Tooltip(self.orientationLabel, L["Select the slider orientation and direction."]);
    
    self.orientationCombo = PengorosPlugins.UI.ComboBox();
    self.orientationCombo:SetParent(line);
    self.orientationCombo:SetSize(190, 20);
    self.orientationCombo:SetPosition(210, 0);
    self.orientationCombo:AddItem(L["Left to Right"], SliderOrientation.LeftToRight);
    self.orientationCombo:AddItem(L["Right to Left"], SliderOrientation.RightToLeft);
    self.orientationCombo:AddItem(L["Top to Bottom"], SliderOrientation.TopToBottom);
    self.orientationCombo:AddItem(L["Bottom to Top"], SliderOrientation.BottomToTop);
    self.orientationCombo.SelectedIndexChanged = function(sender, args)
        -- switch the height/width labels to make more sense when talking horizontal/vertical
        if (args.selection <= SliderOrientation.RightToLeft) then
            self.heightSlider:SetText(L["Height"]);
            self.widthSlider:SetText(L["Width"]);
        else
            self.heightSlider:SetText(L["Width"]);
            self.widthSlider:SetText(L["Height"]);
        end
    end    

    line = holder(self, 50);
    self.widthSlider = PengorosPlugins.UI.Slider();
    self.widthSlider:SetParent(line);
    self.widthSlider:SetText(L["Width"]);
    self.widthSlider:SetPosition(49, 0);
    self.widthSlider:SetSize(350, 40);
    self.widthSlider:SetStep(1);
    self.widthSlider:SetMin(50);
    self.widthSlider:SetMax(2560);
    PengorosPlugins.UI.Tooltip(self.widthSlider.label, L["Adjust the width of the slider."]);

    line = holder(self, 50);
    self.heightSlider = PengorosPlugins.UI.Slider();
    self.heightSlider:SetParent(line);
    self.heightSlider:SetText(L["Height"]);
    self.heightSlider:SetPosition(49, 0);
    self.heightSlider:SetSize(350, 40);
    self.heightSlider:SetStep(1);
    self.heightSlider:SetMin(10);
    self.heightSlider:SetMax(100);
    PengorosPlugins.UI.Tooltip(self.heightSlider.label, L["Adjust the height of the slider."]);

    line = holder(self, 35);
    self.colorTitle = PengorosPlugins.UI.PanelDivider();
    self.colorTitle:SetParent(line);
    self.colorTitle:SetText(L["Color"]);
    self.colorTitle:SetSize(400, 30);

    line = holder(self, 30);
    self.color = Turbine.UI.Control();
    self.color:SetParent(line);
    self.color:SetPosition(60, 0);
    self.color:SetSize(90, 20);
    self.color:SetZOrder(20);
    self.color:SetBackColor(Turbine.UI.Color(1,.8,.8,0));

    self.colorCombo = PengorosPlugins.UI.ComboBox();
    self.colorCombo:SetParent(line);
    self.colorCombo:SetSize(220, 20);
    self.colorCombo:SetPosition(180, 0);
    PengorosPlugins.UI.Tooltip(self.colorCombo, L["Select the color to modify."]);
    self.colorCombo:AddItem(L["Border"], OptionsSliderPanel.Border);
    self.colorCombo:AddItem(L["Background"], OptionsSliderPanel.Background);
    self.colorCombo:AddItem(L["Font"], OptionsSliderPanel.Font);
    self.colorCombo:AddItem(L["Font Outline"], OptionsSliderPanel.Outline);
    self.colorCombo.SelectedIndexChanged = function(sender, args)
        self:ChangeColor(self.colors[args.selection]);
    end    

    line = holder(self, 50);
    self.redSlider = PengorosPlugins.UI.Slider();
    self.redSlider:SetParent(line);
    self.redSlider:SetText(L["Red"]);
    self.redSlider:SetPosition(49, 0);
    self.redSlider:SetSize(350, 40);
    self.redSlider:SetStep(1);
    self.redSlider:SetMin(0);
    self.redSlider:SetMax(255);
    PengorosPlugins.UI.Tooltip(self.redSlider.label, L["Adjust the red value of the selected color."]);
    self.redSlider.ValueChanged = function(sender, args)
        local color = self.colors[self.colorCombo:GetSelection()];
        color.r = args.value;
        self.color:SetBackColor(Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255));
    end

    line = holder(self, 50);
    self.greenSlider = PengorosPlugins.UI.Slider();
    self.greenSlider:SetParent(line);
    self.greenSlider:SetText(L["Green"]);
    self.greenSlider:SetPosition(49, 0);
    self.greenSlider:SetSize(350, 40);
    self.greenSlider:SetStep(1);
    self.greenSlider:SetMin(0);
    self.greenSlider:SetMax(255);
    PengorosPlugins.UI.Tooltip(self.greenSlider.label, L["Adjust the green value of the selected color."]);
    self.greenSlider.ValueChanged = function(sender, args)
        local color = self.colors[self.colorCombo:GetSelection()];
        color.g = args.value;
        self.color:SetBackColor(Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255));
    end

    line = holder(self, 50);
    self.blueSlider = PengorosPlugins.UI.Slider();
    self.blueSlider:SetParent(line);
    self.blueSlider:SetText(L["Blue"]);
    self.blueSlider:SetPosition(49, 0);
    self.blueSlider:SetSize(350, 40);
    self.blueSlider:SetStep(1);
    self.blueSlider:SetMin(0);
    self.blueSlider:SetMax(255);
    PengorosPlugins.UI.Tooltip(self.blueSlider.label, L["Adjust the blue value of the selected color."]);
    self.blueSlider.ValueChanged = function(sender, args)
        local color = self.colors[self.colorCombo:GetSelection()];
        color.b = args.value;
        self.color:SetBackColor(Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255));
    end

    line = holder(self, 50);
    self.alphaSlider = PengorosPlugins.UI.Slider();
    self.alphaSlider:SetParent(line);
    self.alphaSlider:SetText(L["Alpha"]);
    self.alphaSlider:SetPosition(49, 0);
    self.alphaSlider:SetSize(350, 40);
    self.alphaSlider:SetStep(1);
    self.alphaSlider:SetMin(0);
    self.alphaSlider:SetMax(255);
    PengorosPlugins.UI.Tooltip(self.alphaSlider.label, L["Adjust the alpha value of the selected color.  0 is fully transparent and 255 is fully opaque."]);
    self.alphaSlider.ValueChanged = function(sender, args)
        local color = self.colors[self.colorCombo:GetSelection()];
        color.a = args.value;
        self.color:SetBackColor(Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255));
    end
end

function OptionsSliderPanel:AddNewSlider()
    local slider = SliderSettings();
    slider.name = L["New Slider"];
    self.sliderCombo:AddItem(slider.name, slider);
    self.sliderCombo:SetSelection(slider);
    self:EnableControls(true);
end

function OptionsSliderPanel:CopyCurrentSlider()
    self:SaveSliderOptions(self.current); -- make sure the options are up to date 
    local slider = self.current:Copy();
    slider.name = slider.name .. " - " .. L["Copy"];
    self.sliderCombo:AddItem(slider.name, slider);
    self.sliderCombo:SetSelection(slider);
    self:EnableControls(true);
end

function OptionsSliderPanel:RemoveCurrentSlider()
    self.sliderCombo:RemoveItem(self.current);
    self:EnableControls(self.sliderCombo:GetItemCount() > 0);
end

function OptionsSliderPanel:TriggerSelected(selection)
    self.editTriggerButton:SetEnabled(selection ~= nil);
    self.deleteTriggerButton:SetEnabled(selection ~= nil);
    self.moveUpTriggerButton:SetEnabled(self.triggerList:CanMoveSelectionUp());
    self.moveDownTriggerButton:SetEnabled(self.triggerList:CanMoveSelectionDown());
end

function OptionsSliderPanel:AddTrigger()
    self._win = EffectTriggerWindow();
    PengorosPlugins.Utils.AddListener(self._win, "Closed", function(sender, args)
        local trigger = self._win:GetTrigger();
        if (trigger ~= nil) then
            self.triggerList:AddItem(trigger:GetName(), trigger);
        end
        self._win = nil;
    end);
    
    self._win:SetOptions(Trigger({name=L["new trigger"]}));
    PengorosPlugins.Utils.ModalWindow(self._win, OptionsPanel.instance);
end

function OptionsSliderPanel:EditTrigger()
    self._win = EffectTriggerWindow();
    PengorosPlugins.Utils.AddListener(self._win, "Closed", function(sender, args)
        local trigger = self._win:GetTrigger();
        if (trigger ~= nil) then
            self.triggerList:UpdateSelection(trigger:GetName(), trigger);
        end
        self._win = nil;
    end);

    self._win:SetOptions(self.triggerList:GetSelection());
    PengorosPlugins.Utils.ModalWindow(self._win, OptionsPanel.instance);
end

function OptionsSliderPanel:DeleteTrigger()
    self.triggerList:RemoveItem(self.triggerList:GetSelection());
end

function OptionsSliderPanel:ChangeColor(color)
    self.color:SetBackColor(Turbine.UI.Color(color["a"] / 255, color["r"] / 255, color["g"] / 255, color["b"] / 255));
    self.redSlider:SetValue(color["r"]);
    self.greenSlider:SetValue(color["g"]);
    self.blueSlider:SetValue(color["b"]);
    self.alphaSlider:SetValue(color["a"]);
end

function OptionsSliderPanel:EnableControls(enable)
    self.sliderCombo:SetEnabled(enable);
    self.removeButton:SetEnabled(enable);
    self.copyButton:SetEnabled(enable);
    self.nameLabel:SetEnabled(enable);
    self.nameText:SetEnabled(enable);
    self.showSliderCB:SetEnabled(enable);
    self.scopeLabel:SetEnabled(enable);
    self.scopeCombo:SetEnabled(enable);
    self.visibleTypeLabel:SetEnabled(enable);
    self.visibleTypeCombo:SetEnabled(enable);
    self.timeMaxSlider:SetEnabled(enable);
    self.timeCompressionSlider:SetEnabled(enable);
    self.showEffectTimerCB:SetEnabled(enable);
    self.fontLabel:SetEnabled(enable);
    self.fontCombo:SetEnabled(enable);
    self.orientationLabel:SetEnabled(enable);
    self.orientationCombo:SetEnabled(enable);
    self.widthSlider:SetEnabled(enable);
    self.heightSlider:SetEnabled(enable);
    self.colorCombo:SetEnabled(enable);
    self.redSlider:SetEnabled(enable);
    self.greenSlider:SetEnabled(enable);
    self.blueSlider:SetEnabled(enable);
    self.alphaSlider:SetEnabled(enable);
    self.color:SetVisible(enable);
    self.triggerList:SetEnabled(enable);
end

function OptionsSliderPanel:SetOptions()
	-- reset
	self.current = nil;
	self.sliderCombo:ClearItems();

    -- sliders
    local sliders = Settings.GetSliders();
    for i = 1, #sliders do
        local slider = sliders[i]:Copy();
        self.sliderCombo:AddItem(slider.name, slider);
    end
    
    if (#sliders > 0) then
        self.sliderCombo:SetSelection(self.sliderCombo:GetItem(1));
        self:EnableControls(true);
    else
        self:EnableControls(false);
    end
end

function OptionsSliderPanel:SaveOptions()
    -- save the current slider settings
    if (self.current ~= nil) then
        self:SaveSliderOptions(self.current);
    end
    
    -- collect all the sliders into an array
    local sliders = {};
    local i;
    for i = 1, self.sliderCombo:GetItemCount() do
        sliders[i] = self.sliderCombo:GetItem(i);
    end
    
    -- overwrite the existing sliders
    Settings.SetSliders(sliders);
end

function OptionsSliderPanel:SetSliderOptions(settings)
    -- general
    self.nameText:SetText(settings.name);
    self.showSliderCB:SetChecked(settings.enabled);
    self.scopeCombo:SetSelection(settings.scope);
    self.visibleTypeCombo:SetSelection(settings.visibleType);
    self.timeMaxSlider:SetValue(settings.timeMax);
    self.timeCompressionSlider:SetValue(settings.timeCompression);

    -- effect triggers
    self.triggerList:ClearItems();
    for i = 1, table.getn(settings.triggers), 1 do
        self.triggerList:AddItem(settings.triggers[i]:GetName(), settings.triggers[i]);
    end

    -- ui elements
    self.showEffectTimerCB:SetChecked(settings.showEffectTimer);
    self.formatCombo:SetSelection(settings.displayFormat);
    self.fontCombo:SetSelection(settings.font);
    self.orientationCombo:SetSelection(settings.orientation);
    self.widthSlider:SetValue(settings.barWidth);
    self.heightSlider:SetValue(settings.barHeight);
    
    -- colors
    self.colors = {};
    self.colors[OptionsSliderPanel.Border] = settings.borderColor;
    self.colors[OptionsSliderPanel.Background] = settings.backgroundColor;
    self.colors[OptionsSliderPanel.Font] = settings.fontColor;
    self.colors[OptionsSliderPanel.Outline] = settings.fontOutlineColor;
    self.colorCombo:SetSelection(OptionsSliderPanel.Border);
    self:ChangeColor(self.colors[OptionsSliderPanel.Border]);
end

function OptionsSliderPanel:SaveSliderOptions(settings)
    -- general
    settings.name = self.nameText:GetText();
    settings.enabled = self.showSliderCB:IsChecked();
    settings.scope = self.scopeCombo:GetSelection();
    settings.visibleType = self.visibleTypeCombo:GetSelection();
    settings.timeMax = self.timeMaxSlider:GetValue();
    settings.timeCompression = self.timeCompressionSlider:GetValue();
   
    -- triggers
    settings.triggers = {};
    for i = 1, self.triggerList:GetItemCount(), 1 do
        local item = self.triggerList:GetItem(i);
        table.insert(settings.triggers, item);
    end

    -- ui elements
    settings.showEffectTimer = self.showEffectTimerCB:IsChecked();
    settings.displayFormat = self.formatCombo:GetSelection();
    settings.font = self.fontCombo:GetSelection();
    settings.orientation = self.orientationCombo:GetSelection();
    settings.barWidth = self.widthSlider:GetValue();
    settings.barHeight = self.heightSlider:GetValue();
   
    -- colors
    settings.borderColor = self.colors[OptionsSliderPanel.Border];
    settings.backgroundColor = self.colors[OptionsSliderPanel.Background];
    settings.fontColor = self.colors[OptionsSliderPanel.Font];
    settings.fontOutlineColor = self.colors[OptionsSliderPanel.Outline];
end

function OptionsSliderPanel:Destroy()
	if (self._win ~= nil) then
		self._win:Close();
		self._win = nil;
	end
end