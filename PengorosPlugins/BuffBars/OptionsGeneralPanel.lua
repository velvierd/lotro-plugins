import "Turbine.UI";

OptionsGeneralPanel = class(Turbine.UI.ListBox);

local holder = function(parent, height)
    local container = Turbine.UI.Control();
    container:SetSize(400, height);
    parent:AddItem(container);
    return container;
end

function OptionsGeneralPanel:Constructor()
    Turbine.UI.ListBox.Constructor(self);

    self:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self:SetMaxItemsPerLine(1);

    local line = holder(self, 35);
    self.generalTitle = PengorosPlugins.UI.PanelDivider();
    self.generalTitle:SetParent(line);
    self.generalTitle:SetText(L["General"]);
    self.generalTitle:SetSize(400, 30);

    line = holder(self, 30);
    self.localeLabel = PengorosPlugins.UI.Label();
    self.localeLabel:SetParent(line);
    self.localeLabel:SetSize(100, 20);
    self.localeLabel:SetPosition(140, 0);
    self.localeLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.localeLabel:SetText(L["Locale"]);
    PengorosPlugins.UI.Tooltip(self.localeLabel, L["Select the locale to use."]);
    
    self.localeCombo = PengorosPlugins.UI.ComboBox();
    self.localeCombo:SetParent(line);
    self.localeCombo:SetSize(150, 20);
    self.localeCombo:SetPosition(250, 0);
    self.localeCombo:AddItem(L["English"], "en");
    self.localeCombo:AddItem(L["German"], "de");
    self.localeCombo:AddItem(L["French"], "fr");
    self.localeCombo:AddItem(L["Russian"], "ru");
    
    line = holder(self, 50);
    self.localeInfoLabel = PengorosPlugins.UI.Label();
    self.localeInfoLabel:SetParent(line);
    self.localeInfoLabel:SetSize(260, 40);
    self.localeInfoLabel:SetPosition(140, 0);
    self.localeInfoLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.localeInfoLabel:SetText(L["Changes to the locale will only take effect after reloading the plugin."]);

    local line = holder(self, 35);
    self.loggingTitle = PengorosPlugins.UI.PanelDivider();
    self.loggingTitle:SetParent(line);
    self.loggingTitle:SetText(L["Logging"]);
    self.loggingTitle:SetSize(400, 30);

    line = holder(self, 20);
    self.enabledCB = PengorosPlugins.UI.CheckBox();
    self.enabledCB:SetParent(line);
    self.enabledCB:SetText(L["Enabled"]);
    self.enabledCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.enabledCB, L["When checked, effects will be logged to the chat window."]);
    self.enabledCB.CheckedChanged = function(sender, args)
        self:EnableControls(sender:IsChecked());
    end

    line = holder(self, 20);
    self.showBuffsCB = PengorosPlugins.UI.CheckBox();
    self.showBuffsCB:SetParent(line);
    self.showBuffsCB:SetText(L["Buffs"]);
    self.showBuffsCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showBuffsCB, L["When checked, buffs will be logged."]);

    line = holder(self, 20);
    self.showDebuffsCB = PengorosPlugins.UI.CheckBox();
    self.showDebuffsCB:SetParent(line);
    self.showDebuffsCB:SetText(L["Debuffs"]);
    self.showDebuffsCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showDebuffsCB, L["When checked, debuffs will be logged."]);

    line = holder(self, 20);
    self.showMobDebuffsCB = PengorosPlugins.UI.CheckBox();
    self.showMobDebuffsCB:SetParent(line);
    self.showMobDebuffsCB:SetText(L["Mob Debuffs"]);
    self.showMobDebuffsCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showMobDebuffsCB, L["When checked, mob debuffs will be logged."]);

    line = holder(self, 25);
    self.showMobCCCB = PengorosPlugins.UI.CheckBox();
    self.showMobCCCB:SetParent(line);
    self.showMobCCCB:SetText(L["Mob Crowd Control"]);
    self.showMobCCCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.showMobCCCB, L["When checked, mob cc will be logged."]);

    line = holder(self, 35);
    self.filterTitle = PengorosPlugins.UI.PanelDivider();
    self.filterTitle:SetParent(line);
    self.filterTitle:SetText(L["Log Format"]);
    self.filterTitle:SetSize(400, 30);

    line = holder(self, 20);
    self.logIdCB = PengorosPlugins.UI.CheckBox();
    self.logIdCB:SetParent(line);
    self.logIdCB:SetText(L["Id"]);
    self.logIdCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logIdCB, L["When checked, the effect id will be logged."]);

    line = holder(self, 20);
    self.logTargetCB = PengorosPlugins.UI.CheckBox();
    self.logTargetCB:SetParent(line);
    self.logTargetCB:SetText(L["Target"]);
    self.logTargetCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logTargetCB, L["When checked, the effect target will be logged."]);

    line = holder(self, 20);
    self.logNameCB = PengorosPlugins.UI.CheckBox();
    self.logNameCB:SetParent(line);
    self.logNameCB:SetText(L["Name"]);
    self.logNameCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logNameCB, L["When checked, the effect name will be logged."]);

    line = holder(self, 20);
    self.logDescriptionCB = PengorosPlugins.UI.CheckBox();
    self.logDescriptionCB:SetParent(line);
    self.logDescriptionCB:SetText(L["Description"]);
    self.logDescriptionCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logDescriptionCB, L["When checked, the effect description will be logged."]);

    line = holder(self, 20);
    self.logCategoryCB = PengorosPlugins.UI.CheckBox();
    self.logCategoryCB:SetParent(line);
    self.logCategoryCB:SetText(L["Category"]);
    self.logCategoryCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logCategoryCB, L["When checked, the effect category will be logged."]);

    line = holder(self, 20);
    self.logDurationCB = PengorosPlugins.UI.CheckBox();
    self.logDurationCB:SetParent(line);
    self.logDurationCB:SetText(L["Duration"]);
    self.logDurationCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logDurationCB, L["When checked, the effect duration will be logged."]);

    line = holder(self, 20);
    self.logCurableCB = PengorosPlugins.UI.CheckBox();
    self.logCurableCB:SetParent(line);
    self.logCurableCB:SetText(L["Is Curable"]);
    self.logCurableCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logCurableCB, L["When checked, the effect curable status will be logged."]);

    line = holder(self, 20);
    self.logDebuffCB = PengorosPlugins.UI.CheckBox();
    self.logDebuffCB:SetParent(line);
    self.logDebuffCB:SetText(L["Is Debuff"]);
    self.logDebuffCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logDebuffCB, L["When checked, the effect debuff status will be logged."]);

    line = holder(self, 25);
    self.logTimeCB = PengorosPlugins.UI.CheckBox();
    self.logTimeCB:SetParent(line);
    self.logTimeCB:SetText(L["Timestamp"]);
    self.logTimeCB:SetSize(400, 20);
    PengorosPlugins.UI.Tooltip(self.logTimeCB, L["When checked, the effect timestamp will be logged."]);

    line = holder(self, 35);
    self.caTitle = PengorosPlugins.UI.PanelDivider();
    self.caTitle:SetParent(line);
    self.caTitle:SetText(L["Combat Analysis"]);
    self.caTitle:SetSize(400, 30);

    line = holder(self, 30);
    self.debuffsButton = Turbine.UI.Lotro.Button();
    self.debuffsButton:SetParent(line);
    self.debuffsButton:SetSize(150, 22);
    self.debuffsButton:SetPosition(75, 0);
    self.debuffsButton:SetText(L["Debuffs"]);
    PengorosPlugins.UI.Tooltip(self.debuffsButton, L["Configure Combat Analysis debuffs being sent to BuffBars."]);
    self.debuffsButton.Click = function(sender, args)
        Turbine.PluginManager.ShowOptions(Plugins.CombatAnalysis);
        _G.SelectDebuffsTabInCombatAnalysisMenu();
    end

    self.ccButton = Turbine.UI.Lotro.Button();
    self.ccButton:SetParent(line);
    self.ccButton:SetSize(150, 22);
    self.ccButton:SetPosition(250, 0);
    self.ccButton:SetText(L["Crowd Control"]);
    PengorosPlugins.UI.Tooltip(self.ccButton, L["Configure Combat Analysis crowd control effects being sent to BuffBars."]);
    self.ccButton.Click = function(sender, args)
        Turbine.PluginManager.ShowOptions(Plugins.CombatAnalysis);
        _G.SelectCrowdControlTabInCombatAnalysisMenu();
    end

    line = holder(self, 70);
    self.caInfoLabel = PengorosPlugins.UI.Label();
    self.caInfoLabel:SetParent(line);
    self.caInfoLabel:SetSize(325, 60);
    self.caInfoLabel:SetPosition(75, 0);
    self.caInfoLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.caInfoLabel:SetText(L["Click the buttons above to make changes to the effects being generated by the Combat Analysis plugin for display in BuffBars."]);
