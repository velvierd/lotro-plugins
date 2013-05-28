import "Turbine.Gameplay";
import "Turbine.UI";
import "PengorosPlugins.BuffBars";
import "PengorosPlugins.UI";

TriggerWindow = class(Turbine.UI.Lotro.Window);

local holder = function(parent, height)
    local container = Turbine.UI.Control();
    container:SetSize(276, height);
    parent:AddItem(container);
    return container;
end

local setShortcut = function(quickslot, shortcutType, shortcutData)
    pcall(function()
        if (shortcutData ~= "") then
            local shortcut = Turbine.UI.Lotro.Shortcut(shortcutType, shortcutData);
            quickslot:SetShortcut(shortcut);
        end
    end);
end

function TriggerWindow:Constructor()
    Turbine.UI.Lotro.Window.Constructor(self);
    
    self:SetText(L["Trigger"]);
    self:SetVisible(false);
    self:SetSize(300, 490);
    self.Closed = function(sender, args)
        -- save the position
        Settings.GetAccount().triggerX, Settings.GetAccount().triggerY = self:GetPosition();
        Settings.Save();
        
        -- cleanup
        PengorosPlugins.Utils.KeyManager.RemoveListener(self);
        self:Destroy();
    end

    -- restore the position if there is one
    if (Settings.GetAccount().triggerX ~= nil) then
        self:SetPosition(PengorosPlugins.Utils.ValidatePosition(Settings.GetAccount().triggerX, Settings.GetAccount().triggerY, self:GetWidth(), self:GetHeight()));
    end
    
    -- listen for events
    PengorosPlugins.Utils.KeyManager.AddListener(self);

    self.cancelButton = Turbine.UI.Lotro.Button();
    self.cancelButton:SetParent(self);
    self.cancelButton:SetPosition(45, 460);
    self.cancelButton:SetSize(100, 22);
    self.cancelButton:SetText(L["Cancel"]);
    self.cancelButton.Click = function(sender, args)
        self:Close();
    end

    self.acceptButton  = Turbine.UI.Lotro.Button();
    self.acceptButton:SetParent(self);
    self.acceptButton:SetPosition(155, 460);
    self.acceptButton:SetSize(100, 22);
    self.acceptButton:SetText(L["Accept"]);
    self.acceptButton.Click = function(sender, args)
        self:SaveOptions();
        self:Close();
    end

    self.scrollBar = Turbine.UI.Lotro.ScrollBar();
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.scrollBar:SetParent(self);
    self.scrollBar:SetSize(10, 410);
    self.scrollBar:SetPosition(283, 45);

    self.listBox = Turbine.UI.ListBox();
    self.listBox:SetParent(self);
    self.listBox:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.listBox:SetVerticalScrollBar(self.scrollBar);
    self.listBox:SetMaxItemsPerLine(1);
    self.listBox:SetSize(276, 410);
    self.listBox:SetPosition(7, 45);
    
    -- controls
    local line = holder(self.listBox, 35);
    self.infoLabel = PengorosPlugins.UI.Label();
    self.infoLabel:SetParent(line);
    self.infoLabel:SetSize(266, 35);
    self.infoLabel:SetPosition(5, 0);
    self.infoLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.infoLabel:SetText(L["Select a predefined template or create a custom trigger."]);
    
    line = holder(self.listBox, 30);
    self.templateLabel = PengorosPlugins.UI.Label();
    self.templateLabel:SetParent(line);
    self.templateLabel:SetSize(70, 20);
    self.templateLabel:SetPosition(0, 0);
    self.templateLabel:SetText(L["Template"]);
    PengorosPlugins.UI.Tooltip(self.templateLabel, L["Select a template."]);
    
    self.templateCombo = PengorosPlugins.UI.ComboBox();
    self.templateCombo:SetParent(line);
    self.templateCombo:SetSize(196, 20);
    self.templateCombo:SetPosition(80, 0);
    self.templateCombo:AddItem(L["Curable Disease"], TriggerTemplate.Disease);
    self.templateCombo:AddItem(L["Curable Fear"], TriggerTemplate.Fear);
    self.templateCombo:AddItem(L["Curable Poison"], TriggerTemplate.Poison);
    self.templateCombo:AddItem(L["Curable Wound"], TriggerTemplate.Wound);
    self.templateCombo:AddItem(L["Morale Level"], TriggerTemplate.Morale);
    self.templateCombo:AddItem(L["Power Level"], TriggerTemplate.Power);
    self.templateCombo:AddItem(L["Custom"], TriggerTemplate.Custom);
    self.templateCombo.SelectedIndexChanged = function(sender, args)
        if (args.selection ~= nil) then
            TriggerWindow.TemplateMap[args.selection](self);
        end
    end

    line = holder(self.listBox, 35);
    self.matchCriteriaTitle = PengorosPlugins.UI.PanelDivider();
    self.matchCriteriaTitle:SetParent(line);
    self.matchCriteriaTitle:SetText(L["General"]);
    self.matchCriteriaTitle:SetSize(400, 30);
    self.matchCriteriaTitle:SetPosition(-62, 0);

    line = holder(self.listBox, 30);
    self.nameLabel = PengorosPlugins.UI.Label();
    self.nameLabel:SetParent(line);
    self.nameLabel:SetSize(70, 20);
    self.nameLabel:SetPosition(0, 0);
    self.nameLabel:SetText(L["Name"]);
    PengorosPlugins.UI.Tooltip(self.nameLabel, L["The name of this effect trigger (required)."]);
    
    self.nameText = Turbine.UI.Lotro.TextBox();
    self.nameText:SetParent(line);
    self.nameText:SetSize(196, 20);
    self.nameText:SetPosition(80, 0);
    self.nameText:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.nameText:SetMultiline(false);
    self.nameText:SetWantsUpdates(true);
    self.nameText.Update = function(sender, args)
    	self.acceptButton:SetEnabled(self.nameText:GetTextLength() > 0);
    end

    line = holder(self.listBox, 30);
    self.triggerLabel = PengorosPlugins.UI.Label();
    self.triggerLabel:SetParent(line);
    self.triggerLabel:SetSize(70, 20);
    self.triggerLabel:SetPosition(0, 0);
    self.triggerLabel:SetText(L["Trigger"]);
    PengorosPlugins.UI.Tooltip(self.triggerLabel, L["Select the trigger type."]);
    
    self.triggerCombo = PengorosPlugins.UI.ComboBox();
    self.triggerCombo:SetParent(line);
    self.triggerCombo:SetSize(196, 20);
    self.triggerCombo:SetPosition(80, 0);
    self.triggerCombo:AddItem(L["Effect"], TriggerType.Effect);
    self.triggerCombo:AddItem(L["Level"], TriggerType.Level);
    self.triggerCombo.SelectedIndexChanged = function(sender, args)
        if (args.selection ~= nil) then
            TriggerWindow.TypeMap[args.selection](self);
        end
    end
    
    line = holder(self.listBox, 35);
    self.matchCriteriaTitle = PengorosPlugins.UI.PanelDivider();
    self.matchCriteriaTitle:SetParent(line);
    self.matchCriteriaTitle:SetText(L["Match Criteria"]);
    self.matchCriteriaTitle:SetSize(400, 30);
    self.matchCriteriaTitle:SetPosition(-62, 0);

    -- effect criteria
    line = holder(self.listBox, 30);
    self.matchLabel = PengorosPlugins.UI.Label();
    self.matchLabel:SetParent(line);
    self.matchLabel:SetSize(70, 20);
    self.matchLabel:SetPosition(0, 0);
    self.matchLabel:SetText(L["Search"]);
    PengorosPlugins.UI.Tooltip(self.matchLabel, L["Optional.  The name of the effect to match.  It can be a partial string.  For example \"wound\" will match any effect with wound in the name.  The matches are not case sensitive."]);
    
    self.matchText = Turbine.UI.Lotro.TextBox();
    self.matchText:SetParent(line);
    self.matchText:SetSize(196, 20);
    self.matchText:SetPosition(80, 0);
    self.matchText:SetFont(Turbine.UI.Lotro.Font.Verdana14);
    self.matchText:SetMultiline(false);

    line = holder(self.listBox, 30);
    self.categoryLabel = PengorosPlugins.UI.Label();
    self.categoryLabel:SetParent(line);
    self.categoryLabel:SetSize(70, 20);
    self.categoryLabel:SetPosition(0, 0);
    self.categoryLabel:SetText(L["Category"]);
    PengorosPlugins.UI.Tooltip(self.categoryLabel, L["Select the category of the effect."]);
    
    self.categoryCombo = PengorosPlugins.UI.ComboBox();
    self.categoryCombo:SetParent(line);
    self.categoryCombo:SetSize(196, 20);
    self.categoryCombo:SetPosition(80, 0);
    self.categoryCombo:AddItem(L["All"], nil);
    self.categoryCombo:AddItem(L["Disease"], Turbine.Gameplay.EffectCategory.Disease);
    self.categoryCombo:AddItem(L["Fear"], Turbine.Gameplay.EffectCategory.Fear);
    self.categoryCombo:AddItem(L["Poison"], Turbine.Gameplay.EffectCategory.Poison);
    self.categoryCombo:AddItem(L["Wound"], Turbine.Gameplay.EffectCategory.Wound);
    self.categoryCombo:AddItem(L["Corruption"], Turbine.Gameplay.EffectCategory.Corruption);
    self.categoryCombo:AddItem(L["Cry"], Turbine.Gameplay.EffectCategory.Cry);
    self.categoryCombo:AddItem(L["Elemental"], Turbine.Gameplay.EffectCategory.Elemental);
    self.categoryCombo:AddItem(L["Physical"], Turbine.Gameplay.EffectCategory.Physical);
    self.categoryCombo:AddItem(L["Song"], Turbine.Gameplay.EffectCategory.Song);
    self.categoryCombo:AddItem(L["Undefined"], Turbine.Gameplay.EffectCategory.Undefined);
    self.categoryCombo:SetSelection(nil); -- make sure there is always a selection
    
    line = holder(self.listBox, 30);
    self.hasEffectLabel = PengorosPlugins.UI.Label();
    self.hasEffectLabel:SetParent(line);
    self.hasEffectLabel:SetSize(150, 20);
    self.hasEffectLabel:SetPosition(0, 0);
    self.hasEffectLabel:SetText(L["When the effect is"]);
    PengorosPlugins.UI.Tooltip(self.hasEffectLabel, L["Select if this trigger will match when the effect is present or not present."]);
    
    self.hasEffectCombo = PengorosPlugins.UI.ComboBox();
    self.hasEffectCombo:SetParent(line);
    self.hasEffectCombo:SetSize(116, 20);
    self.hasEffectCombo:SetPosition(160, 0);
    self.hasEffectCombo:AddItem(L["Present"], true);
    self.hasEffectCombo:AddItem(L["Not Present"], false);
    self.hasEffectCombo:SetSelection(true); -- make sure there is always a selection

    line = holder(self.listBox, 30);
    self.isCurableCB = PengorosPlugins.UI.CheckBox();
    self.isCurableCB:SetParent(line);
    self.isCurableCB:SetText(L["When the effect is curable"]);
    self.isCurableCB:SetSize(276, 20);
    PengorosPlugins.UI.Tooltip(self.isCurableCB, L["When checked only match if the effect is curable."]);

    -- level criteria
    line = holder(self.listBox, 30);
    self.typeLabel = PengorosPlugins.UI.Label();
    self.typeLabel:SetParent(line);
    self.typeLabel:SetSize(70, 20);
    self.typeLabel:SetPosition(0, 0);
    self.typeLabel:SetText(L["Type"]);
    PengorosPlugins.UI.Tooltip(self.typeLabel, L["Select the level type."]);
    
    self.typeCombo = PengorosPlugins.UI.ComboBox();
    self.typeCombo:SetParent(line);
    self.typeCombo:SetSize(196, 20);
    self.typeCombo:SetPosition(80, 0);
    self.typeCombo:AddItem(L["Morale"], TriggerLevel.Morale);
    self.typeCombo:AddItem(L["Power"], TriggerLevel.Power);
    self.typeCombo:SetSelection(TriggerLevel.Morale); -- make sure it always has a selection
    
    line = holder(self.listBox, 90);
    self.slider = PengorosPlugins.UI.Slider();
    self.slider:SetParent(line);
    self.slider:SetText(L["Threshold"]);
    self.slider:SetPosition(10, 0);
    self.slider:SetSize(266, 40);
    self.slider:SetStep(1);
    self.slider:SetMin(0);
    self.slider:SetMax(100);
    self.slider:SetValue(0); -- default value
    PengorosPlugins.UI.Tooltip(self.slider.label, L["Adjust the level threshold.  When your level drops below this percent the quickslot will appear."]);

    line = holder(self.listBox, 35);
    self.quickslotTitle = PengorosPlugins.UI.PanelDivider();
    self.quickslotTitle:SetParent(line);
    self.quickslotTitle:SetText(L["Quickslot"]);
    self.quickslotTitle:SetSize(400, 30);
    self.quickslotTitle:SetPosition(-62, 0);
    
    line = holder(self.listBox, 40);
    self.quickslot = Turbine.UI.Lotro.Quickslot();
    self.quickslot:SetParent(line);
    self.quickslot:SetSize(36, 36);
    self.quickslot:SetPosition(120, 0);
    
    line = holder(self.listBox, 20);
    self.responseLabel = PengorosPlugins.UI.Label();
    self.responseLabel:SetParent(line);
    self.responseLabel:SetSize(276, 20);
    self.responseLabel:SetPosition(0, 0);
    self.responseLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter);
    self.responseLabel:SetText(L["Response"]);
    PengorosPlugins.UI.Tooltip(self.responseLabel, L["Drag an item here to make a shortcut that will be shown when this trigger is matched."]);
