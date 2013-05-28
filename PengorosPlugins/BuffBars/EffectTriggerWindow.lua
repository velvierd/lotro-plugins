import "Turbine.Gameplay";
import "Turbine.UI";
import "PengorosPlugins.BuffBars";
import "PengorosPlugins.UI";

EffectTriggerWindow = class(Turbine.UI.Lotro.Window);

local holder = function(parent, height)
    local container = Turbine.UI.Control();
    container:SetSize(276, height);
    parent:AddItem(container);
    return container;
end

function EffectTriggerWindow:Constructor()
    Turbine.UI.Lotro.Window.Constructor(self);
    
    self:SetText(L["Effect Trigger"]);
    self:SetVisible(false);
    self:SetSize(300, 495);
    self.Closed = function(sender, args)
        -- save the position
        Settings.GetAccount().effectTriggerX, Settings.GetAccount().effectTriggerY = self:GetPosition();
        Settings.Save();
        
        -- cleanup
        PengorosPlugins.Utils.KeyManager.RemoveListener(self);
        self:Destroy();
    end

    -- restore the position if there is one
    if (Settings.GetAccount().effectTriggerX ~= nil) then
        self:SetPosition(PengorosPlugins.Utils.ValidatePosition(Settings.GetAccount().effectTriggerX, Settings.GetAccount().effectTriggerY, self:GetWidth(), self:GetHeight()));
    end
    
    -- listen for events
    PengorosPlugins.Utils.KeyManager.AddListener(self);

    self.cancelButton = Turbine.UI.Lotro.Button();
    self.cancelButton:SetParent(self);
    self.cancelButton:SetPosition(45, 465);
    self.cancelButton:SetSize(100, 22);
    self.cancelButton:SetText(L["Cancel"]);
    self.cancelButton.Click = function(sender, args)
        self:Close();
    end

    self.acceptButton  = Turbine.UI.Lotro.Button();
    self.acceptButton:SetParent(self);
    self.acceptButton:SetPosition(155, 465);
    self.acceptButton:SetSize(100, 22);
    self.acceptButton:SetText(L["Accept"]);
    self.acceptButton.Click = function(sender, args)
        self:SaveOptions();
        self:Close();
    end

    self.scrollBar = Turbine.UI.Lotro.ScrollBar();
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.scrollBar:SetParent(self);
    self.scrollBar:SetSize(10, 415);
    self.scrollBar:SetPosition(283, 45);

    self.listBox = Turbine.UI.ListBox();
    self.listBox:SetParent(self);
    self.listBox:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.listBox:SetVerticalScrollBar(self.scrollBar);
    self.listBox:SetMaxItemsPerLine(1);
    self.listBox:SetSize(276, 415);
    self.listBox:SetPosition(7, 45);
    
    -- controls
    local line = holder(self.listBox, 35);
    self.infoLabel = PengorosPlugins.UI.Label();
    self.infoLabel:SetParent(line);
    self.infoLabel:SetSize(266, 35);
    self.infoLabel:SetPosition(5, 0);
    self.infoLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.infoLabel:SetText(L["Select a predefined template or create a custom effect trigger."]);
    
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
    self.templateCombo:AddItem(L["All Debuffs"], EffectTriggerTemplate.AllDebuffs);
    self.templateCombo:AddItem(L["All Curable Debuffs"], EffectTriggerTemplate.AllCurableDebuffs);
    self.templateCombo:AddItem(L["All Buffs"], EffectTriggerTemplate.AllBuffs);
    self.templateCombo:AddItem(L["All Cool Downs"], EffectTriggerTemplate.AllCoolDowns);
    self.templateCombo:AddItem(L["All Mob Debuffs"], EffectTriggerTemplate.AllMobDebuffs);
    self.templateCombo:AddItem(L["All Mob CC"], EffectTriggerTemplate.AllMobCrowdControl);
    self.templateCombo:AddItem(L["Custom"], EffectTriggerTemplate.Custom);
    self.templateCombo.SelectedIndexChanged = function(sender, args)
        if (args.selection ~= nil) then
            EffectTriggerWindow.TemplateMap[args.selection](self);
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
    self.typeLabel = PengorosPlugins.UI.Label();
    self.typeLabel:SetParent(line);
    self.typeLabel:SetSize(70, 20);
    self.typeLabel:SetPosition(0, 0);
    self.typeLabel:SetText(L["Type"]);
    PengorosPlugins.UI.Tooltip(self.typeLabel, L["Select the effect type."]);
    
    self.typeCombo = PengorosPlugins.UI.ComboBox();
    self.typeCombo:SetParent(line);
    self.typeCombo:SetSize(196, 20);
    self.typeCombo:SetPosition(80, 0);
    self.typeCombo:AddItem(L["Debuff"], EffectTriggerType.Debuff);
    self.typeCombo:AddItem(L["Buff"], EffectTriggerType.Buff);
    self.typeCombo:AddItem(L["Cool Down"], EffectTriggerType.CoolDown);
    self.typeCombo:AddItem(L["Mob Debuff"], EffectTriggerType.MobDebuff);
    self.typeCombo:AddItem(L["Mob CC"], EffectTriggerType.MobCrowdControl);
    self.typeCombo.SelectedIndexChanged = function(sender, args)
        if (args.selection ~= nil) then
            EffectTriggerWindow.TypeMap[args.selection](self);
        end
    end
    
    line = holder(self.listBox, 30);
    self.blacklistCB = PengorosPlugins.UI.CheckBox();
    self.blacklistCB:SetParent(line);
    self.blacklistCB:SetText(L["Blacklist"]);
    self.blacklistCB:SetSize(276, 20);
    PengorosPlugins.UI.Tooltip(self.blacklistCB, L["When checked, blacklist the effect if it matches."]);
    
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
    self.isCurableCB = PengorosPlugins.UI.CheckBox();
    self.isCurableCB:SetParent(line);
    self.isCurableCB:SetText(L["When the effect is curable"]);
    self.isCurableCB:SetSize(276, 20);
    PengorosPlugins.UI.Tooltip(self.isCurableCB, L["When checked, only match if the effect is curable."]);

    line = holder(self.listBox, 50);
    self.minDurationSlider = PengorosPlugins.UI.Slider();
    self.minDurationSlider:SetParent(line);
    self.minDurationSlider:SetText(L["Minimum Duration (seconds)"]);
    self.minDurationSlider:SetPosition(10, 0);
    self.minDurationSlider:SetSize(266, 40);
    self.minDurationSlider:SetStep(1);
    self.minDurationSlider:SetMin(0);
    self.minDurationSlider:SetMax(3600);
    self.minDurationSlider:SetValue(0); -- default value
    PengorosPlugins.UI.Tooltip(self.minDurationSlider.label, L["Effects shorter than this will not be shown.  Set to 0 to disable."]);

    line = holder(self.listBox, 50);
    self.maxDurationSlider = PengorosPlugins.UI.Slider();
    self.maxDurationSlider:SetParent(line);
    self.maxDurationSlider:SetText(L["Maximum Duration (seconds)"]);
    self.maxDurationSlider:SetPosition(10, 0);
    self.maxDurationSlider:SetSize(266, 40);
    self.maxDurationSlider:SetStep(1);
    self.maxDurationSlider:SetMin(0);
    self.maxDurationSlider:SetMax(3600);
    self.maxDurationSlider:SetValue(0); -- default value
    PengorosPlugins.UI.Tooltip(self.maxDurationSlider.label, L["Effects longer than this will not be shown.  Set to 0 to disable."]);

    line = holder(self.listBox, 30);
    self.potCategoryLabel = PengorosPlugins.UI.Label();
    self.potCategoryLabel:SetParent(line);
    self.potCategoryLabel:SetSize(70, 20);
    self.potCategoryLabel:SetPosition(0, 0);
    self.potCategoryLabel:SetText(L["Category"]);
    PengorosPlugins.UI.Tooltip(self.potCategoryLabel, L["Select the category of the pot."]);
    
    self.potCategoryCombo = PengorosPlugins.UI.ComboBox();
    self.potCategoryCombo:SetParent(line);
    self.potCategoryCombo:SetSize(196, 20);
    self.potCategoryCombo:SetPosition(80, 0);
    self.potCategoryCombo:AddItem(L["All"], nil);
    self.potCategoryCombo:AddItem(L["Disease"], PengorosPlugins.Utils.CoolDownCategory.Disease);
    self.potCategoryCombo:AddItem(L["Fear"], PengorosPlugins.Utils.CoolDownCategory.Fear);
    self.potCategoryCombo:AddItem(L["Poison"], PengorosPlugins.Utils.CoolDownCategory.Poison);
    self.potCategoryCombo:AddItem(L["Wound"], PengorosPlugins.Utils.CoolDownCategory.Wound);
    self.potCategoryCombo:AddItem(L["Morale"], PengorosPlugins.Utils.CoolDownCategory.Morale);
    self.potCategoryCombo:AddItem(L["Power"], PengorosPlugins.Utils.CoolDownCategory.Power);
    self.potCategoryCombo:SetSelection(nil); -- make sure there is always a selection
