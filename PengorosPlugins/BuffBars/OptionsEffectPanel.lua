import "Turbine.UI";

OptionsEffectPanel = class(Turbine.UI.ListBox);

OptionsEffectPanel.FlashElapsed = 1;
OptionsEffectPanel.FlashRemaining = 2;
OptionsEffectPanel.DiseaseElapsed = 3;
OptionsEffectPanel.DiseaseRemaining = 4;
OptionsEffectPanel.FearElapsed = 5;
OptionsEffectPanel.FearRemaining = 6;
OptionsEffectPanel.PoisonElapsed = 7;
OptionsEffectPanel.PoisonRemaining = 8;
OptionsEffectPanel.WoundElapsed = 9;
OptionsEffectPanel.WoundRemaining = 10;
OptionsEffectPanel.CorruptionElapsed = 11;
OptionsEffectPanel.CorruptionRemaining = 12;
OptionsEffectPanel.CryElapsed = 13;
OptionsEffectPanel.CryRemaining = 14;
OptionsEffectPanel.ElementalElapsed = 15;
OptionsEffectPanel.ElementalRemaining = 16;
OptionsEffectPanel.PhysicalElapsed = 17;
OptionsEffectPanel.PhysicalRemaining = 18;
OptionsEffectPanel.SongElapsed = 19;
OptionsEffectPanel.SongRemaining = 20;
OptionsEffectPanel.UndefinedElapsed = 21;
OptionsEffectPanel.UndefinedRemaining = 22;
OptionsEffectPanel.MoraleCoolDownElapsed = 23;
OptionsEffectPanel.MoraleCoolDownRemaining = 24;
OptionsEffectPanel.PowerCoolDownElapsed = 25;
OptionsEffectPanel.PowerCoolDownRemaining = 26;
OptionsEffectPanel.DiseaseCoolDownElapsed = 27;
OptionsEffectPanel.DiseaseCoolDownRemaining = 28;
OptionsEffectPanel.FearCoolDownElapsed = 29;
OptionsEffectPanel.FearCoolDownRemaining = 30;
OptionsEffectPanel.PoisonCoolDownElapsed = 31;
OptionsEffectPanel.PoisonCoolDownRemaining = 32;
OptionsEffectPanel.WoundCoolDownElapsed = 33;
OptionsEffectPanel.WoundCoolDownRemaining = 34;
OptionsEffectPanel.MobDebuffElapsed = 35;
OptionsEffectPanel.MobDebuffRemaining = 36;
OptionsEffectPanel.MobCCElapsed = 37;
OptionsEffectPanel.MobCCRemaining = 38;

local holder = function(parent, height)
    local container = Turbine.UI.Control();
    container:SetSize(400, height);
    parent:AddItem(container);
    return container;
end

