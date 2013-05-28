import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

CharacterSettings = class();

function CharacterSettings:Constructor(reset)
    if (reset) then
        -- set some reasonable defaults
        self:SetDefaults();
        self:Save();
    else
        self:Load();
    end
end

function CharacterSettings:Load()
    local saved = Turbine.PluginData.Load(self:GetScope(), "BuffBarsSettings");

    if (type(saved) ~= "table") then
        -- set some reasonable defaults
        self:SetDefaults();
        self:Save();
    else
        -- convert the data format back for non US clients if necessary
        saved = PengorosPlugins.Utils.DecodeNumbers(saved);

        -- copy the values into this object
        for i,v in pairs(saved) do
            if (i == "windows") then
                self.windows = {};
                local size = table.getn(v);
                for i = 1, size do
                    self.windows[i] = EffectBarSettings(v[i]);
                end
            elseif (i == "quickslots") then
                self.quickslots = {};
                local size = table.getn(v);
                for i = 1, size do
                    self.quickslots[i] = QuickslotSettings(v[i]);
                end
            elseif (i == "sliders") then
                self.sliders = {};
                local size = table.getn(v);
                for i = 1, size do
                    self.sliders[i] = SliderSettings(v[i]);
                end
            else
                self[i] = v;
            end
        end
        
        -- see if we need to do a migration
        self:CheckMigration();
    end
end

function CharacterSettings:Save()
    -- convert the data format to a safe one for non US clients if necessary
    local object = PengorosPlugins.Utils.EncodeNumbers(self);
    Turbine.PluginData.Save(self:GetScope(), "BuffBarsSettings", object);
end

function CharacterSettings:GetScope()
    return Turbine.DataScope.Character;
end

function CharacterSettings:SetDefaults()
    -- current settings version
    self.version = 12;

    -- quickslot 
    self.quickslots = {QuickslotSettings()};
    
    -- effect windows
    self.windows = {EffectBarSettings()};
    
    -- effect sliders
    self.sliders = {SliderSettings()};
    
    -- logging
    self.log = LogSettings();
end

function CharacterSettings:Migrate(version)
    Turbine.Shell.WriteLine("Migrating BuffBars options to version " .. version);
    self.version = version;
end

