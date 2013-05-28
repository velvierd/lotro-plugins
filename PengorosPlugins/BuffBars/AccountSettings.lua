import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

AccountSettings = class(PengorosPlugins.BuffBars.CharacterSettings);

function AccountSettings:Constructor(reset)
    PengorosPlugins.BuffBars.CharacterSettings.Constructor(self, reset);
end

function AccountSettings:GetScope()
    return Turbine.DataScope.Account;
end

function AccountSettings:SetDefaults()
    -- current settings version
    self.version = 1;

    -- quickslots 
    self.quickslots = {};
    
    -- effect windows
    self.windows = {};
    
    -- effect sliders
    self.sliders = {};
end

function AccountSettings:CheckMigration()
    local save = false;
    
    if (save) then
        self:Save();
    end
end