end

function TriggerWindow:EnableEffect(enabled)
    self.nameText:SetEnabled(enabled);
    self.nameLabel:SetEnabled(enabled);
    self.triggerCombo:SetEnabled(enabled);
    self.triggerLabel:SetEnabled(enabled);
    self.matchText:SetEnabled(enabled);
    self.matchLabel:SetEnabled(enabled);
    self.categoryCombo:SetEnabled(enabled);
    self.categoryLabel:SetEnabled(enabled);
    self.hasEffectCombo:SetEnabled(enabled);
    self.hasEffectLabel:SetEnabled(enabled);
    self.isCurableCB:SetEnabled(enabled);
end

function TriggerWindow:EnableLevel(enabled)
    self.nameText:SetEnabled(enabled);
    self.nameLabel:SetEnabled(enabled);
    self.triggerCombo:SetEnabled(enabled);
    self.triggerLabel:SetEnabled(enabled);
    self.typeLabel:SetEnabled(enabled);
    self.typeCombo:SetEnabled(enabled);
    --self.slider:SetEnabled(enabled);
end

function TriggerWindow:EffectTrigger()
    self.typeLabel:GetParent():SetHeight(0);
    self.slider:GetParent():SetHeight(0);

    self.matchLabel:GetParent():SetHeight(30);
    self.categoryLabel:GetParent():SetHeight(30);
    self.hasEffectLabel:GetParent():SetHeight(30);
    self.isCurableCB:GetParent():SetHeight(30);
