import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

EffectBarSettings = class(PengorosPlugins.BuffBars.EffectSettings);

function EffectBarSettings:Constructor(saved)
    PengorosPlugins.BuffBars.EffectSettings.Constructor(self, saved);
end

function EffectBarSettings:SetDefaults()
    PengorosPlugins.BuffBars.EffectSettings.SetDefaults(self);
    
    -- effect bars
    self.visibleType = WindowVisibility.Always; -- v4
	self.barOrder = {EffectBar.Debuff, EffectBar.Buff, EffectBar.CoolDown, EffectBar.MobDebuff, EffectBar.MobCC};
    self.fillBottomToTop = false;

    -- sort options
    self.sortMethod = EffectBarSort.Time;
    self.sortAscending = true;
    
    -- flash options
    self.allowFlashing = true;
    self.flashTime = 15;

    -- effect ui
    self.showEffectIcon = true;
    self.showEffectName = true;
    self.showEffectTimer = true;
    self.showEffectTarget = false;
    self.showEffectDuration = true; -- v4
    self.displayFormat = TimeDisplayFormat.Clock;
    self.backgroundColor = {a=128, r=0, g=0, b=0};
    self.font = Turbine.UI.Lotro.Font.Verdana12;
    
    -- colors
    self.colors = {};
    local col = Colors.Flash;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=255, g=255, b=255};
    self.colors[col].elapsed = {a=102, r=255, g=255, b=255};
    
    col = Colors.Undefined;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=121, b=254};
    self.colors[col].elapsed = {a=102, r=0, g=121, b=254};
    
    col = Colors.Disease;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=232, g=234, b=0};
    self.colors[col].elapsed = {a=102, r=232, g=234, b=0};
    
    col = Colors.Fear;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=215, g=28, b=227};
    self.colors[col].elapsed = {a=102, r=215, g=28, b=227};

    col = Colors.Poison;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=64, g=226, b=28};
    self.colors[col].elapsed = {a=102, r=64, g=226, b=28};

    col = Colors.Wound;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=255, g=29, b=29};
    self.colors[col].elapsed = {a=102, r=255, g=29, b=29};

    col = Colors.Physical;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=121, b=254};
    self.colors[col].elapsed = {a=102, r=0, g=121, b=254};

    col = Colors.Elemental;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=121, b=254};
    self.colors[col].elapsed = {a=102, r=0, g=121, b=254};

    col = Colors.Song;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=121, b=254};
    self.colors[col].elapsed = {a=102, r=0, g=121, b=254};

    col = Colors.Corruption;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=121, b=254};
    self.colors[col].elapsed = {a=102, r=0, g=121, b=254};

    col = Colors.Cry;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=121, b=254};
    self.colors[col].elapsed = {a=102, r=0, g=121, b=254};
    
    col = Colors.MobDebuff;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=178, g=78, b=0};
    self.colors[col].elapsed = {a=102, r=178, g=78, b=0};
    
    col = Colors.MobCrowdControl;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=255, b=255};
    self.colors[col].elapsed = {a=102, r=0, g=255, b=255};
    
    col = PengorosPlugins.Utils.CoolDownCategory.Morale;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=255, b=29};
    self.colors[col].elapsed = {a=102, r=0, g=255, b=29};
    
    col = PengorosPlugins.Utils.CoolDownCategory.Power;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=0, g=29, b=255};
    self.colors[col].elapsed = {a=102, r=0, g=29, b=255};
    
    col = PengorosPlugins.Utils.CoolDownCategory.Disease;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=232, g=234, b=0};
    self.colors[col].elapsed = {a=102, r=232, g=234, b=0};
    
    col = PengorosPlugins.Utils.CoolDownCategory.Fear;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=215, g=28, b=227};
    self.colors[col].elapsed = {a=102, r=215, g=28, b=227};

    col = PengorosPlugins.Utils.CoolDownCategory.Poison;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=64, g=226, b=28};
    self.colors[col].elapsed = {a=102, r=64, g=226, b=28};

    col = PengorosPlugins.Utils.CoolDownCategory.Wound;
    self.colors[col] = {};
    self.colors[col].remaining = {a=255, r=255, g=29, b=29};
    self.colors[col].elapsed = {a=102, r=255, g=29, b=29};
end

function EffectBarSettings:GetBackColor()
    return self:GetColor(self.backgroundColor);
end

function EffectBarSettings:GetRemainingColor(category)
    return self:GetColor(self.colors[category].remaining);
end

function EffectBarSettings:GetElapsedColor(category)
    return self:GetColor(self.colors[category].elapsed);
end

-- returns a copy of the color array
function EffectBarSettings:GetRemainingColorArray(category)
    local c = self.colors[category].remaining;
    return {a=c.a, r=c.r, g=c.g, b=c.b};
end

function EffectBarSettings:SetRemainingColorArray(category, color)
    self.colors[category]["remaining"] = color;
end

-- returns a copy of the color array
function EffectBarSettings:GetElapsedColorArray(category)
    local c = self.colors[category].elapsed;
    return {a=c.a, r=c.r, g=c.g, b=c.b};
end

function EffectBarSettings:SetElapsedColorArray(category, color)
    self.colors[category]["elapsed"] = color;
end