function OptionsEffectPanel:Constructor()
    Turbine.UI.ListBox.Constructor(self);

    self.current = nil;
    self:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self:SetMaxItemsPerLine(1);
    
    local line = holder(self, 35);
    self.windowTitle = PengorosPlugins.UI.PanelDivider();
    self.windowTitle:SetParent(line);
    self.windowTitle:SetText(L["Effect Windows"]);
    self.windowTitle:SetSize(400, 30);
    
    line = holder(self, 30);
    self.windowLabel = PengorosPlugins.UI.Label();
    self.windowLabel:SetParent(line);
    self.windowLabel:SetSize(176, 20);
    self.windowLabel:SetPosition(20, 0);
    self.windowLabel:SetText(L["Window"]);
    PengorosPlugins.UI.Tooltip(self.windowLabel, L["Select the Effect Window you would like to modify."]);
    
    self.windowCombo = PengorosPlugins.UI.ComboBox();
    self.windowCombo:SetParent(line);
    self.windowCombo:SetSize(204, 20);
    self.windowCombo:SetPosition(196, 0);
    self.windowCombo.SelectedIndexChanged = function(sender, args)
        if (self.current ~= nil) then
            self:SaveWindowOptions(self.current);
        end
        if (args.selection ~= nil) then
	        self:SetWindowOptions(args.selection);
	        self.current = args.selection;
	    end
    end
    
    line = holder(self, 30);
    self.newButton  = Turbine.UI.Lotro.Button();
    self.newButton:SetParent(line);
    self.newButton:SetPosition(89, 0);
    self.newButton:SetSize(100, 22);
    self.newButton:SetText(L["New"]);
    PengorosPlugins.UI.Tooltip(self.newButton, L["Create a new Effect Window."]);
    self.newButton.Click = function(sender, args)
        self:AddNewWindow();
    end

    self.copyButton  = Turbine.UI.Lotro.Button();
    self.copyButton:SetParent(line);
    self.copyButton:SetPosition(196, 0);
    self.copyButton:SetSize(100, 22);
    self.copyButton:SetText(L["Copy"]);
    PengorosPlugins.UI.Tooltip(self.copyButton, L["Copy the current Effect Window."]);
    self.copyButton.Click = function(sender, args)
        self:CopyCurrentWindow();
    end

    self.removeButton  = Turbine.UI.Lotro.Button();
    self.removeButton:SetParent(line);
    self.removeButton:SetPosition(303, 0);
    self.removeButton:SetSize(100, 22);
    self.removeButton:SetText(L["Remove"]);
    PengorosPlugins.UI.Tooltip(self.removeButton, L["Remove the current Effect Window."]);
    self.removeButton.Click = function(sender, args)
        self:RemoveCurrentWindow();
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
    PengorosPlugins.UI.Tooltip(self.nameLabel, L["The descriptive name of the current Effect Window."]);
    
    self.nameText = Turbine.UI.Lotro.TextBox();
    self.nameText:SetParent(line);
    self.nameText:SetSize(280, 20);
    self.nameText:SetPosition(120, 0);
    self.nameText:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.nameText:SetMultiline(false);
    self.nameText:SetWantsUpdates(true);
    self.nameText.Update = function(sender, args)
        self.windowCombo:UpdateSelectionText(self.nameText:GetText());
    end
    
    line = holder(self, 25);
    self.showWindowCB = PengorosPlugins.UI.CheckBox();
    self.showWindowCB:SetParent(line);
    self.showWindowCB:SetText(L["Enabled"]);
    self.showWindowCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showWindowCB, L["When checked, this Effect Window will be enabled."]);

    line = holder(self, 30);
    self.scopeLabel = PengorosPlugins.UI.Label();
    self.scopeLabel:SetParent(line);
    self.scopeLabel:SetSize(190, 20);
    self.scopeLabel:SetPosition(20, 0);
    self.scopeLabel:SetText(L["Load For"]);
    PengorosPlugins.UI.Tooltip(self.scopeLabel, L["Select which characters this Effect Window will be loaded for."]);
    
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
    self.visibleTypeLabel:SetText(L["Show Window"]);
    PengorosPlugins.UI.Tooltip(self.visibleTypeLabel, L["Select when the window is visible."]);
    
    self.visibleTypeCombo = PengorosPlugins.UI.ComboBox();
    self.visibleTypeCombo:SetParent(line);
    self.visibleTypeCombo:SetSize(190, 20);
    self.visibleTypeCombo:SetPosition(210, 0);
    self.visibleTypeCombo:AddItem(L["Always"], WindowVisibility.Always);
    self.visibleTypeCombo:AddItem(L["Only In Combat"], WindowVisibility.InCombat);
    self.visibleTypeCombo:AddItem(L["Only Out Of Combat"], WindowVisibility.OutOfCombat);
    self.visibleTypeCombo:AddItem(L["Only when mounted"], WindowVisibility.OnMount);
    self.visibleTypeCombo:AddItem(L["Only on a war-steed"], WindowVisibility.OnCombatMount);
    self.visibleTypeCombo:AddItem(L["Only when not mounted"], WindowVisibility.NotMounted);

    line = holder(self, 35);
    self.sortingTitle = PengorosPlugins.UI.PanelDivider();
    self.sortingTitle:SetParent(line);
    self.sortingTitle:SetText(L["Sorting"]);
    self.sortingTitle:SetSize(400, 30);
    
    line = holder(self, 30);
    self.sortLabel = PengorosPlugins.UI.Label();
    self.sortLabel:SetParent(line);
    self.sortLabel:SetSize(180, 20);
    self.sortLabel:SetPosition(20, 0);
    self.sortLabel:SetText(L["Method"]);
    PengorosPlugins.UI.Tooltip(self.sortLabel, L["Select how effects are sorted."]);
    
    self.sortCombo = PengorosPlugins.UI.ComboBox();
    self.sortCombo:SetParent(line);
    self.sortCombo:SetSize(200, 20);
    self.sortCombo:SetPosition(200, 0);
    self.sortCombo:AddItem(L["Name"], EffectBarSort.Name);
    self.sortCombo:AddItem(L["Time Remaining"], EffectBarSort.Time);
    self.sortCombo:AddItem(L["Effect Category"], EffectBarSort.Category);
    self.sortCombo:AddItem(L["None"], EffectBarSort.None);
    
    line = holder(self, 30);
    self.directionLabel = PengorosPlugins.UI.Label();
    self.directionLabel:SetParent(line);
    self.directionLabel:SetSize(180, 20);
    self.directionLabel:SetPosition(20, 0);
    self.directionLabel:SetText(L["Direction"]);
    PengorosPlugins.UI.Tooltip(self.directionLabel, L["Select which direction effects are sorted."]);
    
    self.directionCombo = PengorosPlugins.UI.ComboBox();
    self.directionCombo:SetParent(line);
    self.directionCombo:SetSize(200, 20);
    self.directionCombo:SetPosition(200, 0);
    self.directionCombo:AddItem(L["Ascending"], true);
    self.directionCombo:AddItem(L["Descending"], false);
    
    line = holder(self, 30);
    self.fillLabel = PengorosPlugins.UI.Label();
    self.fillLabel:SetParent(line);
    self.fillLabel:SetSize(180, 20);
    self.fillLabel:SetPosition(20, 0);
    self.fillLabel:SetText(L["Fill"]);
    PengorosPlugins.UI.Tooltip(self.fillLabel, L["The window will dynamically resize itself according to the number of effects active.  Fill determines which way the window grows, down or up."]);
    
    self.fillCombo = PengorosPlugins.UI.ComboBox();
    self.fillCombo:SetParent(line);
    self.fillCombo:SetSize(200, 20);
    self.fillCombo:SetPosition(200, 0);
    self.fillCombo:AddItem(L["Top to Bottom"], false);
    self.fillCombo:AddItem(L["Bottom to Top"], true);

    line = holder(self, 112);
    self.barOrderLabel = PengorosPlugins.UI.Label();
    self.barOrderLabel:SetParent(line);
    self.barOrderLabel:SetSize(190, 20);
    self.barOrderLabel:SetPosition(20, 0);
    self.barOrderLabel:SetText(L["Bar Order"]);
    PengorosPlugins.UI.Tooltip(self.barOrderLabel, L["Select the order of the bars in the window."]);
    
    self.barOrderList = PengorosPlugins.UI.ListBox()
    self.barOrderList:SetParent(line);
    self.barOrderList:SetSize(100, 102);
    self.barOrderList:SetPosition(200, 0);
    self.barOrderList.SelectedIndexChanged = function(sender, args)
        self:BarSelected(args.selection);
    end

    self.moveUpBarButton = Turbine.UI.Lotro.Button();
    self.moveUpBarButton:SetParent(line);
    self.moveUpBarButton:SetPosition(300, 26);
    self.moveUpBarButton:SetSize(100, 22);
    self.moveUpBarButton:SetText(L["Move Up"]);
    self.moveUpBarButton:SetEnabled(false);
    PengorosPlugins.UI.Tooltip(self.moveUpBarButton, L["Move the current bar up."]);
    self.moveUpBarButton.Click = function(sender, args)
        self.barOrderList:MoveSelectionUp();
    end

    self.moveDownBarButton = Turbine.UI.Lotro.Button();
    self.moveDownBarButton:SetParent(line);
    self.moveDownBarButton:SetPosition(300, 51);
    self.moveDownBarButton:SetSize(100, 22);
    self.moveDownBarButton:SetText(L["Move Down"]);
    self.moveDownBarButton:SetEnabled(false);
    PengorosPlugins.UI.Tooltip(self.moveDownBarButton, L["Move the current bar down."]);
    self.moveDownBarButton.Click = function(sender, args)
        self.barOrderList:MoveSelectionDown();
    end
    
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
    self.triggerLabel = PengorosPlugins.UI.Label();
    self.triggerLabel:SetParent(line);
    self.triggerLabel:SetSize(340, 60);
    self.triggerLabel:SetPosition(45, 0);
    self.triggerLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.triggerLabel:SetText(L["Triggers are processed in the order they appear in this list.  It is a good idea to put very specific triggers at the top and more generalized ones at the bottom."]);

    line = holder(self, 35);
    self.flashingTitle = PengorosPlugins.UI.PanelDivider();
    self.flashingTitle:SetParent(line);
    self.flashingTitle:SetText(L["Flashing"]);
    self.flashingTitle:SetSize(400, 30);

    line = holder(self, 30);
    self.allowFlashingCB = PengorosPlugins.UI.CheckBox();
    self.allowFlashingCB:SetParent(line);
    self.allowFlashingCB:SetText(L["Flash Expiring Effects"]);
    self.allowFlashingCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.allowFlashingCB, L["When checked, effects will flash when they are about to expire."]);
    self.allowFlashingCB.SetEnabled = function(sender, enabled)
        PengorosPlugins.UI.CheckBox.SetEnabled(sender, enabled);
        self.flashSlider:SetEnabled(enabled and sender:IsChecked());
    end
    self.allowFlashingCB.CheckedChanged = function(sender, args)
        self.flashSlider:SetEnabled(sender:IsChecked());
    end

    line = holder(self, 50);
    self.flashSlider = PengorosPlugins.UI.Slider();
    self.flashSlider:SetParent(line);
    self.flashSlider:SetText(L["Flash Time"]);
    self.flashSlider:SetPosition(49, 0);
    self.flashSlider:SetSize(350, 40);
    self.flashSlider:SetStep(1);
    self.flashSlider:SetMin(1);
    self.flashSlider:SetMax(30);
    PengorosPlugins.UI.Tooltip(self.flashSlider.label, L["Adjust the time when effects start to flash.  Effects start flashing slowly and increase speed when the time remaining is half of this value."]);

    line = holder(self, 35);
    self.uiTitle = PengorosPlugins.UI.PanelDivider();
    self.uiTitle:SetParent(line);
    self.uiTitle:SetText(L["UI Elements"]);
    self.uiTitle:SetSize(400, 30);

    line = holder(self, 20);
    self.showEffectIconCB = PengorosPlugins.UI.CheckBox();
    self.showEffectIconCB:SetParent(line);
    self.showEffectIconCB:SetText(L["Effect Icon"]);
    self.showEffectIconCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showEffectIconCB, L["When checked, the icon for the effect will be placed on the bar."]);

    line = holder(self, 20);
    self.showEffectNameCB = PengorosPlugins.UI.CheckBox();
    self.showEffectNameCB:SetParent(line);
    self.showEffectNameCB:SetText(L["Effect Name"]);
    self.showEffectNameCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showEffectNameCB, L["When checked, the name for the effect will be placed on the bar."]);

    line = holder(self, 20);
    self.showEffectTimerCB = PengorosPlugins.UI.CheckBox();
    self.showEffectTimerCB:SetParent(line);
    self.showEffectTimerCB:SetText(L["Effect Timer"]);
    self.showEffectTimerCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showEffectTimerCB, L["When checked, the timer for the effect will be placed on the bar."]);

    line = holder(self, 20);
    self.showEffectTargetCB = PengorosPlugins.UI.CheckBox();
    self.showEffectTargetCB:SetParent(line);
    self.showEffectTargetCB:SetText(L["Effect Target"]);
    self.showEffectTargetCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showEffectTargetCB, L["When checked, the name of the target for the effect will be placed on the bar."]);

    line = holder(self, 25);
    self.showDurationTimerCB = PengorosPlugins.UI.CheckBox();
    self.showDurationTimerCB:SetParent(line);
    self.showDurationTimerCB:SetText(L["Timer On Effects With No Duration"]);
    self.showDurationTimerCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showDurationTimerCB, L["When checked, effects that do not have a duration will have an incrementing timer placed on the bar indicating how long the effect has been in place."]);

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

    line = holder(self, 50);
    self.widthSlider = PengorosPlugins.UI.Slider();
    self.widthSlider:SetParent(line);
    self.widthSlider:SetText(L["Width"]);
    self.widthSlider:SetPosition(49, 0);
    self.widthSlider:SetSize(350, 40);
    self.widthSlider:SetStep(1);
    self.widthSlider:SetMin(50);
    self.widthSlider:SetMax(500);
    PengorosPlugins.UI.Tooltip(self.widthSlider.label, L["Adjust the width of the window."]);

    line = holder(self, 50);
    self.heightSlider = PengorosPlugins.UI.Slider();
    self.heightSlider:SetParent(line);
    self.heightSlider:SetText(L["Height"]);
    self.heightSlider:SetPosition(49, 0);
    self.heightSlider:SetSize(350, 40);
    self.heightSlider:SetStep(1);
    self.heightSlider:SetMin(10);
    self.heightSlider:SetMax(50);
    PengorosPlugins.UI.Tooltip(self.heightSlider.label, L["Adjust the height of the window."]);

    line = holder(self, 35);
    self.colorTitle = PengorosPlugins.UI.PanelDivider();
    self.colorTitle:SetParent(line);
    self.colorTitle:SetText(L["Color"]);
    self.colorTitle:SetSize(400, 30);

    line = holder(self, 30);
    self.background = Turbine.UI.Control();
    self.background:SetParent(line);
    self.background:SetPosition(60, 0);
    self.background:SetSize(90, 20);
    self.background:SetZOrder(10);
    self.background:SetBackColor(Turbine.UI.Color(.5,0,0,0));

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
    self.colorCombo:AddItem(L["Flash Elapsed"], OptionsEffectPanel.FlashElapsed);
    self.colorCombo:AddItem(L["Flash Remaining"], OptionsEffectPanel.FlashRemaining);
    self.colorCombo:AddItem(L["Disease Elapsed"], OptionsEffectPanel.DiseaseElapsed);
    self.colorCombo:AddItem(L["Disease Remaining"], OptionsEffectPanel.DiseaseRemaining);
    self.colorCombo:AddItem(L["Fear Elapsed"], OptionsEffectPanel.FearElapsed);
    self.colorCombo:AddItem(L["Fear Remaining"], OptionsEffectPanel.FearRemaining);
    self.colorCombo:AddItem(L["Poison Elapsed"], OptionsEffectPanel.PoisonElapsed);
    self.colorCombo:AddItem(L["Poison Remaining"], OptionsEffectPanel.PoisonRemaining);
    self.colorCombo:AddItem(L["Wound Elapsed"], OptionsEffectPanel.WoundElapsed);
    self.colorCombo:AddItem(L["Wound Remaining"], OptionsEffectPanel.WoundRemaining);
    self.colorCombo:AddItem(L["Mob Debuff Elapsed"], OptionsEffectPanel.MobDebuffElapsed);
    self.colorCombo:AddItem(L["Mob Debuff Remaining"], OptionsEffectPanel.MobDebuffRemaining);
    self.colorCombo:AddItem(L["Mob CC Elapsed"], OptionsEffectPanel.MobCCElapsed);
    self.colorCombo:AddItem(L["Mob CC Remaining"], OptionsEffectPanel.MobCCRemaining);
    self.colorCombo:AddItem(L["Corruption Elapsed"], OptionsEffectPanel.CorruptionElapsed);
    self.colorCombo:AddItem(L["Corruption Remaining"], OptionsEffectPanel.CorruptionRemaining);
    self.colorCombo:AddItem(L["Cry Elapsed"], OptionsEffectPanel.CryElapsed);
    self.colorCombo:AddItem(L["Cry Remaining"], OptionsEffectPanel.CryRemaining);
    self.colorCombo:AddItem(L["Elemental Elapsed"], OptionsEffectPanel.ElementalElapsed);
    self.colorCombo:AddItem(L["Elemental Remaining"], OptionsEffectPanel.ElementalRemaining);
    self.colorCombo:AddItem(L["Physical Elapsed"], OptionsEffectPanel.PhysicalElapsed);
    self.colorCombo:AddItem(L["Physical Remaining"], OptionsEffectPanel.PhysicalRemaining);
    self.colorCombo:AddItem(L["Song Elapsed"], OptionsEffectPanel.SongElapsed);
    self.colorCombo:AddItem(L["Song Remaining"], OptionsEffectPanel.SongRemaining);
    self.colorCombo:AddItem(L["Undefined Elapsed"], OptionsEffectPanel.UndefinedElapsed);
    self.colorCombo:AddItem(L["Undefined Remaining"], OptionsEffectPanel.UndefinedRemaining);
    self.colorCombo:AddItem(L["Morale CD Elapsed"], OptionsEffectPanel.MoraleCoolDownElapsed);
    self.colorCombo:AddItem(L["Morale CD Remaining"], OptionsEffectPanel.MoraleCoolDownRemaining);
    self.colorCombo:AddItem(L["Power CD Elapsed"], OptionsEffectPanel.PowerCoolDownElapsed);
    self.colorCombo:AddItem(L["Power CD Remaining"], OptionsEffectPanel.PowerCoolDownRemaining);
    self.colorCombo:AddItem(L["Disease CD Elapsed"], OptionsEffectPanel.DiseaseCoolDownElapsed);
    self.colorCombo:AddItem(L["Disease CD Remaining"], OptionsEffectPanel.DiseaseCoolDownRemaining);
    self.colorCombo:AddItem(L["Fear CD Elapsed"], OptionsEffectPanel.FearCoolDownElapsed);
    self.colorCombo:AddItem(L["Fear CD Remaining"], OptionsEffectPanel.FearCoolDownRemaining);
    self.colorCombo:AddItem(L["Poison CD Elapsed"], OptionsEffectPanel.PoisonCoolDownElapsed);
    self.colorCombo:AddItem(L["Poison CD Remaining"], OptionsEffectPanel.PoisonCoolDownRemaining);
    self.colorCombo:AddItem(L["Wound CD Elapsed"], OptionsEffectPanel.WoundCoolDownElapsed);
    self.colorCombo:AddItem(L["Wound CD Remaining"], OptionsEffectPanel.WoundCoolDownRemaining);
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