end

function TriggerWindow:LevelTrigger()
    self.matchLabel:GetParent():SetHeight(0);
    self.categoryLabel:GetParent():SetHeight(0);
    self.hasEffectLabel:GetParent():SetHeight(0);
    self.isCurableCB:GetParent():SetHeight(0);
    
    self.typeLabel:GetParent():SetHeight(30);
    self.slider:GetParent():SetHeight(90);
end

function TriggerWindow:TemplateDisease()
    self.nameText:SetText(L["Disease"]);
    self.triggerCombo:SetSelection(TriggerType.Effect);
    self.matchText:SetText("");
    self.categoryCombo:SetSelection(Turbine.Gameplay.EffectCategory.Disease);
    self.hasEffectCombo:SetSelection(true);
    self.isCurableCB:SetChecked(true);
    self:EnableEffect(false);
end

function TriggerWindow:TemplateFear()
    self.nameText:SetText(L["Fear"]);
    self.triggerCombo:SetSelection(TriggerType.Effect);
    self.matchText:SetText("");
    self.categoryCombo:SetSelection(Turbine.Gameplay.EffectCategory.Fear);
    self.hasEffectCombo:SetSelection(true);
    self.isCurableCB:SetChecked(true);
    self:EnableEffect(false);
end

function TriggerWindow:TemplatePoison()
    self.nameText:SetText(L["Poison"]);
    self.triggerCombo:SetSelection(TriggerType.Effect);
    self.matchText:SetText("");
    self.categoryCombo:SetSelection(Turbine.Gameplay.EffectCategory.Poison);
    self.hasEffectCombo:SetSelection(true);
    self.isCurableCB:SetChecked(true);
    self:EnableEffect(false);