end

function EffectTriggerWindow:EnableEffect(enabled)
    self.nameLabel:SetEnabled(enabled);
    self.nameText:SetEnabled(enabled);
    self.typeLabel:SetEnabled(enabled);
    self.typeCombo:SetEnabled(enabled);
    self.blacklistCB:SetEnabled(enabled);
    self.matchLabel:SetEnabled(enabled);
    self.matchText:SetEnabled(enabled);
    self.categoryLabel:SetEnabled(enabled);
    self.categoryCombo:SetEnabled(enabled);
    self.isCurableCB:SetEnabled(enabled);
    self.minDurationSlider:SetEnabled(enabled);
    self.maxDurationSlider:SetEnabled(enabled);
end

function EffectTriggerWindow:EnableCoolDown(enabled)
    self.nameLabel:SetEnabled(enabled);
    self.nameText:SetEnabled(enabled);
    self.typeLabel:SetEnabled(enabled);
    self.typeCombo:SetEnabled(enabled);
    self.blacklistCB:SetEnabled(enabled);
    self.potCategoryLabel:SetEnabled(enabled);
    self.potCategoryCombo:SetEnabled(enabled);
end

function EffectTriggerWindow:DebuffTrigger()
    self.matchLabel:GetParent():SetHeight(30);
    self.categoryLabel:GetParent():SetHeight(30);
    self.isCurableCB:GetParent():SetHeight(30);
    self.minDurationSlider:GetParent():SetHeight(50);
    self.maxDurationSlider:GetParent():SetHeight(50);

    self.potCategoryCombo:GetParent():SetHeight(0);