end

function OptionsGeneralPanel:EnableControls(enable)
    self.showBuffsCB:SetEnabled(enable);
    self.showDebuffsCB:SetEnabled(enable);
    self.showMobDebuffsCB:SetEnabled(enable);
    self.showMobCCCB:SetEnabled(enable);
    self.logIdCB:SetEnabled(enable);
    self.logTargetCB:SetEnabled(enable);
    self.logNameCB:SetEnabled(enable);
    self.logDescriptionCB:SetEnabled(enable);
    self.logCategoryCB:SetEnabled(enable);
    self.logDurationCB:SetEnabled(enable);
    self.logCurableCB:SetEnabled(enable);
    self.logDebuffCB:SetEnabled(enable);
    self.logTimeCB:SetEnabled(enable);
end

function OptionsGeneralPanel:SetOptions()
    local settings = Settings.GetLog();
    self.localeCombo:SetSelection(PengorosPlugins.Utils.GetLocale());
    self.enabledCB:SetChecked(settings.enabled);
    self.showBuffsCB:SetChecked(settings.showBuffs);
    self.showDebuffsCB:SetChecked(settings.showDebuffs);
    self.showMobDebuffsCB:SetChecked(settings.showMobDebuffs);
    self.showMobCCCB:SetChecked(settings.showMobCC);
    self.logIdCB:SetChecked(settings.logId);
    self.logTargetCB:SetChecked(settings.logTarget);
    self.logNameCB:SetChecked(settings.logName);
    self.logDescriptionCB:SetChecked(settings.logDescription);
    self.logCategoryCB:SetChecked(settings.logCategory);
    self.logDurationCB:SetChecked(settings.logDuration);
    self.logCurableCB:SetChecked(settings.logCurable);
    self.logDebuffCB:SetChecked(settings.logDebuff);
    self.logTimeCB:SetChecked(settings.logTime);

    self:CheckForCombatAnalysis();