function OptionsEffectPanel:AddNewWindow()
    local window = EffectBarSettings();
    window.name = L["New Window"];
    self.windowCombo:AddItem(window.name, window);
    self.windowCombo:SetSelection(window);
    self:EnableControls(true);
end

function OptionsEffectPanel:CopyCurrentWindow()
    self:SaveWindowOptions(self.current); -- make sure the options are up to date 
    local window = self.current:Copy();
    window.name = window.name .. " - " .. L["Copy"];
    self.windowCombo:AddItem(window.name, window);
    self.windowCombo:SetSelection(window);
    self:EnableControls(true);
end

function OptionsEffectPanel:RemoveCurrentWindow()
    self.windowCombo:RemoveItem(self.current);
    self:EnableControls(self.windowCombo:GetItemCount() > 0);
end

function OptionsEffectPanel:BarSelected(selection)
    self.moveUpBarButton:SetEnabled(self.barOrderList:CanMoveSelectionUp());
    self.moveDownBarButton:SetEnabled(self.barOrderList:CanMoveSelectionDown());
end

function OptionsEffectPanel:TriggerSelected(selection)
    self.editTriggerButton:SetEnabled(selection ~= nil);
    self.deleteTriggerButton:SetEnabled(selection ~= nil);
    self.moveUpTriggerButton:SetEnabled(self.triggerList:CanMoveSelectionUp());
    self.moveDownTriggerButton:SetEnabled(self.triggerList:CanMoveSelectionDown());