function CharacterSettings:CheckMigration()
    local save = false;
    if (self.version == 1) then
        self.fillBottomToTop = false;
        self.showEffectName = true;
        self.showEffectTimer = true;
        self.timerWidth = nil;
        self:Migrate(2);
        save = true;
    end
    if (self.version == 2) then
        self.quickslots = {QuickslotSettings()};
        self.quickslots[1].enabled = self.showQuickslot;
        self.showQuickslot = nil;
        self.quickslots[1].qsX = self.qsX;
        self.qsX = nil;
        self.quickslots[1].qsY = self.qsY;
        self.qsY = nil;
        self.quickslots[1].moralePercent = self.moralePercent;
        self.moralePercent = nil;
        self.quickslots[1].powerPercent = self.powerPercent;
        self.powerPercent = nil;
        self.quickslots[1].moraleType = self.moraleType;
        self.moraleType = nil;
        self.quickslots[1].moraleData = self.moraleData;
        self.moraleData = nil;
        self.quickslots[1].powerType = self.powerType;
        self.powerType = nil;
        self.quickslots[1].powerData = self.powerData;
        self.powerData = nil;
        self.quickslots[1].diseaseType = self.diseaseType;
        self.diseaseType = nil;
        self.quickslots[1].diseaseData = self.diseaseData;
        self.diseaseData = nil;
        self.quickslots[1].fearType = self.fearType;
        self.fearType = nil;
        self.quickslots[1].fearData = self.fearData;
        self.fearData = nil;
        self.quickslots[1].poisonType = self.poisonType;
        self.poisonType = nil;
        self.quickslots[1].poisonData = self.poisonData;
        self.poisonData = nil;
        self.quickslots[1].woundType = self.woundType;
        self.woundType = nil;
        self.quickslots[1].woundData = self.woundData;
        self.woundData = nil;
        
        self.windows = {EffectBarSettings()};
        self.windows[1].posX = self.posX;
        self.posX = nil;
        self.windows[1].posY = self.posY;
        self.posY = nil;
        self.windows[1].barHeight = self.barHeight;
        self.barHeight = nil;
        self.windows[1].barWidth = self.barWidth;
        self.barWidth = nil;
        self.windows[1].showDebuffBar = self.showDebuffBar;
        self.showDebuffBar = nil;
        self.windows[1].showBuffBar = self.showBuffBar;
        self.showBuffBar = nil;
        self.windows[1].showDisease = self.showDisease;
        self.showDisease = nil;
        self.windows[1].showFear = self.showFear;
        self.showFear = nil;
        self.windows[1].showPoison = self.showPoison;
        self.showPoison = nil;
        self.windows[1].showWound = self.showWound;
        self.showWound = nil;
        self.windows[1].showCorruption = self.showCorruption;
        self.showCorruption = nil;
        self.windows[1].showCry = self.showCry;
        self.showCry = nil;
        self.windows[1].showElemental = self.showElemental;
        self.showElemental = nil;
        self.windows[1].showPhysical = self.showPhysical;
        self.showPhysical = nil;
        self.windows[1].showSong = self.showSong;
        self.showSong = nil;
        self.windows[1].showUndefined = self.showUndefined;
        self.showUndefined = nil;
        self.windows[1].showCurableOnly = self.showCurableOnly;
        self.showCurableOnly = nil;
        self.windows[1].ignored = self.ignored;
        self.ignored = nil;
        self.windows[1].showEffectName = self.showEffectName;
        self.showEffectName = nil;
        self.windows[1].showEffectTimer = self.showEffectTimer;
        self.showEffectTimer = nil;
        self.windows[1].backgroundColor = self.backgroundColor;
        self.backgroundColor = nil;
        self.windows[1].font = self.font;
        self.font = nil;
        self.windows[1].sortMethod = self.sortMethod;
        self.sortMethod = nil;
        self.windows[1].sortAscending = self.sortAscending;
        self.sortAscending = nil;
        self.windows[1].showDebuffsFirst = self.showDebuffsFirst;
        self.showDebuffsFirst = nil;
        self.windows[1].fillBottomToTop = self.fillBottomToTop;
        self.fillBottomToTop = nil;
        self.windows[1].allowFlashing = self.allowFlashing;
        self.allowFlashing = nil;
        self.windows[1].flashTime = self.flashTime;
        self.flashTime = nil;

        local col = Colors.Flash;
        self.windows[1].colors[col].remaining = self.flashRemainingColor;
        self.windows[1].colors[col].elapsed = self.flashElapsedColor;
        self.flashRemainingColor = nil;
        self.flashElapsedColor = nil;
        
        col = Colors.Undefined;
        self.windows[1].colors[col].remaining = self.undefinedRemainingColor;
        self.windows[1].colors[col].elapsed = self.undefinedElapsedColor;
        self.undefinedRemainingColor = nil;
        self.undefinedElapsedColor = nil;
        
        col = Colors.Disease;
        self.windows[1].colors[col].remaining = self.diseaseRemainingColor;
        self.windows[1].colors[col].elapsed = self.diseaseElapsedColor;
        self.diseaseRemainingColor = nil;
        self.diseaseElapsedColor = nil;
        
        col = Colors.Fear;
        self.windows[1].colors[col].remaining = self.fearRemainingColor;
        self.windows[1].colors[col].elapsed = self.fearElapsedColor;
        self.fearRemainingColor = nil;
        self.fearElapsedColor = nil;
    
        col = Colors.Poison;
        self.windows[1].colors[col].remaining = self.poisonRemainingColor;
        self.windows[1].colors[col].elapsed = self.poisonElapsedColor;
        self.poisonRemainingColor = nil;
        self.poisonElapsedColor = nil;
    
        col = Colors.Wound;
        self.windows[1].colors[col].remaining = self.woundRemainingColor;
        self.windows[1].colors[col].elapsed = self.woundElapsedColor;
        self.woundRemainingColor = nil;
        self.woundElapsedColor = nil;
    
        col = Colors.Physical;
        self.windows[1].colors[col].remaining = self.physicalRemainingColor;
        self.windows[1].colors[col].elapsed = self.physicalElapsedColor;
        self.physicalRemainingColor = nil;
        self.physicalElapsedColor = nil;
    
        col = Colors.Elemental;
        self.windows[1].colors[col].remaining = self.elementalRemainingColor;
        self.windows[1].colors[col].elapsed = self.elementalElapsedColor;
        self.elementalRemainingColor = nil;
        self.elementalElapsedColor = nil;
    
        col = Colors.Song;
        self.windows[1].colors[col].remaining = self.songRemainingColor;
        self.windows[1].colors[col].elapsed = self.songElapsedColor;
        self.songRemainingColor = nil;
        self.songElapsedColor = nil;
    
        col = Colors.Corruption;
        self.windows[1].colors[col].remaining = self.corruptionRemainingColor;
        self.windows[1].colors[col].elapsed = self.corruptionElapsedColor;
        self.corruptionRemainingColor = nil;
        self.corruptionElapsedColor = nil;
    
        col = Colors.Cry;
        self.windows[1].colors[col].remaining = self.cryRemainingColor;
        self.windows[1].colors[col].elapsed = self.cryElapsedColor;
        self.cryRemainingColor = nil;
        self.cryElapsedColor = nil;
        
        self:Migrate(3);
        save = true;
    end
    if (self.version == 3) then
        self.log = LogSettings();
        local i;
        for i = 1, table.getn(self.windows) do
            self.windows[i].showDiseaseCD = true;
            self.windows[i].showFearCD = true;
            self.windows[i].showPoisonCD = true;
            self.windows[i].showWoundCD = true;
            self.windows[i].showMoraleCD = true;
            self.windows[i].showPowerCD = true;
            self.windows[i].showEffectDuration = true;
            self.windows[i].minDurationFilter = false;
            self.windows[i].minDuration = 5;
            self.windows[i].maxDurationFilter = false;
            self.windows[i].maxDuration = 300;
            self.windows[i].visibleType = self.windows[i].onlyInCombat and WindowVisibility.InCombat or WindowVisibility.Always;
            self.windows[i].onlyInCombat = nil;
        end
        for i = 1, table.getn(self.quickslots) do
            self.quickslots[i].visibleType = self.quickslots[i].onlyInCombat and WindowVisibility.InCombat or WindowVisibility.Always;
            self.quickslots[i].onlyInCombat = nil;
        end

        self:Migrate(4);
        save = true;
    end
    if (self.version == 4) then
        for i = 1, table.getn(self.windows) do
            if (not self.windows[i].minDurationFilter) then
                self.windows[i].minDuration = 0;
            end
            self.windows[i].minDurationFilter = nil;
            if (not self.windows[i].maxDurationFilter) then
                self.windows[i].maxDuration = 0;
            end
            self.windows[i].maxDurationFilter = nil;
            self.windows[i].displayFormat = TimeDisplayFormat.Clock;
        end
            
        self.sliders = {};
        self:Migrate(5);
        save = true;
    end
    if (self.version == 5) then
        self.log.logTime = false;
    
        for i = 1, table.getn(self.quickslots) do
            self.quickslots[i].triggers = {};
            
            if (self.quickslots[i].showDisease) then
                table.insert(self.quickslots[i].triggers, Trigger({name=L["Disease"], template=TriggerTemplate.Disease, triggerType=TriggerType.Effect, category=Turbine.Gameplay.EffectCategory.Disease, hasEffect=true, isCurable=true, shortcutType=self.quickslots[i].diseaseType, shortcutData=self.quickslots[i].diseaseData}));
            end

            if (self.quickslots[i].showFear) then
                table.insert(self.quickslots[i].triggers, Trigger({name=L["Fear"], template=TriggerTemplate.Fear, triggerType=TriggerType.Effect, category=Turbine.Gameplay.EffectCategory.Fear, hasEffect=true, isCurable=true, shortcutType=self.quickslots[i].fearType, shortcutData=self.quickslots[i].fearData}));
            end

            if (self.quickslots[i].showPoison) then
                table.insert(self.quickslots[i].triggers, Trigger({name=L["Poison"], template=TriggerTemplate.Poison, triggerType=TriggerType.Effect, category=Turbine.Gameplay.EffectCategory.Poison, hasEffect=true, isCurable=true, shortcutType=self.quickslots[i].poisonType, shortcutData=self.quickslots[i].poisonData}));
            end

            if (self.quickslots[i].showWound) then
                table.insert(self.quickslots[i].triggers, Trigger({name=L["Wound"], template=TriggerTemplate.Wound, triggerType=TriggerType.Effect, category=Turbine.Gameplay.EffectCategory.Wound, hasEffect=true, isCurable=true, shortcutType=self.quickslots[i].woundType, shortcutData=self.quickslots[i].woundData}));
            end

            if (self.quickslots[i].showMorale) then
                table.insert(self.quickslots[i].triggers, Trigger({name=L["Morale"], template=TriggerTemplate.Morale, triggerType=TriggerType.Level, level=TriggerLevel.Morale, threshold=self.quickslots[i].moralePercent, shortcutType=self.quickslots[i].moraleType, shortcutData=self.quickslots[i].moraleData}));
            end

            if (self.quickslots[i].showPower) then
                table.insert(self.quickslots[i].triggers, Trigger({name=L["Power"], template=TriggerTemplate.Power, triggerType=TriggerType.Level, level=TriggerLevel.Power, threshold=self.quickslots[i].powerPercent, shortcutType=self.quickslots[i].powerType, shortcutData=self.quickslots[i].powerData}));
            end

            -- remove the old
            self.quickslots[i].showDisease = nil;
            self.quickslots[i].diseaseType = nil;
            self.quickslots[i].diseaseData = nil;
            self.quickslots[i].showFear = nil;
            self.quickslots[i].fearType = nil;
            self.quickslots[i].fearData = nil;
            self.quickslots[i].showPoison = nil;
            self.quickslots[i].poisonType = nil;
            self.quickslots[i].poisonData = nil;
            self.quickslots[i].showWound = nil;
            self.quickslots[i].woundType = nil;
            self.quickslots[i].woundData = nil;
            self.quickslots[i].showMorale = nil;
            self.quickslots[i].moralePercent = nil;
            self.quickslots[i].moraleType = nil;
            self.quickslots[i].moraleData = nil;
            self.quickslots[i].showPower = nil;
            self.quickslots[i].powerPercent = nil;
            self.quickslots[i].powerType = nil;
            self.quickslots[i].powerData = nil;
        end

        self:Migrate(6);
        save = true;
    end
    if (self.version == 6) then
        self.log.logTarget = true;
        for i = 1, table.getn(self.windows) do
            local win = self.windows[i];
            win.showEffectTarget = false;
            win.triggers = {};
            
            if (win.showDebuffBar) then
                if (win.showDisease and win.showFear and win.showPoison and win.showWound and win.showCorruption and win.showCry and win.showElemental and win.showPhysical and win.showSong and win.showUndefined) then
                    -- all categories are on, just create a generic trigger
                    table.insert(win.triggers, EffectTrigger({name=L["All Debuffs"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Debuff, blacklist=false, category=nil, curable=win.showCurableOnly, match=nil, minDuration=win.minDuration, maxDuration=win.maxDuration}));
                else
                    -- have to create triggers for every category
                    local names = {"Disease", "Fear", "Poison", "Wound", "Corruption", "Cry", "Elemental", "Physical", "Song", "Undefined"};
                    local categories = {Turbine.Gameplay.EffectCategory.Disease, Turbine.Gameplay.EffectCategory.Fear, Turbine.Gameplay.EffectCategory.Poison, Turbine.Gameplay.EffectCategory.Wound, Turbine.Gameplay.EffectCategory.Corruption, Turbine.Gameplay.EffectCategory.Cry, Turbine.Gameplay.EffectCategory.Elemental, Turbine.Gameplay.EffectCategory.Physical, Turbine.Gameplay.EffectCategory.Song, Turbine.Gameplay.EffectCategory.Undefined};
                    for j = 1, table.getn(names) do
                        local param = "show" .. names[j];
                        if (win[param]) then
                            table.insert(win.triggers, EffectTrigger({name=L[names[j] .. " Debuff"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Debuff, blacklist=false, category=categories[j], curable=not win.showCurableOnly, match=nil, minDuration=win.minDuration, maxDuration=win.maxDuration}));
                        end
                    end
                end
                
                -- ignore
                for k,v in pairs(win.ignored) do
                    table.insert(win.triggers, EffectTrigger({name=k..L[" [Debuff]"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Debuff, blacklist=true, category=nil, curable=false, match=k, minDuration=0, maxDuration=0}));
                end

                -- override
                for k,v in pairs(win.override) do
                    table.insert(win.triggers, EffectTrigger({name=k..L[" [Debuff]"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Debuff, blacklist=false, category=nil, curable=false, match=k, minDuration=0, maxDuration=0}));
                end
            end
            if (win.showBuffBar) then
                if (win.showDisease and win.showFear and win.showPoison and win.showWound and win.showCorruption and win.showCry and win.showElemental and win.showPhysical and win.showSong and win.showUndefined) then
                    -- all categories are on, just create a few generic triggers
                    table.insert(win.triggers, EffectTrigger({name=L["All Buffs"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Buff, blacklist=false, category=nil, curable=false, match=nil, minDuration=win.minDuration, maxDuration=win.maxDuration}));
                else
                    -- have to create triggers for every category
                    local names = {"Disease", "Fear", "Poison", "Wound", "Corruption", "Cry", "Elemental", "Physical", "Song", "Undefined"};
                    local categories = {Turbine.Gameplay.EffectCategory.Disease, Turbine.Gameplay.EffectCategory.Fear, Turbine.Gameplay.EffectCategory.Poison, Turbine.Gameplay.EffectCategory.Wound, Turbine.Gameplay.EffectCategory.Corruption, Turbine.Gameplay.EffectCategory.Cry, Turbine.Gameplay.EffectCategory.Elemental, Turbine.Gameplay.EffectCategory.Physical, Turbine.Gameplay.EffectCategory.Song, Turbine.Gameplay.EffectCategory.Undefined};
                    for j = 1, table.getn(names) do
                        local param = "show" .. names[j];
                        if (win[param]) then
                            table.insert(win.triggers, EffectTrigger({name=L[names[j] .. " Buff"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Buff, blacklist=false, category=categories[j], curable=false, match=nil, minDuration=win.minDuration, maxDuration=win.maxDuration}));
                        end
                    end
                end
                
                -- ignore
                for k,v in pairs(win.ignored) do
                    table.insert(win.triggers, EffectTrigger({name=k..L[" [Buff]"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Buff, blacklist=true, category=nil, curable=false, match=k, minDuration=0, maxDuration=0}));
                end

                -- override
                for k,v in pairs(win.override) do
                    table.insert(win.triggers, EffectTrigger({name=k..L[" [Buff]"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Buff, blacklist=false, category=nil, curable=false, match=k, minDuration=0, maxDuration=0}));
                end
            end
            if (win.showCoolDownBar) then
                if (win.showDiseaseCD and win.showFearCD and win.showPoisonCD and win.showWoundCD and win.showMoraleCD and win.showPowerCD) then
                    -- all categories are on, just create a generic triggers
                    table.insert(win.triggers, EffectTrigger({name=L["All Cool Downs"], template=EffectTriggerTemplate.AllCoolDowns, type=EffectTriggerType.CoolDown, blacklist=false, category=nil}));
                else
                    -- have to create triggers for every category
                    local names = {"Disease", "Fear", "Poison", "Wound", "Morale", "Power"};
                    local categories = {PengorosPlugins.Utils.CoolDownCategory.Disease, PengorosPlugins.Utils.CoolDownCategory.Fear, PengorosPlugins.Utils.CoolDownCategory.Poison, PengorosPlugins.Utils.CoolDownCategory.Wound, PengorosPlugins.Utils.CoolDownCategory.Morale, PengorosPlugins.Utils.CoolDownCategory.Power};
                    for j = 1, table.getn(names) do
                        local param = "show" .. names[j] .. "CD";
                        if (win[param]) then
                            table.insert(win.triggers, EffectTrigger({name=L[names[j] .. " Cool Down"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.CoolDown, blacklist=false, category=categories[j]}));
                        end
                    end
                end
            end
            
            -- cleanup unused           
            win.showDebuffBar = nil;
            win.showBuffBar = nil;
            win.showCoolDownBar = nil;
            win.ignored = nil;
            win.override = nil;
            win.showDisease = nil;
            win.showFear = nil;
            win.showPoison = nil;
            win.showWound = nil;
            win.showCorruption = nil;
            win.showCry = nil;
            win.showElemental = nil;
            win.showPhysical = nil;
            win.showSong = nil;
            win.showUndefined = nil;
            win.showCurableOnly = nil;
            win.minDuration = nil;
            win.maxDuration = nil;
            win.showDiseaseCD = nil;
            win.showFearCD = nil;
            win.showPoisonCD = nil;
            win.showWoundCD = nil;
            win.showMoraleCD = nil;
            win.showPowerCD = nil;
        end
            
        for i = 1, table.getn(self.sliders) do
            local slider = self.sliders[i];
            slider.showEffectTarget = false;
            slider.triggers = {};
            
            if (slider.showDebuffs) then
                if (slider.showDisease and slider.showFear and slider.showPoison and slider.showWound and slider.showCorruption and slider.showCry and slider.showElemental and slider.showPhysical and slider.showSong and slider.showUndefined) then
                    -- all categories are on, just create a generic trigger
                    table.insert(slider.triggers, EffectTrigger({name=L["All Debuffs"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Debuff, blacklist=false, category=nil, curable=slider.showCurableOnly, match=nil, minDuration=slider.minDuration, maxDuration=slider.maxDuration}));
                else
                    -- have to create triggers for every category
                    local names = {"Disease", "Fear", "Poison", "Wound", "Corruption", "Cry", "Elemental", "Physical", "Song", "Undefined"};
                    local categories = {Turbine.Gameplay.EffectCategory.Disease, Turbine.Gameplay.EffectCategory.Fear, Turbine.Gameplay.EffectCategory.Poison, Turbine.Gameplay.EffectCategory.Wound, Turbine.Gameplay.EffectCategory.Corruption, Turbine.Gameplay.EffectCategory.Cry, Turbine.Gameplay.EffectCategory.Elemental, Turbine.Gameplay.EffectCategory.Physical, Turbine.Gameplay.EffectCategory.Song, Turbine.Gameplay.EffectCategory.Undefined};
                    for j = 1, table.getn(names) do
                        local param = "show" .. names[j];
                        if (slider[param]) then
                            table.insert(slider.triggers, EffectTrigger({name=L[names[j] .. " Debuff"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Debuff, blacklist=false, category=categories[j], curable=slider.showCurableOnly, match=nil, minDuration=slider.minDuration, maxDuration=slider.maxDuration}));
                        end
                    end
                end

                -- ignore
                for k,v in pairs(slider.ignored) do
                    table.insert(slider.triggers, EffectTrigger({name=k..L[" (Debuff:blacklist)"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Debuff, blacklist=true, category=nil, curable=false, match=k, minDuration=0, maxDuration=0}));
                end

                -- override
                for k,v in pairs(slider.override) do
                    table.insert(slider.triggers, EffectTrigger({name=k..L[" (Debuff)"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Debuff, blacklist=false, category=nil, curable=false, match=k, minDuration=0, maxDuration=0}));
                end
            end
            if (slider.showBuffs) then
                if (slider.showDisease and slider.showFear and slider.showPoison and slider.showWound and slider.showCorruption and slider.showCry and slider.showElemental and slider.showPhysical and slider.showSong and slider.showUndefined) then
                    -- all categories are on, just create a few generic triggers
                    table.insert(slider.triggers, EffectTrigger({name=L["All Buffs"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Buff, blacklist=false, category=nil, curable=false, match=nil, minDuration=slider.minDuration, maxDuration=slider.maxDuration}));
                else
                    -- have to create triggers for every category
                    local names = {"Disease", "Fear", "Poison", "Wound", "Corruption", "Cry", "Elemental", "Physical", "Song", "Undefined"};
                    local categories = {Turbine.Gameplay.EffectCategory.Disease, Turbine.Gameplay.EffectCategory.Fear, Turbine.Gameplay.EffectCategory.Poison, Turbine.Gameplay.EffectCategory.Wound, Turbine.Gameplay.EffectCategory.Corruption, Turbine.Gameplay.EffectCategory.Cry, Turbine.Gameplay.EffectCategory.Elemental, Turbine.Gameplay.EffectCategory.Physical, Turbine.Gameplay.EffectCategory.Song, Turbine.Gameplay.EffectCategory.Undefined};
                    for j = 1, table.getn(names) do
                        local param = "show" .. names[j];
                        if (slider[param]) then
                            table.insert(slider.triggers, EffectTrigger({name=L[names[j] .. " Buff"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Buff, blacklist=false, category=categories[j], curable=false, match=nil, minDuration=slider.minDuration, maxDuration=slider.maxDuration}));
                        end
                    end
                end
                
                -- ignore
                for k,v in pairs(slider.ignored) do
                    table.insert(slider.triggers, EffectTrigger({name=k..L[" (Buff:blacklist)"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Buff, blacklist=true, category=nil, curable=false, match=k, minDuration=0, maxDuration=0}));
                end

                -- override
                for k,v in pairs(slider.override) do
                    table.insert(slider.triggers, EffectTrigger({name=k..L[" (Buff)"], template=EffectTriggerTemplate.Custom, type=EffectTriggerType.Buff, blacklist=false, category=nil, curable=false, match=k, minDuration=0, maxDuration=0}));
                end
            end
            
            -- cleanup unused           
            slider.showDebuffs = nil;
            slider.showBuffs = nil;
            slider.showCoolDowns = nil;
            slider.ignored = nil;
            slider.override = nil;
            slider.showDisease = nil;
            slider.showFear = nil;
            slider.showPoison = nil;
            slider.showWound = nil;
            slider.showCorruption = nil;
            slider.showCry = nil;
            slider.showElemental = nil;
            slider.showPhysical = nil;
            slider.showSong = nil;
            slider.showUndefined = nil;
            slider.showCurableOnly = nil;
            slider.minDuration = nil;
            slider.maxDuration = nil;
            slider.showDiseaseCD = nil;
            slider.showFearCD = nil;
            slider.showPoisonCD = nil;
            slider.showWoundCD = nil;
            slider.showMoraleCD = nil;
            slider.showPowerCD = nil;
        end

        self:Migrate(7);
        save = true;
    end
    if (self.version == 7) then
        for i = 1, table.getn(self.windows) do
            local win = self.windows[i];
            win.colors[Colors.MobDebuff] = {};
            win.colors[Colors.MobDebuff].remaining = {a=255, r=178, g=78, b=0};
            win.colors[Colors.MobDebuff].elapsed = {a=102, r=178, g=78, b=0};
            win.colors[Colors.MobCrowdControl] = {};
            win.colors[Colors.MobCrowdControl].remaining = {a=255, r=178, g=78, b=0};
            win.colors[Colors.MobCrowdControl].elapsed = {a=102, r=178, g=78, b=0};
            
            if (win.barOrder == 0) then
                win.barOrder = {EffectBar.CoolDown, EffectBar.Debuff, EffectBar.Buff, EffectBar.MobDebuff, EffectBar.MobCC};
            elseif (win.barOrder == 1) then
                win.barOrder = {EffectBar.CoolDown, EffectBar.Buff, EffectBar.Debuff, EffectBar.MobDebuff, EffectBar.MobCC};
            elseif (win.barOrder == 2) then
                win.barOrder = {EffectBar.Debuff, EffectBar.Buff, EffectBar.CoolDown, EffectBar.MobDebuff, EffectBar.MobCC};
            elseif (win.barOrder == 3) then
                win.barOrder = {EffectBar.Debuff, EffectBar.CoolDown, EffectBar.Buff, EffectBar.MobDebuff, EffectBar.MobCC};
            elseif (win.barOrder == 4) then
                win.barOrder = {EffectBar.Buff, EffectBar.CoolDown, EffectBar.Debuff, EffectBar.MobDebuff, EffectBar.MobCC};
            elseif (win.barOrder == 5) then
                win.barOrder = {EffectBar.Buff, EffectBar.Debuff, EffectBar.CoolDown, EffectBar.MobDebuff, EffectBar.MobCC};
            end
        end
            
        self:Migrate(8);
        save = true;
    end
    if (self.version == 8) then
        for i = 1, table.getn(self.windows) do
            local win = self.windows[i];
            if (win.colors[-2] ~= nil) then
                win.colors[Colors.MobDebuff] = win.colors[-2];
                win.colors[-2] = nil;
            end
            if (win.colors[-4] ~= nil) then
                win.colors[Colors.MobCrowdControl] = win.colors[-4];
                win.colors[-4] = nil;
            end
            
            for j = 1, table.getn(win.triggers) do
                local trigger = win.triggers[j];
                if (trigger.type == -2) then
                    trigger.type = EffectTriggerType.MobDebuff;
                elseif (trigger.type == -4) then
                    trigger.type = EffectTriggerType.MobCrowdControl;
                end
            end
        end
        for i = 1, table.getn(self.sliders) do
            local slider = self.sliders[i];
            for j = 1, table.getn(slider.triggers) do
                local trigger = slider.triggers[j];
                if (trigger.type == -2) then
                    trigger.type = EffectTriggerType.MobDebuff;
                elseif (trigger.type == -4) then
                    trigger.type = EffectTriggerType.MobCrowdControl;
                end
            end
        end
            
        self:Migrate(9);
        save = true;
    end
    if (self.version == 9) then
        for i = 1, table.getn(self.windows) do
            local win = self.windows[i];
            for j = 1, table.getn(win.triggers) do
                local trigger = win.triggers[j];
                if (trigger.match ~= nil) then
                    local match = PengorosPlugins.Utils.UnescapeMatch(trigger.match);
                    trigger.match = PengorosPlugins.Utils.EscapeMatch(match);
                end
            end
        end
        for i = 1, table.getn(self.sliders) do
            local slider = self.sliders[i];
            for j = 1, table.getn(slider.triggers) do
                local trigger = slider.triggers[j];
                if (trigger.match ~= nil) then
                    local match = PengorosPlugins.Utils.UnescapeMatch(trigger.match);
                    trigger.match = PengorosPlugins.Utils.EscapeMatch(match);
                end
            end
        end

        self:Migrate(10);
        save = true;
    end
    if (self.version == 10) then
        self.log.showMobDebuffs = true;
        self.log.showMobCC = true;
    
        self:Migrate(11);
        save = true;
    end
    if (self.version == 11) then
        local name = Turbine.Gameplay.LocalPlayer.GetInstance():GetName();
        for i = 1, #self.windows do
            self.windows[i].scope = WindowScope.Character;
            for j = 1, #self.windows[i].triggers do
                local trigger = self.windows[i].triggers[j];
                if (trigger.target ~= nil and string.find(name:lower(), trigger.target, 1, true) ~= nil) then
                    trigger.target = Target.Me;
                end
            end
        end
        for i = 1, #self.sliders do
            self.sliders[i].scope = WindowScope.Character;
            for j = 1, #self.sliders[i].triggers do
                local trigger = self.sliders[i].triggers[j];
                if (trigger.target ~= nil and string.find(name:lower(), trigger.target, 1, true) ~= nil) then
                    trigger.target = Target.Me;
                end
            end
        end
        for i = 1, #self.quickslots do
            self.quickslots[i].scope = WindowScope.Character;
            for j = 1, #self.quickslots[i].triggers do
                local trigger = self.quickslots[i].triggers[j];
                trigger.shortcuts = {};
                if (trigger.shortcutData ~= nil) then
                    trigger.shortcuts[name] = {};
                    trigger.shortcuts[name].shortcutData = trigger.shortcutData;
                    trigger.shortcuts[name].shortcutType = trigger.shortcutType;
                    trigger.shortcutData = nil;
                    trigger.shortcutType = nil;
                end
            end
        end
    
        self:Migrate(12);
        save = true;
    end

    if (save) then
        self:Save();
    end
end