end

function EffectTriggerWindow:BuffTrigger()
    self.matchLabel:GetParent():SetHeight(30);
    self.categoryLabel:GetParent():SetHeight(30);
    self.minDurationSlider:GetParent():SetHeight(50);
    self.maxDurationSlider:GetParent():SetHeight(50);

    self.isCurableCB:GetParent():SetHeight(0);
    self.potCategoryCombo:GetParent():SetHeight(0);
end

function EffectTriggerWindow:CoolDownTrigger()
    self.potCategoryCombo:GetParent():SetHeight(30);

    self.matchLabel:GetParent():SetHeight(0);
    self.categoryLabel:GetParent():SetHeight(0);
    self.isCurableCB:GetParent():SetHeight(0);
    self.minDurationSlider:GetParent():SetHeight(0);
    self.maxDurationSlider:GetParent():SetHeight(0);
end

function EffectTriggerWindow:MobDebuffTrigger()
    self.matchLabel:GetParent():SetHeight(30);
    self.minDurationSlider:GetParent():SetHeight(50);
    self.maxDurationSlider:GetParent():SetHeight(50);

    self.potCategoryCombo:GetParent():SetHeight(0);
    self.categoryLabel:GetParent():SetHeight(0);
    self.isCurableCB:GetParent():SetHeight(0);