end

function OptionsEffectPanel:AddTrigger()
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

function OptionsEffectPanel:EditTrigger()
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

function OptionsEffectPanel:DeleteTrigger()
    self.triggerList:RemoveItem(self.triggerList:GetSelection());
end

function OptionsEffectPanel:ChangeColor(color)
    self.color:SetBackColor(Turbine.UI.Color(color["a"] / 255, color["r"] / 255, color["g"] / 255, color["b"] / 255));
    self.redSlider:SetValue(color["r"]);
    self.greenSlider:SetValue(color["g"]);
    self.blueSlider:SetValue(color["b"]);
    self.alphaSlider:SetValue(color["a"]);
end

function OptionsEffectPanel:EnableControls(enable)
    self.windowCombo:SetEnabled(enable);
    self.removeButton:SetEnabled(enable);
    self.copyButton:SetEnabled(enable);
    self.nameLabel:SetEnabled(enable);
    self.nameText:SetEnabled(enable);
    self.showWindowCB:SetEnabled(enable);
    self.scopeLabel:SetEnabled(enable);
    self.scopeCombo:SetEnabled(enable);
    self.visibleTypeLabel:SetEnabled(enable);
    self.visibleTypeCombo:SetEnabled(enable);
    self.sortLabel:SetEnabled(enable);
    self.sortCombo:SetEnabled(enable);
    self.directionLabel:SetEnabled(enable);
    self.directionCombo:SetEnabled(enable);
    self.barOrderLabel:SetEnabled(enable);
    self.barOrderList:SetEnabled(enable);
    self.fillLabel:SetEnabled(enable);
    self.fillCombo:SetEnabled(enable);
    self.allowFlashingCB:SetEnabled(enable);
    self.showEffectIconCB:SetEnabled(enable);
    self.showEffectNameCB:SetEnabled(enable);
    self.showEffectTimerCB:SetEnabled(enable);
    self.showEffectTargetCB:SetEnabled(enable);
    self.showDurationTimerCB:SetEnabled(enable);
    self.formatLabel:SetEnabled(enable);
    self.formatCombo:SetEnabled(enable);
    self.fontLabel:SetEnabled(enable);
    self.fontCombo:SetEnabled(enable);
    self.widthSlider:SetEnabled(enable);
    self.heightSlider:SetEnabled(enable);
    self.colorCombo:SetEnabled(enable);
    self.redSlider:SetEnabled(enable);
    self.greenSlider:SetEnabled(enable);
    self.blueSlider:SetEnabled(enable);
    self.alphaSlider:SetEnabled(enable);
    self.color:SetVisible(enable);
    self.background:SetVisible(enable);
    self.triggerList:SetEnabled(enable);
    self.triggerLabel:SetEnabled(enable);
