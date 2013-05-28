import "Turbine.UI";

OptionsQuickslotPanel = class(Turbine.UI.ListBox);

local holder = function(parent, height)
    local container = Turbine.UI.Control();
    container:SetSize(400, height);
    parent:AddItem(container);
    return container;
end

function OptionsQuickslotPanel:Constructor()
    Turbine.UI.ListBox.Constructor(self);

    self.current = nil;
    self:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self:SetMaxItemsPerLine(1);

    local line = holder(self, 35);
    self.barTitle = PengorosPlugins.UI.PanelDivider();
    self.barTitle:SetParent(line);
    self.barTitle:SetText(L["Quickslot Bars"]);
    self.barTitle:SetSize(400, 30);
    
    line = holder(self, 30);
    self.barLabel = PengorosPlugins.UI.Label();
    self.barLabel:SetParent(line);
    self.barLabel:SetSize(176, 20);
    self.barLabel:SetPosition(20, 0);
    self.barLabel:SetText(L["Bar"]);
    PengorosPlugins.UI.Tooltip(self.barLabel, L["Select the Quickslot Bar you would like to modify."]);
    
    self.barCombo = PengorosPlugins.UI.ComboBox();
    self.barCombo:SetParent(line);
    self.barCombo:SetSize(204, 20);
    self.barCombo:SetPosition(196, 0);
    self.barCombo.SelectedIndexChanged = function(sender, args)
        if (self.current ~= nil) then
            self:SaveBarOptions(self.current);
        end
        if (args.selection ~= nil) then
	        self:SetBarOptions(args.selection);
	        self.current = args.selection;
	    end
    end

    line = holder(self, 30);
    self.newButton  = Turbine.UI.Lotro.Button();
    self.newButton:SetParent(line);
    self.newButton:SetPosition(89, 0);
    self.newButton:SetSize(100, 22);
    self.newButton:SetText(L["New"]);
    PengorosPlugins.UI.Tooltip(self.newButton, L["Create a new Quickslot Bar."]);
    self.newButton.Click = function(sender, args)
        self:AddNewBar();
    end

    self.copyButton  = Turbine.UI.Lotro.Button();
    self.copyButton:SetParent(line);
    self.copyButton:SetPosition(196, 0);
    self.copyButton:SetSize(100, 22);
    self.copyButton:SetText(L["Copy"]);
    PengorosPlugins.UI.Tooltip(self.copyButton, L["Copy the current Quickslot Bar."]);
    self.copyButton.Click = function(sender, args)
        self:CopyCurrentBar();
    end

    self.removeButton  = Turbine.UI.Lotro.Button();
    self.removeButton:SetParent(line);
    self.removeButton:SetPosition(303, 0);
    self.removeButton:SetSize(100, 22);
    self.removeButton:SetText(L["Remove"]);
    PengorosPlugins.UI.Tooltip(self.removeButton, L["Remove the current Quickslot Bar."]);
    self.removeButton.Click = function(sender, args)
        self:RemoveCurrentBar();
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
    PengorosPlugins.UI.Tooltip(self.nameLabel, L["The descriptive name of the current Quickslot Bar."]);
    
    self.nameText = Turbine.UI.Lotro.TextBox();
    self.nameText:SetParent(line);
    self.nameText:SetSize(280, 20);
    self.nameText:SetPosition(120, 0);
    self.nameText:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.nameText:SetMultiline(false);
    self.nameText:SetWantsUpdates(true);
    self.nameText.Update = function(sender, args)
        self.barCombo:UpdateSelectionText(self.nameText:GetText());
    end

    line = holder(self, 25);
    self.showQuickslotCB = PengorosPlugins.UI.CheckBox();
    self.showQuickslotCB:SetParent(line);
    self.showQuickslotCB:SetText(L["Enabled"]);
    self.showQuickslotCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showQuickslotCB, L["When checked, this Quickslot Bar will be enabled."]);

    line = holder(self, 30);
    self.scopeLabel = PengorosPlugins.UI.Label();
    self.scopeLabel:SetParent(line);
    self.scopeLabel:SetSize(190, 20);
    self.scopeLabel:SetPosition(20, 0);
    self.scopeLabel:SetText(L["Load For"]);
    PengorosPlugins.UI.Tooltip(self.scopeLabel, L["Select which characters this Quickslot Bar will be loaded for."]);
    
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
    self.visibleTypeLabel:SetText(L["Show Bar"]);
    PengorosPlugins.UI.Tooltip(self.visibleTypeLabel, L["Select when the bar is visible."]);
    
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
    self.triggerTitle = PengorosPlugins.UI.PanelDivider();
    self.triggerTitle:SetParent(line);
    self.triggerTitle:SetText(L["Triggers"]);
    self.triggerTitle:SetSize(400, 30);

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
end

function OptionsQuickslotPanel:AddNewBar()
    local bar = QuickslotSettings();
    bar.name = L["New Quickslot"];
    self.barCombo:AddItem(bar.name, bar);
    self.barCombo:SetSelection(bar);
    self:EnableControls(true);
end