end

function EffectTriggerWindow:MobCrowdControlTrigger()
    self.matchLabel:GetParent():SetHeight(30);
    self.minDurationSlider:GetParent():SetHeight(50);
    self.maxDurationSlider:GetParent():SetHeight(50);

    self.potCategoryCombo:GetParent():SetHeight(0);
    self.categoryLabel:GetParent():SetHeight(0);
    self.isCurableCB:GetParent():SetHeight(0);
end

function EffectTriggerWindow:TemplateAllDebuffs()
	self.nameText:SetText(L["All Debuffs"]);
	self.typeCombo:SetSelection(EffectTriggerType.Debuff);
	self.blacklistCB:SetChecked(false);
	self.matchText:SetText("");
	self.categoryCombo:SetSelection(nil);
	self.isCurableCB:SetChecked(false);
	self.minDurationSlider:SetValue(0);
	self.maxDurationSlider:SetValue(0);
	self:EnableEffect(false);
end

function EffectTriggerWindow:TemplateAllCurableDebuffs()
	self.nameText:SetText(L["All Curable Debuffs"]);
	self.typeCombo:SetSelection(EffectTriggerType.Debuff);
	self.blacklistCB:SetChecked(false);
	self.matchText:SetText("");
	self.categoryCombo:SetSelection(nil);
	self.isCurableCB:SetChecked(true);
	self.minDurationSlider:SetValue(0);
	self.maxDurationSlider:SetValue(0);
	self:EnableEffect(false);
end

function EffectTriggerWindow:TemplateAllBuffs()
	self.nameText:SetText(L["All Buffs"]);
	self.typeCombo:SetSelection(EffectTriggerType.Buff);
	self.blacklistCB:SetChecked(false);
	self.matchText:SetText("");
	self.categoryCombo:SetSelection(nil);
	self.isCurableCB:SetChecked(false);
	self.minDurationSlider:SetValue(0);
	self.maxDurationSlider:SetValue(0);
	self:EnableEffect(false);
end

function EffectTriggerWindow:TemplateAllCoolDowns()
	self.nameText:SetText(L["All Cool Downs"]);
	self.typeCombo:SetSelection(EffectTriggerType.CoolDown);
	self.blacklistCB:SetChecked(false);
	self.potCategoryCombo:SetSelection(nil);
	self:EnableCoolDown(false);
end

function EffectTriggerWindow:TemplateAllMobDebuffs()
	self.nameText:SetText(L["All Mob Debuffs"]);
	self.typeCombo:SetSelection(EffectTriggerType.MobDebuff);
	self.blacklistCB:SetChecked(false);
	self.matchText:SetText("");
	self.categoryCombo:SetSelection(nil);
	self.isCurableCB:SetChecked(false);
	self.minDurationSlider:SetValue(0);
	self.maxDurationSlider:SetValue(0);
	self:EnableEffect(false);
end

function EffectTriggerWindow:TemplateAllMobCrowdControl()
	self.nameText:SetText(L["All Mob CC"]);
	self.typeCombo:SetSelection(EffectTriggerType.MobCrowdControl);
	self.blacklistCB:SetChecked(false);
	self.matchText:SetText("");
	self.categoryCombo:SetSelection(nil);
	self.isCurableCB:SetChecked(false);
	self.minDurationSlider:SetValue(0);
	self.maxDurationSlider:SetValue(0);
	self:EnableEffect(false);
end

function EffectTriggerWindow:TemplateCustom()
	self:EnableEffect(true);	
	self:EnableCoolDown(true);
end