end

function OptionsEffectPanel:SetOptions()
	-- reset
	self.current = nil;
	self.windowCombo:ClearItems();
	
    -- windows
    local windows = Settings.GetWindows();
    for i = 1, #windows do
        local window = windows[i]:Copy();
        self.windowCombo:AddItem(window.name, window);
    end
    
    if (#windows > 0) then
        self.windowCombo:SetSelection(self.windowCombo:GetItem(1));
        self:EnableControls(true);
    else
        self:EnableControls(false);
    end
end

function OptionsEffectPanel:SaveOptions()
    -- save the current window settings
    if (self.current ~= nil) then
        self:SaveWindowOptions(self.current);
    end
    
    -- collect all the windows into an array
    local windows = {};
    local i;
    for i = 1, self.windowCombo:GetItemCount() do
        windows[i] = self.windowCombo:GetItem(i);
    end
    
    -- overwrite the existing windows
    Settings.SetWindows(windows);
end

function OptionsEffectPanel:SetWindowOptions(settings)
    -- general
    self.nameText:SetText(settings.name);
    self.showWindowCB:SetChecked(settings.enabled);
    self.scopeCombo:SetSelection(settings.scope);
    self.visibleTypeCombo:SetSelection(settings.visibleType);

    -- sorting
    self.sortCombo:SetSelection(settings.sortMethod);
    self.directionCombo:SetSelection(settings.sortAscending);
    self.fillCombo:SetSelection(settings.fillBottomToTop);
    self.barOrderList:ClearItems();
    for i = 1, table.getn(settings.barOrder), 1 do
        self.barOrderList:AddItem(L[settings.barOrder[i]], settings.barOrder[i]);
    end

    -- flahing
    self.allowFlashingCB:SetChecked(settings.allowFlashing);
    self.flashSlider:SetValue(settings.flashTime);
    
    -- ui elements
    self.showEffectIconCB:SetChecked(settings.showEffectIcon);
    self.showEffectNameCB:SetChecked(settings.showEffectName);
    self.showEffectTimerCB:SetChecked(settings.showEffectTimer);
    self.showEffectTargetCB:SetChecked(settings.showEffectTarget);
    self.showDurationTimerCB:SetChecked(settings.showEffectDuration);
    self.formatCombo:SetSelection(settings.displayFormat);
    self.fontCombo:SetSelection(settings.font);
    self.widthSlider:SetValue(settings.barWidth);
    self.heightSlider:SetValue(settings.barHeight);
    
    -- colors
    self.colors = {};
    self.colors[OptionsEffectPanel.FlashElapsed] = settings:GetElapsedColorArray(Colors.Flash);
    self.colors[OptionsEffectPanel.FlashRemaining] = settings:GetRemainingColorArray(Colors.Flash);
    self.colors[OptionsEffectPanel.DiseaseElapsed] = settings:GetElapsedColorArray(Colors.Disease);
    self.colors[OptionsEffectPanel.DiseaseRemaining] = settings:GetRemainingColorArray(Colors.Disease);
    self.colors[OptionsEffectPanel.FearElapsed] = settings:GetElapsedColorArray(Colors.Fear);
    self.colors[OptionsEffectPanel.FearRemaining] = settings:GetRemainingColorArray(Colors.Fear);
    self.colors[OptionsEffectPanel.PoisonElapsed] = settings:GetElapsedColorArray(Colors.Poison);
    self.colors[OptionsEffectPanel.PoisonRemaining] = settings:GetRemainingColorArray(Colors.Poison);
    self.colors[OptionsEffectPanel.WoundElapsed] = settings:GetElapsedColorArray(Colors.Wound);
    self.colors[OptionsEffectPanel.WoundRemaining] = settings:GetRemainingColorArray(Colors.Wound);
    self.colors[OptionsEffectPanel.MobDebuffElapsed] = settings:GetElapsedColorArray(Colors.MobDebuff);
    self.colors[OptionsEffectPanel.MobDebuffRemaining] = settings:GetRemainingColorArray(Colors.MobDebuff);
    self.colors[OptionsEffectPanel.MobCCElapsed] = settings:GetElapsedColorArray(Colors.MobCrowdControl);
    self.colors[OptionsEffectPanel.MobCCRemaining] = settings:GetRemainingColorArray(Colors.MobCrowdControl);
    self.colors[OptionsEffectPanel.CorruptionElapsed] = settings:GetElapsedColorArray(Colors.Corruption);
    self.colors[OptionsEffectPanel.CorruptionRemaining] = settings:GetRemainingColorArray(Colors.Corruption);
    self.colors[OptionsEffectPanel.CryElapsed] = settings:GetElapsedColorArray(Colors.Cry);
    self.colors[OptionsEffectPanel.CryRemaining] = settings:GetRemainingColorArray(Colors.Cry);
    self.colors[OptionsEffectPanel.ElementalElapsed] = settings:GetElapsedColorArray(Colors.Elemental);
    self.colors[OptionsEffectPanel.ElementalRemaining] = settings:GetRemainingColorArray(Colors.Elemental);
    self.colors[OptionsEffectPanel.PhysicalElapsed] = settings:GetElapsedColorArray(Colors.Physical);
    self.colors[OptionsEffectPanel.PhysicalRemaining] = settings:GetRemainingColorArray(Colors.Physical);
    self.colors[OptionsEffectPanel.SongElapsed] = settings:GetElapsedColorArray(Colors.Song);
    self.colors[OptionsEffectPanel.SongRemaining] = settings:GetRemainingColorArray(Colors.Song);
    self.colors[OptionsEffectPanel.UndefinedElapsed] = settings:GetElapsedColorArray(Colors.Undefined);
    self.colors[OptionsEffectPanel.UndefinedRemaining] = settings:GetRemainingColorArray(Colors.Undefined);
    self.colors[OptionsEffectPanel.MoraleCoolDownElapsed] = settings:GetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Morale);
    self.colors[OptionsEffectPanel.MoraleCoolDownRemaining] = settings:GetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Morale);
    self.colors[OptionsEffectPanel.PowerCoolDownElapsed] = settings:GetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Power);
    self.colors[OptionsEffectPanel.PowerCoolDownRemaining] = settings:GetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Power);
    self.colors[OptionsEffectPanel.DiseaseCoolDownElapsed] = settings:GetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Disease);
    self.colors[OptionsEffectPanel.DiseaseCoolDownRemaining] = settings:GetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Disease);
    self.colors[OptionsEffectPanel.FearCoolDownElapsed] = settings:GetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Fear);
    self.colors[OptionsEffectPanel.FearCoolDownRemaining] = settings:GetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Fear);
    self.colors[OptionsEffectPanel.PoisonCoolDownElapsed] = settings:GetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Poison);
    self.colors[OptionsEffectPanel.PoisonCoolDownRemaining] = settings:GetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Poison);
    self.colors[OptionsEffectPanel.WoundCoolDownElapsed] = settings:GetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Wound);
    self.colors[OptionsEffectPanel.WoundCoolDownRemaining] = settings:GetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Wound);    
    self.background:SetBackColor(settings:GetBackColor());
    self.colorCombo:SetSelection(OptionsEffectPanel.FlashElapsed);
    self:ChangeColor(self.colors[OptionsEffectPanel.FlashElapsed]);

    -- effect triggers
    self.triggerList:ClearItems();
    for i = 1, table.getn(settings.triggers), 1 do
        self.triggerList:AddItem(settings.triggers[i]:GetName(), settings.triggers[i]);
    end