end

function TriggerWindow:TemplateWound()
    self.nameText:SetText(L["Wound"]);
    self.triggerCombo:SetSelection(TriggerType.Effect);
    self.matchText:SetText("");
    self.categoryCombo:SetSelection(Turbine.Gameplay.EffectCategory.Wound);
    self.hasEffectCombo:SetSelection(true);
    self.isCurableCB:SetChecked(true);
    self:EnableEffect(false);
end

function TriggerWindow:TemplateMorale()
    self.nameText:SetText(L["Morale"]);
    self.triggerCombo:SetSelection(TriggerType.Level);
    self.typeCombo:SetSelection(TriggerLevel.Morale);
    self.slider:SetValue(30);
    self:EnableLevel(false);
end

function TriggerWindow:TemplatePower()
    self.nameText:SetText(L["Power"]);
    self.triggerCombo:SetSelection(TriggerType.Level);
    self.typeCombo:SetSelection(TriggerLevel.Power);
    self.slider:SetValue(30);
    self:EnableLevel(false);
end

function TriggerWindow:TemplateCustom()
    self:EnableEffect(true);
    self:EnableLevel(true);
end

function TriggerWindow:SetOptions(trigger)
    if (trigger.template == nil) then
        -- new trigger
        self.triggerCombo:SetSelection(TriggerType.Effect);
        self:EnableEffect(false);
        self:EnableLevel(false);
    else
        self.templateCombo:SetSelection(trigger.template);
        self.triggerCombo:SetSelection(trigger.triggerType);
        self.nameText:SetText(trigger.name);
        self.shortcuts = trigger.shortcuts;
    
        if (trigger.triggerType == TriggerType.Effect) then
            self.matchText:SetText(PengorosPlugins.Utils.UnescapeMatch(trigger.match));
            self.categoryCombo:SetSelection(trigger.category);
            self.hasEffectCombo:SetSelection(trigger.hasEffect);
            self.isCurableCB:SetChecked(trigger.isCurable);
        else
            self.typeCombo:SetSelection(trigger.level);
            self.slider:SetValue(trigger.threshold * 100);
        end
        
        setShortcut(self.quickslot, trigger:GetShortcutType(), trigger:GetShortcutData());
    end