end

function OptionsGeneralPanel:SaveOptions()
    local settings = Settings.GetLog();
    PengorosPlugins.Utils.SetLocale(self.localeCombo:GetSelection());
    settings.enabled = self.enabledCB:IsChecked();
    settings.showBuffs = self.showBuffsCB:IsChecked();
    settings.showDebuffs = self.showDebuffsCB:IsChecked();
    settings.showMobDebuffs = self.showMobDebuffsCB:IsChecked();
    settings.showMobCC = self.showMobCCCB:IsChecked();
    settings.logId = self.logIdCB:IsChecked();
    settings.logTarget = self.logTargetCB:IsChecked();
    settings.logName = self.logNameCB:IsChecked();
    settings.logDescription = self.logDescriptionCB:IsChecked();
    settings.logCategory = self.logCategoryCB:IsChecked();
    settings.logDuration = self.logDurationCB:IsChecked();
    settings.logCurable = self.logCurableCB:IsChecked();
    settings.logDebuff = self.logDebuffCB:IsChecked();
    settings.logTime = self.logTimeCB:IsChecked();
end


function OptionsGeneralPanel:CheckForCombatAnalysis()
    self.debuffsButton:SetEnabled(_G.SelectDebuffsTabInCombatAnalysisMenu ~= nil);
    self.ccButton:SetEnabled(_G.SelectCrowdControlTabInCombatAnalysisMenu ~= nil);
end