end

function OptionsEffectPanel:SaveWindowOptions(settings)
    -- general
    settings.name = self.nameText:GetText();
    settings.enabled = self.showWindowCB:IsChecked();
    settings.scope = self.scopeCombo:GetSelection();
    settings.visibleType = self.visibleTypeCombo:GetSelection();
   
    -- sorting
    settings.sortMethod = self.sortCombo:GetSelection();
    settings.sortAscending = self.directionCombo:GetSelection();
    settings.fillBottomToTop = self.fillCombo:GetSelection();
    settings.barOrder = {};
    for i = 1, self.barOrderList:GetItemCount(), 1 do
        local item = self.barOrderList:GetItem(i);
        table.insert(settings.barOrder, item);
    end
       
    -- flashing
    settings.allowFlashing = self.allowFlashingCB:IsChecked();
    settings.flashTime = self.flashSlider:GetValue();
   
    -- ui elements
    settings.showEffectIcon = self.showEffectIconCB:IsChecked();
    settings.showEffectName = self.showEffectNameCB:IsChecked();
    settings.showEffectTimer = self.showEffectTimerCB:IsChecked();
    settings.showEffectTarget = self.showEffectTargetCB:IsChecked();
    settings.showEffectDuration = self.showDurationTimerCB:IsChecked();
    settings.displayFormat = self.formatCombo:GetSelection();
    settings.font = self.fontCombo:GetSelection();
    settings.barWidth = self.widthSlider:GetValue();
    settings.barHeight = self.heightSlider:GetValue();
   
    -- colors
    settings:SetElapsedColorArray(Colors.Flash, self.colors[OptionsEffectPanel.FlashElapsed]);
    settings:SetRemainingColorArray(Colors.Flash, self.colors[OptionsEffectPanel.FlashRemaining]);
    settings:SetElapsedColorArray(Colors.Disease, self.colors[OptionsEffectPanel.DiseaseElapsed]);
    settings:SetRemainingColorArray(Colors.Disease, self.colors[OptionsEffectPanel.DiseaseRemaining]);
    settings:SetElapsedColorArray(Colors.Fear, self.colors[OptionsEffectPanel.FearElapsed]);
    settings:SetRemainingColorArray(Colors.Fear, self.colors[OptionsEffectPanel.FearRemaining]);
    settings:SetElapsedColorArray(Colors.Poison, self.colors[OptionsEffectPanel.PoisonElapsed]);
    settings:SetRemainingColorArray(Colors.Poison, self.colors[OptionsEffectPanel.PoisonRemaining]);
    settings:SetElapsedColorArray(Colors.Wound, self.colors[OptionsEffectPanel.WoundElapsed]);
    settings:SetRemainingColorArray(Colors.Wound, self.colors[OptionsEffectPanel.WoundRemaining]);
    settings:SetElapsedColorArray(Colors.MobDebuff, self.colors[OptionsEffectPanel.MobDebuffElapsed]);
    settings:SetRemainingColorArray(Colors.MobDebuff, self.colors[OptionsEffectPanel.MobDebuffRemaining]);
    settings:SetElapsedColorArray(Colors.MobCrowdControl, self.colors[OptionsEffectPanel.MobCCElapsed]);
    settings:SetRemainingColorArray(Colors.MobCrowdControl, self.colors[OptionsEffectPanel.MobCCRemaining]);
    settings:SetElapsedColorArray(Colors.Corruption, self.colors[OptionsEffectPanel.CorruptionElapsed]);
    settings:SetRemainingColorArray(Colors.Corruption, self.colors[OptionsEffectPanel.CorruptionRemaining]);
    settings:SetElapsedColorArray(Colors.Cry, self.colors[OptionsEffectPanel.CryElapsed]);
    settings:SetRemainingColorArray(Colors.Cry, self.colors[OptionsEffectPanel.CryRemaining]);
    settings:SetElapsedColorArray(Colors.Elemental, self.colors[OptionsEffectPanel.ElementalElapsed]);
    settings:SetRemainingColorArray(Colors.Elemental, self.colors[OptionsEffectPanel.ElementalRemaining]);
    settings:SetElapsedColorArray(Colors.Physical, self.colors[OptionsEffectPanel.PhysicalElapsed]);
    settings:SetRemainingColorArray(Colors.Physical, self.colors[OptionsEffectPanel.PhysicalRemaining]);
    settings:SetElapsedColorArray(Colors.Song, self.colors[OptionsEffectPanel.SongElapsed]);
    settings:SetRemainingColorArray(Colors.Song, self.colors[OptionsEffectPanel.SongRemaining]);
    settings:SetElapsedColorArray(Colors.Undefined, self.colors[OptionsEffectPanel.UndefinedElapsed]);
    settings:SetRemainingColorArray(Colors.Undefined, self.colors[OptionsEffectPanel.UndefinedRemaining]);
    settings:SetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Morale, self.colors[OptionsEffectPanel.MoraleCoolDownElapsed]);
    settings:SetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Morale, self.colors[OptionsEffectPanel.MoraleCoolDownRemaining]);
    settings:SetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Power, self.colors[OptionsEffectPanel.PowerCoolDownElapsed]);
    settings:SetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Power, self.colors[OptionsEffectPanel.PowerCoolDownRemaining]);
    settings:SetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Disease, self.colors[OptionsEffectPanel.DiseaseCoolDownElapsed]);
    settings:SetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Disease, self.colors[OptionsEffectPanel.DiseaseCoolDownRemaining]);
    settings:SetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Fear, self.colors[OptionsEffectPanel.FearCoolDownElapsed]);
    settings:SetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Fear, self.colors[OptionsEffectPanel.FearCoolDownRemaining]);
    settings:SetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Poison, self.colors[OptionsEffectPanel.PoisonCoolDownElapsed]);
    settings:SetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Poison, self.colors[OptionsEffectPanel.PoisonCoolDownRemaining]);
    settings:SetElapsedColorArray(PengorosPlugins.Utils.CoolDownCategory.Wound, self.colors[OptionsEffectPanel.WoundCoolDownElapsed]);
    settings:SetRemainingColorArray(PengorosPlugins.Utils.CoolDownCategory.Wound, self.colors[OptionsEffectPanel.WoundCoolDownRemaining]);

    -- triggers
    settings.triggers = {};
    for i = 1, self.triggerList:GetItemCount(), 1 do
        local item = self.triggerList:GetItem(i);
        table.insert(settings.triggers, item);
    end
end

function OptionsEffectPanel:Destroy()
	if (self._win ~= nil) then
		self._win:Close();
		self._win = nil;
	end
end