function OptionsQuickslotPanel:CopyCurrentBar()
    self:SaveBarOptions(self.current); -- make sure the options are up to date 
    local bar = self.current:Copy();
    bar.name = bar.name .. " - " .. L["Copy"];
    self.barCombo:AddItem(bar.name, bar);
    self.barCombo:SetSelection(bar);
    self:EnableControls(true);
end

function OptionsQuickslotPanel:RemoveCurrentBar()
    self.barCombo:RemoveItem(self.current);
    self:EnableControls(self.barCombo:GetItemCount() > 0);
end

function OptionsQuickslotPanel:EnableControls(enable)
    self.barCombo:SetEnabled(enable);
    self.copyButton:SetEnabled(enable);
    self.removeButton:SetEnabled(enable);
    self.nameLabel:SetEnabled(enable);
    self.nameText:SetEnabled(enable);
    self.showQuickslotCB:SetEnabled(enable);
    self.scopeLabel:SetEnabled(enable);
    self.scopeCombo:SetEnabled(enable);
    self.visibleTypeLabel:SetEnabled(enable);
    self.visibleTypeCombo:SetEnabled(enable);
    self.triggerList:SetEnabled(enable);
end

function OptionsQuickslotPanel:TriggerSelected(selection)
    self.editTriggerButton:SetEnabled(selection ~= nil);
    self.deleteTriggerButton:SetEnabled(selection ~= nil);
    self.moveUpTriggerButton:SetEnabled(self.triggerList:CanMoveSelectionUp());
    self.moveDownTriggerButton:SetEnabled(self.triggerList:CanMoveSelectionDown());
end

function OptionsQuickslotPanel:AddTrigger()
    self._win = TriggerWindow();
    PengorosPlugins.Utils.AddListener(self._win, "Closed", function(sender, args)
        local trigger = self._win:GetTrigger();
        if (trigger ~= nil) then
            self.triggerList:AddItem(trigger:GetOptionName(), trigger);
        end
        self._win = nil;
    end);
    
    self._win:SetOptions(Trigger({name=L["new trigger"], template=nil}));
    PengorosPlugins.Utils.ModalWindow(self._win, OptionsPanel.instance);
end

function OptionsQuickslotPanel:EditTrigger()
    self._win = TriggerWindow();
    PengorosPlugins.Utils.AddListener(self._win, "Closed", function(sender, args)
        local trigger = self._win:GetTrigger();
        if (trigger ~= nil) then
            self.triggerList:UpdateSelection(trigger:GetOptionName(), trigger);
        end
        self._win = nil;
    end);

    self._win:SetOptions(self.triggerList:GetSelection());
    PengorosPlugins.Utils.ModalWindow(self._win, OptionsPanel.instance);
end

function OptionsQuickslotPanel:DeleteTrigger()
    self.triggerList:RemoveItem(self.triggerList:GetSelection());
end

function OptionsQuickslotPanel:SetOptions()
	-- reset
	self.current = nil;
	self.barCombo:ClearItems();

    -- bars
    local quickslots = Settings.GetQuickslots();
    for i = 1, #quickslots do
        local bar = quickslots[i]:Copy();
        self.barCombo:AddItem(bar.name, bar);
    end
    
    if (#quickslots > 0) then
        self.barCombo:SetSelection(self.barCombo:GetItem(1));
        self:EnableControls(true);
    else
        self:EnableControls(false);
    end
end

function OptionsQuickslotPanel:SaveOptions()
    -- save the current bar settings
    if (self.current ~= nil) then
        self:SaveBarOptions(self.current);
    end
    
    -- collect all the bars into an array
    local bars = {};
    for i = 1, self.barCombo:GetItemCount() do
        bars[i] = self.barCombo:GetItem(i);
    end
    
    -- overwrite the existing quickslots
    Settings.SetQuickslots(bars);
end

function OptionsQuickslotPanel:SetBarOptions(settings)
    -- quickslots
    self.nameText:SetText(settings.name);
    self.showQuickslotCB:SetChecked(settings.enabled);
    self.scopeCombo:SetSelection(settings.scope);
    self.visibleTypeCombo:SetSelection(settings.visibleType);
    
    -- effect triggers
    self.triggerList:ClearItems();
    for i = 1, table.getn(settings.triggers), 1 do
        self.triggerList:AddItem(settings.triggers[i]:GetOptionName(), settings.triggers[i]);
    end
end

function OptionsQuickslotPanel:SaveBarOptions(settings)
    -- quickslots
    settings.name = self.nameText:GetText();
    settings.enabled = self.showQuickslotCB:IsChecked();
    settings.scope = self.scopeCombo:GetSelection();
    settings.visibleType = self.visibleTypeCombo:GetSelection();
    
    -- triggers
    settings.triggers = {};
    for i = 1, self.triggerList:GetItemCount(), 1 do
        local item = self.triggerList:GetItem(i);
        table.insert(settings.triggers, item);
    end
end

function OptionsQuickslotPanel:Destroy()
	if (self._win ~= nil) then
		self._win:Close();
		self._win = nil;
	end
end