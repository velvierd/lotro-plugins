-- BuffBars constants

-- display formats
TimeDisplayFormat = {};
TimeDisplayFormat.Truncated = 1;
TimeDisplayFormat.Clock = 2;
TimeDisplayFormat.Literal = 3;

-- visibility scope
WindowScope = {};
WindowScope.Account = 1;
WindowScope.Character = 2;

-- visible enums
WindowVisibility = {};
WindowVisibility.Always = 1;
WindowVisibility.InCombat = 2;
WindowVisibility.OutOfCombat = 3;
WindowVisibility.HasEffects = 4;
WindowVisibility.OnMount = 5;
WindowVisibility.OnCombatMount = 6;
WindowVisibility.NotMounted = 7;

-- sort enums
EffectBarSort = {};
EffectBarSort.Time = 0;
EffectBarSort.Name = 1;
EffectBarSort.None = 2;
EffectBarSort.Category = 3;

-- bar enums
EffectBar = {};
EffectBar.Debuff = "Debuffs";
EffectBar.Buff = "Buffs";
EffectBar.CoolDown = "Cool Downs";
EffectBar.MobDebuff = "Mob Debuffs";
EffectBar.MobCC = "Mob CC";

-- orientation
SliderOrientation = {};
SliderOrientation.LeftToRight = 1;
SliderOrientation.RightToLeft = 2;
SliderOrientation.TopToBottom = 3;
SliderOrientation.BottomToTop = 4;

-- enums
Colors = {};
Colors.Undefined = Turbine.Gameplay.EffectCategory.Undefined;
Colors.Disease = Turbine.Gameplay.EffectCategory.Disease;
Colors.Fear = Turbine.Gameplay.EffectCategory.Fear;
Colors.Poison = Turbine.Gameplay.EffectCategory.Poison;
Colors.Wound = Turbine.Gameplay.EffectCategory.Wound;
Colors.Physical = Turbine.Gameplay.EffectCategory.Physical;
Colors.Elemental = Turbine.Gameplay.EffectCategory.Elemental;
Colors.Song = Turbine.Gameplay.EffectCategory.Song;
Colors.Corruption = Turbine.Gameplay.EffectCategory.Corruption;
Colors.Cry = Turbine.Gameplay.EffectCategory.Cry;
Colors.Flash = "flash";
Colors.MobDebuff = "debuff";
Colors.MobCrowdControl = "cc";

-- special constant to refer to a specific target without having the exact name
Target = {};
Target.Me = "me";
Target.MyTarget = "mt";

-- trigger templates
TriggerTemplate = {};
TriggerTemplate.Custom = 1;
TriggerTemplate.Disease = 2;
TriggerTemplate.Fear = 3;
TriggerTemplate.Poison = 4;
TriggerTemplate.Wound = 5;
TriggerTemplate.Morale = 6;
TriggerTemplate.Power = 7;

-- trigger types
TriggerType = {};
TriggerType.Effect = 1;
TriggerType.Level = 2;

-- trigger levels
TriggerLevel = {};
TriggerLevel.Morale = 1;
TriggerLevel.Power = 2;

-- effect trigger types
EffectTriggerType = {};
EffectTriggerType.Debuff = 1;
EffectTriggerType.Buff = 2;
EffectTriggerType.CoolDown = 3;
EffectTriggerType.MobDebuff = 4;
EffectTriggerType.MobCrowdControl = 5;

-- effect trigger templates
EffectTriggerTemplate = {};
EffectTriggerTemplate.Custom = 1;
EffectTriggerTemplate.AllDebuffs = 2;
EffectTriggerTemplate.AllCurableDebuffs = 3;
EffectTriggerTemplate.AllBuffs = 4;
EffectTriggerTemplate.AllCoolDowns = 5;
EffectTriggerTemplate.AllMobDebuffs = 6;
EffectTriggerTemplate.AllMobCrowdControl = 7;