function EffectTriggerWindow:SetOptions(trigger)
	if (trigger.template == nil) then
		-- new trigger
		self.typeCombo:SetSelection(EffectTriggerType.Debuff);
        self:EnableEffect(false);
        self:EnableCoolDown(false);
	else
		self.templateCombo:SetSelection(trigger.template);
        self.nameText:SetText(trigger.name);
        self.typeCombo:SetSelection(trigger.type);
        self.blacklistCB:SetChecked(trigger.blacklist);
        if (trigger.type == EffectTriggerType.CoolDown) then
        	self.potCategoryCombo:SetSelection(trigger.category);
        else
        	self.matchText:SetText(PengorosPlugins.Utils.UnescapeMatch(trigger.match));
        	self.categoryCombo:SetSelection(trigger.category);
        	self.isCurableCB:SetChecked(trigger.curable);
        	self.minDurationSlider:SetValue(trigger.minDuration);
        	self.maxDurationSlider:SetValue(trigger.maxDuration);
        end
	end
end

function EffectTriggerWindow:SaveOptions()
    local values = {};

	values.template = self.templateCombo:GetSelection();
    values.name = self.nameText:GetText();
    values.type = self.typeCombo:GetSelection();
    values.blacklist = self.blacklistCB:IsChecked();
    
    if (values.type == EffectTriggerType.CoolDown) then
    	values.category = self.potCategoryCombo:GetSelection();
    elseif(values.type == EffectTriggerType.MobDebuff or values.type == EffectTriggerType.MobCrowdControl) then
        values.match = PengorosPlugins.Utils.EscapeMatch(self.matchText:GetText());
        values.minDuration = self.minDurationSlider:GetValue();
        values.maxDuration = self.maxDurationSlider:GetValue();
    else
    	values.match = PengorosPlugins.Utils.EscapeMatch(self.matchText:GetText());
        values.category = self.categoryCombo:GetSelection();
        values.curable = self.isCurableCB:IsChecked();
        values.minDuration = self.minDurationSlider:GetValue();
        values.maxDuration = self.maxDurationSlider:GetValue();
	    -- FIXME remove this when we have full target support, default to the current player
		values.target = Target.Me;
    end
    
    self.trigger = EffectTrigger(values);
end

function EffectTriggerWindow:GetTrigger()
    return self.trigger;
end

function EffectTriggerWindow:Destroy()
end

function EffectTriggerWindow:UiHidden(hidden)
    self:SetVisible(not hidden);
end

function EffectTriggerWindow:EscapePressed()
    self:Close();
end

EffectTriggerWindow.TemplateMap = {};
EffectTriggerWindow.TemplateMap[EffectTriggerTemplate.Custom] = EffectTriggerWindow.TemplateCustom;
EffectTriggerWindow.TemplateMap[EffectTriggerTemplate.AllDebuffs] = EffectTriggerWindow.TemplateAllDebuffs;
EffectTriggerWindow.TemplateMap[EffectTriggerTemplate.AllCurableDebuffs] = EffectTriggerWindow.TemplateAllCurableDebuffs;
EffectTriggerWindow.TemplateMap[EffectTriggerTemplate.AllBuffs] = EffectTriggerWindow.TemplateAllBuffs;
EffectTriggerWindow.TemplateMap[EffectTriggerTemplate.AllCoolDowns] = EffectTriggerWindow.TemplateAllCoolDowns;
EffectTriggerWindow.TemplateMap[EffectTriggerTemplate.AllMobDebuffs] = EffectTriggerWindow.TemplateAllMobDebuffs;
EffectTriggerWindow.TemplateMap[EffectTriggerTemplate.AllMobCrowdControl] = EffectTriggerWindow.TemplateAllMobCrowdControl;

EffectTriggerWindow.TypeMap = {};
EffectTriggerWindow.TypeMap[EffectTriggerType.Debuff] = EffectTriggerWindow.DebuffTrigger;
EffectTriggerWindow.TypeMap[EffectTriggerType.Buff] = EffectTriggerWindow.BuffTrigger;
EffectTriggerWindow.TypeMap[EffectTriggerType.CoolDown] = EffectTriggerWindow.CoolDownTrigger;
EffectTriggerWindow.TypeMap[EffectTriggerType.MobDebuff] = EffectTriggerWindow.MobDebuffTrigger;
EffectTriggerWindow.TypeMap[EffectTriggerType.MobCrowdControl] = EffectTriggerWindow.MobCrowdControlTrigger;