end

function TriggerWindow:SaveOptions()
    local values = {};

    values.name = self.nameText:GetText();
    values.triggerType = self.triggerCombo:GetSelection();
    values.template = self.templateCombo:GetSelection();
    values.shortcuts = self.shortcuts;
    
    if (values.triggerType == TriggerType.Effect) then
        values.match = PengorosPlugins.Utils.EscapeMatch(self.matchText:GetText());
        values.category = self.categoryCombo:GetSelection();
        values.hasEffect = self.hasEffectCombo:GetSelection();
        values.isCurable = self.isCurableCB:IsChecked();
    else
        values.level = self.typeCombo:GetSelection();
        values.threshold = self.slider:GetValue() / 100;
    end
    
    self.trigger = Trigger(values);
    
    local shortcut = self.quickslot:GetShortcut();
    if (shortcut:GetData() ~= "") then
        self.trigger:SetShortcut(shortcut);
    end
    
end

function TriggerWindow:GetTrigger()
    return self.trigger;
end

function TriggerWindow:Destroy()
    self.quickslot:SetShortcut(nil);
end

function TriggerWindow:UiHidden(hidden)
    self:SetVisible(not hidden);
end

function TriggerWindow:EscapePressed()
    self:Close();
end

TriggerWindow.TemplateMap = {};
TriggerWindow.TemplateMap[TriggerTemplate.Custom] = TriggerWindow.TemplateCustom;
TriggerWindow.TemplateMap[TriggerTemplate.Disease] = TriggerWindow.TemplateDisease;
TriggerWindow.TemplateMap[TriggerTemplate.Fear] = TriggerWindow.TemplateFear;
TriggerWindow.TemplateMap[TriggerTemplate.Poison] = TriggerWindow.TemplatePoison;
TriggerWindow.TemplateMap[TriggerTemplate.Wound] = TriggerWindow.TemplateWound;
TriggerWindow.TemplateMap[TriggerTemplate.Morale] = TriggerWindow.TemplateMorale;
TriggerWindow.TemplateMap[TriggerTemplate.Power] = TriggerWindow.TemplatePower;

TriggerWindow.TypeMap = {};
TriggerWindow.TypeMap[TriggerType.Effect] = TriggerWindow.EffectTrigger;
TriggerWindow.TypeMap[TriggerType.Level] = TriggerWindow.LevelTrigger;
