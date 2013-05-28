import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

Settings = class();

function Settings:Constructor(reset)
    if (reset) then
        -- set some reasonable defaults
        self:SetDefaults();
        self:_Save();
    else
        self:_Load();
    end
end

function Settings:SetDefaults()
    -- character settings
    self.character = CharacterSettings(true);
    
    -- account settings
    self.account = AccountSettings(true);
end

function Settings:_Load()
    -- character settings
    self.character = CharacterSettings(false);
    
    -- account settings
    self.account = AccountSettings(false);
end

function Settings:_Save()
    self.character:Save();
    self.account:Save();
end

-- class level stuff
function Settings.Load()
    if (not pcall(function() Settings.instance = Settings(false); end)) then
        -- reset the settings as they are corrupted
        Turbine.Shell.WriteLine(L["BuffBars settings were corrupted, reseting them."]);
        Settings.instance = Settings(true);
    end
end

-- load the plugin settings
function Settings.Save()
    if (Settings.instance ~= nil) then
        Settings.instance:_Save();
    end
end

-- reset the settings
function Settings.Reset()
    Settings.instance = Settings(true);
end

-- get the settings instance
function Settings.Get()
    return Settings.instance;
end

-- get the settings instance
function Settings.GetAccount()
    return Settings.instance.account;
end

-- get the settings instance
function Settings.GetCharacter()
    return Settings.instance.character;
end

-- return the combined set of account/character effect windows
function Settings.GetWindows()
    local windows = {};
    local settings = Settings.instance;
    for i = 1, #settings.character.windows do
        table.insert(windows, settings.character.windows[i]);
    end
    for i = 1, #settings.account.windows do
        table.insert(windows, settings.account.windows[i]);
    end
    return windows;
end

-- set the effect windows, this will put them in the correct settings area based on scope
function Settings.SetWindows(windows)
    local character = {};
    local account = {};
    for i = 1, #windows do
        local window = windows[i];
        if (window.scope == WindowScope.Character) then
            table.insert(character, window);
        else
            table.insert(account, window);
        end
    end
    
    local settings = Settings.instance;
    settings.character.windows = character;
    settings.account.windows = account;
end

-- return the combined set of account/character effect sliders
function Settings.GetSliders()
    local sliders = {};
    local settings = Settings.instance;
    for i = 1, #settings.character.sliders do
        table.insert(sliders, settings.character.sliders[i]);
    end
    for i = 1, #settings.account.sliders do
        table.insert(sliders, settings.account.sliders[i]);
    end
    return sliders;
end

-- set the effect sliders, this will put them in the correct settings area based on scope
function Settings.SetSliders(sliders)
    local character = {};
    local account = {};
    for i = 1, #sliders do
        local slider = sliders[i];
        if (slider.scope == WindowScope.Character) then
            table.insert(character, slider);
        else
            table.insert(account, slider);
        end
    end
    
    local settings = Settings.instance;
    settings.character.sliders = character;
    settings.account.sliders = account;
end

-- return the combined set of account/character quickslots
function Settings.GetQuickslots()
    local quickslots = {};
    local settings = Settings.instance;
    for i = 1, #settings.character.quickslots do
        table.insert(quickslots, settings.character.quickslots[i]);
    end
    for i = 1, #settings.account.quickslots do
        table.insert(quickslots, settings.account.quickslots[i]);
    end
    return quickslots;
end

-- set the uickslots, this will put them in the correct settings area based on scope
function Settings.SetQuickslots(quickslots)
    local character = {};
    local account = {};
    for i = 1, #quickslots do
        local quickslot = quickslots[i];
        if (quickslot.scope == WindowScope.Character) then
            table.insert(character, quickslot);
        else
            table.insert(account, quickslot);
        end
    end
    
    local settings = Settings.instance;
    settings.character.quickslots = character;
    settings.account.quickslots = account;
end

-- return the log settings
function Settings.GetLog()
    local settings = Settings.instance;
    return settings.character.log;
end
