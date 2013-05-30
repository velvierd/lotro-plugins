-- by PulseDiver 
-- Uuhty (The Ring Union kinship, Mirkwood, RU) 
-- Уухты (содружество "Союз Кольца", Мирквуд)
-- email: info[at]theringunion.ru

-- Alterable fonts
L.Font = { 
	RightPanelList = Turbine.UI.Lotro.Font.Verdana14, 
	RightPanelHeader = Turbine.UI.Lotro.Font.Verdana14,
	SelectorLegacies = Turbine.UI.Lotro.Font.Verdana14,
	ConfiguratorLegacies = Turbine.UI.Lotro.Font.TrajanPro14
};

-- command line
L["show"] = nil; -- kept in english
L["hide"] = nil; -- kept in english
L["usage: /lip [show|hide|toggle]: show/hide/toggles the Legendary Item Planner interface"] = "команда: /lip [show|hide|toggle]: показать/скрыть/переключить Legendary Item Planner";
L["/lip [show|hide|toggle]: show/hide/toggles the Legendary Item Planner interface"] = "/lip [show|hide|toggle]: показать/скрыть/переключить Legendary Item Planner";

-- main elements of the plugin
L["Choose..."] = "Выбрать...";
L["Done..."] = "Ок...";
L["Select..."] = "Выбор...";
L["Pick type:"] = "Тип:";
L["Max Tiers"] = "Макс. ур.";
L["Save"] = "Сохран.";
L["Save All"] = "Сохран. все";
L["Restore"] = "Восстан.";
L["Show when started"] = "Показ при старте";
L["Legacies"] = "Наследия";

-- Short rank form: "R0" .... "R9"
L["R"] = "R";

-- Legacy list
L["Rank:"] = "Ранг:";
L["Next:"] = "След.:";
L["Max"] = "Макс.";

-- legacy labels
L["Tier "] = "Ур. ";
L["Major"] = "Осн.";
L["Minor"] = "Мал.";
-- Description of a legacy as in "Minor Tier 6"
L["%s Tier %d"] = "%s, %d Ур.";

-- LI ages
L["first"] = "Первая";
L["second"] = "Вторая";
L["third"] = "Третья";
-- full age description of a LI (ends as "Level 75 third age" for instance)
L["Level %d %s age"] = "%d ур., %s эпоха";

-- crystal upgrades label
L["Upgrades:"] = "Улучш.:";

-- points left/spent
L["Available:"] = "Доступно:";
L["Spent:"] = "Испол.:";

-- text in the experience summary chart
L["Lvl"] = "Ур.";
L["Exp Total"] = "Всего опыта";
L["Exp Needed"] = "Нужно опыта";

-- classes 
L["Minstrel"] = "Менестрель";
L["Burglar"] = "Взломщик";
L["Lore-Master"] = "Хранитель мудрости";
L["Hunter"] = "Охотник";
L["Guardian"] = "Страж";
L["Champion"] = "Воитель";
L["Captain"] = "Рыцарь";
L["Warden"] = "Защитник";
L["Rune-keeper"] = "Хранитель рун";

-- Legendary item names
L["Weapon"] = "Оружие";
L["Song book"] = "Нотная тетрадь";
L["Tools"] = "Инструменты";
L["Melee weapon"] = "Ближний бой";
L["Javelin"] = "Метательное копье";
L["Staff"] = "Посох";
L["Book"] = "Книга";
L["Weapon (One Handed)"] = "Оружие (одноручн.)";
L["Weapon (Two Handed)"] = "Оружие (двуручн.)";
L["Rune"] = "Руна";
L["Emblem"] = "Эмблема";
L["Belt"] = "Пояс";
L["Ranged weapon"] = "Дальний бой";
L["Rune-stone"] = "Камень";
L["Rune-satchel"] = "Сумка";
L["Light Bridle"] = "Легкая уздечка";
L["Medium Bridle"] = "Средняя уздечка";
L["Heavy Bridle"] = "Тяжелая уздечка";

-- Default LI attributes
L["DPS"] = "урон/сек"
L["Tactical Damage Rating"] = "к величине тактического урона";
L["Tactical Healing Rating"] = "к величине тактического лечения";
L["Incoming Healing Rating"] = "к величине получаемого лечения";
L["Shield Use Rank"] = "к использованию щита";
L["Fury Bonus Contribution Rating"] = "к мощи напора";

-- Light Bridles
L["Class Skill Damage Over Time (Light Steed)"] = "к постепенному урону классовых умений (легкая конница)";
L["Class Skill Dismount Chance (Light Steed)"] = " к вероятности выбить врага из седла классовым умением (легкая конница)"; 
L["Rider Evade Chance (Light Steed)"] = "к уклонению всадника (легкая конница)";
L["'Wrath' Critical Chance (Light Steed)"] = "к вероятности критического удара 'Гневом' (легкая конница)";
L["'Disengaging Strikes' Dismount Chance (Light Steed)"] = "к вероятности выбить врага из седла 'Спешивающим ударом' (легкая конница)";
L["'Motivation Through Agression' Heal Chance (Light Steed)"] = "к исцелению 'Вдохновляющей агрессией' (легкая конница)"; 

-- Medium Bridles
L["Class Skill Damage Over Time Pulses (Medium Steed)"] = "длительности постепенного урона классовых умений (средняя конница)"; 
L["Class Skill Slow Duration (Medium Steed)"] = "к длительности замедления классовыми умениями (средняя конница)";
L["Rider Parry Chance (Medium Steed"] = "к парированию всадника (средняя конница)";
L["'Shields Will Be Splintered' Damage (Medium Steed)"] = "к урону от умения 'Да расколются щиты' (средняя конница)";
L["'Strong Willed' Skill Duration (Medium Steed)"] = "к длительности действия 'Сильной воли' (средняя конница)";
L["'Survivability' Damage Shield Chance (Medium Steed)"] = "к вероятности появления щита при использовании 'Живучести' (средняя конница)";

-- Heavy Bridles
L["Rider Armour Value (Heavy Steed)"] = "к броне всадника (тяжелая конница)";
L["Class Skill Forced Movement Duration (Heavy Steed)"] = "к длительности действия 'Принудительного движения' (тяжелая конница)";  
L["Rider Block Chance (Heavy Steed)"] = "к блокированию всадника (тяжелая конница)";
L["'Spears Will Be Shaken' Slow Duration (Heavy Steed)"] = "к длительности действия 'Грома копий' (тяжелая конница)"; 
L["'Conservative Combatant' Power Cost (Heavy Steed)"] = "к расходу энергии при использовании таланта 'Экономный боец' (тяжелая конница)";
L["'Benevolence' Healing Rating (Heavy Steed)"] = "к силе  исцеления 'Благоволением' (тяжелая конница)";

-- All Bridles (minor legacies)
L["Red Dawn Skill Direct Damage"] = "к урону умений школы 'Алый рассвет'";
L["Red Dawn Skill Healing"] = "к эффективности лечащих умений школы 'Алый рассвет'";
L["Red Dawn Skill Power Cost"] = "к расходу энергии на умения школы 'Алый рассвет'";
L["Riddermark Skill Direct Damage"] = "к урону умений школы 'Риддермарк'";
L["Riddermark Skill Healing"] = "к эффективности лечащих умений школы 'Риддермарк'";
L["Riddermark Skill Power Cost"] = "к расходу энергии на умения школы 'Риддермарк'";
L["Rohirrim Skill Direct Damage"] = "к урону умений школы 'Рохан'";
L["Rohirrim Skill Healing"] = "к эффективности лечащих умений школы 'Рохан'";
L["Rohirrim Skill Power Cost"] = "к расходу энергии на умения школы 'Рохан'";
L["War-steed Agility"] = "к ловкости боевого скакуна";
L["War-steed Strength"] = "к силе умений боевого скакуна";
L["War-steed Armour"] = "к броне боевого скакуна";
L["War-steed Evade Rating"] = "к показателю уклонения боевого скакуна";
L["Maximum War-steed Endurance"] = "к запасу выносливости боевого скакуна";
L["Maximum War-steed Power"] = "к запасу энергии боевого скакуна";

-- Minstrel Weapon
L["Oromë and Eärendil Damage"] = "к урону 'Зова Оромэ' и 'Зова Эарендила'"; -- 
L["Story of Courage Cooldown"] = "к перезарядке 'Истории о мужестве'"; --
L["Call of the Second Age Targets"] = "к количеству целей 'Зова Второй эпохи'"; --
L["Call to Fate Critical Multiplier"] = "к критическому урону 'Воззвания к судьбе'"; --
L["Still as Death Cooldown"] = "к перезарядке 'Безмолвия смерти'"; --
L["Soliloquy of Spirit Pulses"] = "к числу срабатываний 'Монолога духа'"; --
L["Rally! Cooldown"] = "к перезарядке умения 'Не падать духом!'"; --
L["Minor Ballad Damage"] = "к урону минорных баллад"; --
L["Perfect Ballad Damage"] = "к урону 'Совершенной баллады'"; --
L["Piercing Cry Damage"] = "к урону 'Пронзительного клича'"; --
L["Target Resist Rating (Call to War)"] = "к сопротивлению цели умениям 'Боевых мотивов'"; --
L["Triumphant Spirit Cooldown"] = "к перезарядке 'Торжества духа'"; --
L["Target Resist Rating (Invocation of Elbereth)"] = "к шансу сопротивления цели 'Воззванию к Элберет'"; --
L["Anthem Duration"] = "к длительности гимнов"; --
L["Healing Threat"] = "к угрозе при лечении"; --

-- Minstrel Song Book
L["Hammerhand Skills Bubble Magnitude"] = "к восстановлению боевого духа умениями '...Молоторукого'"; -- 
L["Anthem of Composure (Resistance)"] = "к сопротивлению под воздействием 'Гимна стойкости'";
L["Anthem of Composure (Tactical Mitigation)"] = "к смягчению тактического урона 'Гимна стойкости'"; -- 
L["Anthem of War (Physical)"] = "к физическому урону 'Гимна войне'"; --
L["Anthem of War Damage (Tactical)"] = "к тактическому урону 'Гимна войне'"; --
L["Cry of the Chorus Cooldown"] = "к перезарядке 'Незримого Хора'"; --
L["Chord of Salvation Cooldown"] = "к перезарядке 'Спасительного аккорда'"; --
L["Healing & Motivation Skills Healing"] = "к эффективности восстановления боевого духа умениями исцеления и воодушевления"; --
L["Bolster Courage Healing"] = "к исцелению 'Воодушевлением на подвиги'"; --
L["Echoes of Battle Resistance Debuff"] = "к сопротивлению 'Отзвукам битвы'";
L["Healing Skills Power Cost"] = "к расходу энергии на лечащие умения"; --
L["Raise the Spirit Healing"] = "к эффективности исцеления 'Душевным подъемом'";
L["Song of Subdual Cooldown"] = "к перезарядке 'Песни подавления'"; -- 
L["Target Resist Rating (Songs)"] = "к сопротивлению цели песням"; --
L["Target Resist Rating (Ballads)"] = "к сопротивлению цели балладам"; --
L["Inspire Fellows Healing"] = "к эффективности исцеления 'Воодушевлением союзников'"; --

-- Burglar Weapon
L["Critical Response Skill Damage"] = "к урону при 'Эхе критического удара'"; --
L["Feint Attack Cooldown"] = "к перезарядке 'Ложного выпада'";
L["Cunning Attack Bleed Stack Chance"] = "к шансу суммирования кровотечения при 'Коварном ударе'"; --
L["Burglar Skill Bleed Damage Multiplier"] = "к урону цели от кровотечения, вызванного умениями взломщика"; --
L["Location is Everything Cooldown"] = "к перезарядке умения 'Главное - верная позиция'"; --
L["Lucky Strike Cooldown"] = "к перезарядке 'Удачного удара'"; --
L["Provoke Threat Up Rating"] = "к угрозе 'Провокации'";
L["Riddle Range"] = "к дальности действия 'Загадки'"; --
L["Position Surprise Strike from Stealth"] = "к урону 'Внезапного нападения' в режиме скрытности"; --
L["Ready and Able Cooldown"] = "к перезарядке умения 'К бою готов!'"; --
L["Small Snag Cooldown"] = "к перезарядке 'Небольшой помехи'"; --
L["Subtle Stab Critical Multiplier"] = "к критическому урону 'Ловкого укола'"; --
L["Surprise Strike Critical Rating"] = "к шансу критического урона при 'Внезапном нападении'"; --
L["Subtle Stab Damage Multiplier"] = "к урону 'Ловкого укола'"; --
L["Well Placed Strike Cooldown"] = "к перезарядке 'Точного удара'";
L["Trick Range"] = "к дальности действия уловок"; --

-- Burglar Tools
L["Addle Induction Multiplier"] = "к времени применения умений целью под воздействием 'Головоломки'"; --
L["Clever Retort Damage and Healing"] = "к урону и лечению 'Остроумным ответом'"; --
L["Addle Cooldown"] = "к перезарядке 'Головоломки'"; --
L["Confound Countdown Duration"] = "к длительности 'Обескураживания'";
L["Aim Cooldown"] = "к перезарядке 'Прицеливания'";
L["Gamble Chance"] = "к шансу применения расклада"; --
L["Hide in Plain Sight Cooldown"] = "к перезарядке умения 'С глаз долой'"; --
L["Healing - Mischievous Glee"] = "к исцелению 'Злорадством' и 'Упоительным злорадством'"; --
L["Off-hand Critical Chance"] = "к шансу критического урона дополнительным оружием";
L["Increased Range for Reveal Weakness"] = "Увеличенная дальность умения 'Слабое место'";
L["Devastating Critical Buff Duration"] = "к длительности действия эффекта разрушительных ударов";
L["Stealth Level"] = "к уровню скрытности"; --
L["Non-Enrage Tricks Duration"] = "к длительности уловок, не приводящих в ярость"; --
L["Sneak Movement Speed"] = "к скорости скрытного перемещения"; --
L["Pulse Modifier for Glee"] = "к длительности 'Злорадства' и 'Упоительного злорадства'";
L["Skills Critical Multiplier"] = "к критическому урону умений"; --
L["Positional Damage"] = "к урону из выгодной позиции"; --

-- Warden Melee Weapon
L["Ambush Critical Multiplier"] = "к критическому урону 'Засады'";
L["Boar's Rush Critical Rating"] = "к шансу критического урона гамбита 'Натиск вепря'";
L["Shield Gambit Buff Duration"] = "к длительности действия усиливающих эффектов гамбитов щита"; --
L["Critical Strike Critical Multiplier"] = "к критического урону 'Критического удара'"; --
L["Spear Gambit Parry Rating"] = "к парированию при гамбитах копья"; --
L["Fist-Spear Gambit Threat"] = "к угрозе от гамбитов кулака-копья"; --
L["Wages of Fear Positional Damage"] = "к урону 'Оплаты страха' из выгодной позиции"; --
L["Hampering Javelin Duration"] = "к длительности действия 'Копья преткновения'";--
L["Surety of Death Damage Over Time"] = "к постепенному урону гамбита 'Гарантия смерти'";
L["Javelin Skills Max Range"] = "к дальности действия умений, требующих использования копья"; --
L["Gambit Lifetap Damage"] = "к постепенному урону гамбитов, крадущих здоровье"; --
L["Resolution Damage"] = "к эффективности 'Твердости'"; --
L["Spear Gambit Damage (Melee)"] = "к урону гамбитами копья в ближнем бою"; --
L["Shield Tactics Tactical Mitigation Bonus"] = "к смягчению тактического урона 'Тактикой защитника'"; -- 
L["Shield-Spear Gambit Threat"] = "к угрозе гамбитов щита-копья"; -- 
L["Power, Shield-Spear Gambit Line"] = "к расходу энергии на гамбиты щита-копья";
L["Recklessness Attack Duration"] = "к продолжительности атак в стойке 'Безрассудство'"; --
L["Power, Fist-Spear Gambit Line"] = "к расходу энергии на гамбиты кулака и копья"; --

-- Warden Javelin
L["Fist Gambit Evade Rating Bonus"] = "к уклонению при гамбитах кулака";
L["Ambush and Careful Step Induction"] = "ко времени применения 'Засады' и 'Осторожного шага'"; --
L["Shield Gambit Line Healing Bonus"] = "к эффективности исцеления гамбитами щита"; --
L["In Combat Power Regeneration"] = "к восстановлению энергии в бою"; --
L["Adroit Maneuver Duration"] = "к длительности действия 'Ловкого маневра'";
L["Careful Step Duration"] = "к длительности 'Осторожного шага'"; --
L["Resolution Resist Rating"] = "к сопротивлению цели 'Твердости'";
L["Determination Morale Regen"] = "к восстановлению б.д. в бою в стойке 'Решимости'";
L["Javelin Skills To-Hit Movement Penalty"] = "к штрафу точности при использовании метательного копья в движении"; --
L["Forced March Movement Bonus"] = "к скорости передвижения при 'Форсированном марше'"; --
L["Fist Gambit Critical Rating"] = "к вероятности критического урона при гамбитах кулака"; --
L["Power, Spear-Shield Gambit Line"] = "к расходу энергии на гамбиты копья-щита";
L["Fist Gambit Buff Duration Bonus"] = "к длительности действия усиливающих эффектов гамбитов кулака"; --
L["Shield Mastery Block Rating"] = "к блокированию гамбита 'Мастер владения щитом'";
L["Spear-Shield Damage Bonus"] = "к урону гамбитов копья и щита"; --
L["Defiant Challenge Cooldown Modifier"] = "к перезарядке 'Вызова судьбе'"; --
L["Heal Bonus for Conviction"] = "к эффективности исцеления 'Убеждением'"; --
L["Shield Piercer Duration"] = "к длительности 'Пронзающего щиты'"; --

-- Lore-master Staff
L["Burning Ember Initial Damage"] = "к начальному урону от 'Пылающих углей'";
L["Cracked Earth Range"] = "к дальности действия 'Расколотой земли'";
L["Burning Embers Range"] = "к дальности действия 'Пылающих углей'";
L["Ents Go To War Damage"] = "к урону 'Энты идут на войну'";
L["Cracked Earth Damage"] = "к урону 'Расколотой земли'";
L["Fire Skills Critical Multiplier"] = "к критическому урону умений, связанных с огнем";
L["Lightning Skills Critical Rating"] = "к критическому урону умений, связанных с молнией";
L["Gust of Wind Damage"] = "к урону 'Воздушного вихря'";
L["Light of the Rising Dawn Critical Multiplier"] = "к критическому урону 'Света восходящей зари'";
L["Lightning Storm Damage"] = "к урону 'Грозовой бури'";
L["Light of the Rising Dawn Damage"] = "к урону 'Света восходящей зари'";
L["Share the Power Increase"] = "к эффективности 'Разделенной энергии'";
L["Tactical Skills Direct Damage"] = "к прямому урону от тактических умений";
L["Sticky Gourd Direct Damage"] = "к урону 'Бутыли со смолой'";
L["Staff Strike Cooldown"] = "к перезарядке 'Удара посохом'";
L["Test of Will Damage"] = "к урону 'Испытания воли'";
L["Storm-lore Damage"] = "к урону 'Власти над громом'";

-- Lore-master Book
L["Ancient Craft Targets"] = "к числу целей 'Древнего ремесла'";
L["Bane Flare Target"] = "к числу целей 'Изгоняющей вспышки'";
L["Burning Embers Pulses"] = "к числу срабатываний 'Пылающих углей'";
L["Wizard Fire Pulses"] = "к числу срабатываний 'Знак битвы: Огонь волшебника'";
L["Fire Damage Over Time"] = "к постепенному урону огнем";
L["Threat - Sign of the Wild: Rage"] = "к угрозе 'Знака природы: Ярость'";
L["Test of Will Devastate Damage"] = "к разгромному урону 'Испытания воли'";
L["Fire Skills Critical Rating"] = "к шансу критического урона умений, связанных с огнем";
L["Target Resistance (Fire Skills)"] = "к сопротивлению цели урону огнем";
L["Fire-lore Targets"] = "к числу целей 'Власти над огнем'";
L["Healing from Beacon of Hope"] = "к величине исцеления от умения 'Маяк надежды'";
L["Target Resistance (Debuffing Skills)"] = "к сопротивлению цели ослабляющим умениям";
L["Signs of Power Durations"] = "к длительности 'Знаков силы'";
L["Target Resistance (Damaging Skills)"] = "к сопротивлению цели урону умениями";
L["Inner Flame Healing"] = "к эффективности исцеления 'Внутренним огнем'";
L["Morale - Sign of the Wild: Protection"] = "к запасу боевого духа от умения 'Знак природы: Защита'";

--- Champion Weapon
L["Area of Effect Skill Damage"] = "к урону умений с действием на область"; --
L["Targeted Melee Skills Range"] = "к дальности действия умений ближнего боя"; --
L["Brutal Strikes Damage"] = "к урону 'Жестокого удара'"; --
L["Critical Damage Multiplier"] = "к критическому урону"; --
L["Feral/Savage Strikes Damage"] = "к урону 'Диких ударов' и 'Свирепой атаки'"; --
L["Relentless/Remorless Strikes Damage"] = "к урону 'Безжалостного удара' и 'Беспощадного удара'"; --
L["Wild Attack Damage"] = "к урону 'Неистовой атаки'"; --
L["Fear Nothing Cooldown"] = "к перезарядке умения 'Ничего не бойся!'";
L["Hamstring Duration"] = "к длительности 'Перерезанных поджилок'";
L["Ferocious Strikes Cooldown"] = "к перезарядке 'Яростных ударов'";
L["Horn Damage"] = "к урону от рога";
L["Increased Rend Armour Reduction"] = "к снижению брони от 'Рваной раны'";
L["Battle Frenzy Cooldown"] = "к перезарядке 'Исступления битвы'"; --
L["Rend Bleed Damage"] = "к урону от кровотечения 'Рваной раны'"; --
L["Sudden Defence Cooldown"] = "к перезарядке 'Ухода в оборону'"; --
L["Sprint Duration"] = "к длительности 'Рывка'";

-- Champion Rune
L["Blade Line Area Damage Power Cost"] = "к расходу энергии на 'Яростные атаки'"; --
L["Ardour/Glory Pip Interval"] = "к интервалу получения боевого пыла при использовании 'Жара схватки' и 'Ореола Славы'"; --
L["Ardour/Glory in-Combat Power Regen"] = "к восстановлению энергии в бою 'Жаром схватки' и 'Ореолом славы'";
L["Adamant/Invincible Duration"] = "к длительности 'Адаманта' и 'Неуязвимого'";
L["Ardour/Glory Parry and Evade Rating"] = "к парированию и уклонению при 'Жаре схватки' и 'Ореоле славы'"; --
L["Champion Skill Bubble Magnitude"] = "к радиусу умений воителя с действием на область (на самом деле - к силе баблов воителя!!!)"; -- ололо локализаторы! ;) "к восстановлению боевого духа умениями воителя"
L["Heroics Morale Heal Chance"] = "к шансу восстановления боевого духа от 'Героизма'"; --
L["Bracing Attack Heal"] = "к исцелению 'Стойким ударом'"; --
L["Dire Need Cooldown"] = "к перезарядке 'Отчаянной нужды'"; --
L["Ebbing Ire Cooldown"] = "к перезарядке 'Затихающего гнева'"; --
L["(Glory) Hedge Armour Rating Mod"] = "к броне при 'Отстранении'";
L["Strikes Line Power Cost"] = "к расходу энергии на 'Линию ударов'"; --
L["Swift Strike/Swift Blade Power Cost"] = "к расходу энергии на 'Быстрый удар' и 'Быстрый клинок'";
L["Stun Duration - Champion's Horn"] = "к продолжительности оглушения 'Рога воителя'"; --
L["Fight On Duration"] = "к длительности 'Отчаянного рывка'";
L["Rend Pulses"] = "к длительности 'Рваной раны'"; --
L["Battle Acuity Duration"] = "к длительности 'Боевой проницательности'"; --

-- Captain Weapon 
L["Blade of Elendil Damage"] = "к урону 'Клинка Элендила'"; --
L["Cry Power Cost"] = "к затратам энергии на кличи"; --
L["Defensive Strike Armour Buff"] = "к броне при 'Защитном ударе'"; --
L["Devastating Blow Critical Rating"] = "к шансу критического эффекта 'Разгромного удара'";
L["Cutting Attack Bleed Damage"] = "к урону от кровотечения при 'Режущем ударе'";
L["Make Haste Duration"] = "к длительности 'Спешки'"; --
L["Kick Cooldown"] = "к перезарядке 'Пинка'";
L["Pressing Attack Max Targets"] = "к числу целей 'Теснящего удара'";
L["Melee Skill Power Cost"] = "к затратам энергии на умения ближнего боя";
L["Pressing Attack Critical Rating"] = "к шансу критического эффекта 'Теснящего удара'"; --
L["Routing Cry Damage"] = "к урону от умения 'Грозный клич'";
L["Tactics: On Guard Parry Rating Buff"] = "к парированию при умении 'Тактика: Защита'"; --
L["Tactics: Relentless Attack Critical Rating Buff"] = "к величине критического урона при умении 'Тактика: Битва без устали'"; --
L["Telling Mark Damage"] = " к урону при 'Указующей метке'"; --
L["Morale from Motivating Speech"] = "к восстановлению боевого духа от 'Вдохновенной речи'"; --
L["To Arms Duration"] = "к длительности умения 'К оружию'"; --
L["Battle States and Defeat Response Duration"] = "к длительности действия 'Эха победы' и боевых состояний"; -- 

-- Captain Emblem
L["Escape from Darkness Cooldown"] = "к перезарядке 'Побега от тьмы'"; -- 
L["Shield of the Dunedain Cooldown"] = "к перезарядке 'Щита дунаданов'";
L["Words of Courage Pulses"] = "к длительности действия 'Слов поддержки'"; --
L["Grave Wound Cooldown"] = "к перезарядке 'Серьезной раны'";
L["Rallying Cry Healing"] = "к исцелению 'Вдохновляющим кличем'"; --
L["Strength of Will Effects"] = "к эффектам исцеления 'Силой воли'"; -- 
L["Rallying Cry Cooldown"] = "к перезарядке 'Вдохновляющего клича'"; --
L["Melee Skills Healing"] = "к исцелению от умений ближнего боя"; --
L["Muster Courage Cooldown"] = "к перезарядке 'Речи о мужестве'";
L["Shadow's Lament Cooldown"] = "к перезарядке 'Плача теней'";
L["Time of Need Morale Cost"] = "к расходу боевого духа на 'Трудное положение'";
L["Valiant Strike Morale Return"] = "к исцелению 'Героическим ударом'"; --
L["Tactics: Focus in-Combat Power Regen Buff"] = "к восстановлению энергии в бою умением 'Тактика: Сосредоточенность'"; --
L["Time of Need Cooldown"] = "к перезарядке 'Трудного положения'"; --
L["Vocal Skills Healing"] = "к исцелению от песен"; --
L["Words of Courage Power and Morale Cost"] = "к расходу энергии и боевого духа на 'Слова поддержки'";

-- Guardian Weapon
L["Charge Duration"] = "к длительности 'Броска'";
L["Guardian Area Effect Melee Targets"] = "к количеству целей для атак ближнего боя с воздействием на область"; --
L["Bash Damage"] = "к урону 'Оглушающего щита'"; --
L["Brutal Assault Damage"] = "к урону от 'Яростного штурма'"; --
L["Guardian Bleed Damage"] = "к урону от кровотечения, вызванного умениями стража"; --
L["Guardian Bleed Pulses"] = "к длительности действия умения 'Кровотечение стража'";
L["Overwhelm Critical Rating"] = "к шансу критического урона 'Сокрушительного удара'"; --
L["Stamp Cooldown"] = "к перезарядке 'Удара в землю'"; --
L["Sweeping Cut Damage"] = "к урону 'Мельницы'"; --
L["Guardian's Ward Duration"] = "к длительности 'Оберега стража'"; --
L["Targeted Melee Skills Range"] = "к дальности действия умений ближнего боя"; --
L["Guardian's Pledge Cooldown"] = "к перезарядке 'Обета стража'"; --
L["Whirling Retaliation Damage"] = "к урону 'Вихря возмездия'"; --
L["Vexing Blow Damage"] = "к урону от 'Удара по самолюбию'"; --
L["Turn the Tables Cooldown"] = "к перезарядке 'Обмена ролями'";
L["Warrior's Heart/Fortitude Duration"] = "к длительности 'Сердца воина' и 'Стойкости воина'"; -- 
L["To the King Damage"] = "к урону 'За короля!'";
L["Overwhelm Damage"] = "к урону от 'Сокрушительного удара'"; -- new legacy

-- Guardian Belt
L["Catch a Breath Cooldown"] = "к перезарядке 'Передышки'"; --
L["Catch a Breath Morale Heal"] = "к исцелению во время 'Передышки'"; --
L["Cry Resist Chance"] = "к сопротивлению цели кличам";
L["Challenge Targets"] = "к количеству целей 'Вызова'"; --
L["Guardian's Threat Block and Parry Rating"] = "к блокированию и парированию 'Угрозы стража'"; --
L["Guardian's Ward Block Rating"] = "к блокированию при 'Обереге стража'"; -- 
L["Guardian's Ward Damage"] = "к урону 'Оберега стража'";
L["Power Restore on Reactions"] = "к восстановлению энергии при 'Ответных ударах'"; --
L["Guardian's Ward Parry Rating"] = "к парированию при 'Оберега стража'"; --
L["Reactive Block Damage"] = "к урону 'Агрессивного блокирования'";
L["Increased Block, Parry and Evade from Protection"] = "увеличеное блокирование, парирование и уклонение в стойке защиты";
L["Shield Damage"] = "к урону от щита"; --
L["Shield Wall Range"] = "к дальности действия 'Бастиона'"; --
L["Shield Smash Damage"] = "к урону 'Разящим щитом'"; --
L["Stagger Critical Rating"] = "к шансу критического урона 'Потрясения'"; --
L["Threat Generation Up Rating"] = "к набору угрозы"; --
L["Stagger Effect Duration"] = "к длительности 'Потрясения'"; --
L["Warrior's Heart/Fortitude Morale Heal"] = "к исцелению умениями 'Сердце воина' и 'Стойкость воина'"; --
L["Stagger Positional Damage"] = "к урону 'Потрясения'";
L["Sting Damage"] = "к урону от 'Укола'"; --

-- Hunter Ranged Weapon
L["Burn Hot Damage"] = "к урону при использовании умения 'Пламенный стрелок'"; --
L["Distracting Shot Resistance Penetration"] = "к шансу сопротивлению цели 'Отвлекающему выстрелу'"; --
L["Endurance Quick Shot Threat Down, Rating"] = "к угрозе 'Быстрого выстрела'"; --
L["Distracting Shot Cooldown"] = "к перезарядке 'Отвлекающего выстрела'"; --
L["Barbed Arrow Bleed Damage"] = "к кровотечению от 'Зазубренной стрелы'"; --
L["Focus Bow Threat Down, Rating"] = "к угрозе выстрелов, расходующих сосредоточенность"; --
L["Induction Bow Power Cost"] = "к затратам энергии на выстрелы, требующие подготовки"; --
L["Heart Seeker Damage"] = "к урону 'Выстрела в сердце'"; --
L["Induction Bow Critical Multiplier"] = "к критическому урону выстрелов, требующих подготовки"; --
L["Focus Bow Critical Multiplier"] = "к критическому урону выстрелов, расходующих сосредоточенность"; --
L["Focus Bow Power Cost"] = "к затратам энергии на выстрелы, расходующие сосредоточенность";
L["Quick Shot Critical Chance"] = "к шансу критического урона 'Быстрым выстрелом'"; --
L["Ranged Skill Evade Chance Modifier"] = "к уклонению цели в дальнем бою"; 
L["Ranged Evade Rating"] = "к уклонению в дальнем бою"; --
L["Induction Bow Threat Down, Rating"] = "к угрозе выстрелов, требующих подготовки"; --
L["Ranged Skill Block Chance Modifier"] = "к шансу блокированию цели в дальнем бою"; --
L["Merciful Shot Cooldown"] = "к перезарядке 'Выстрела милосердия'"; --
L["Quick Shot Slow in Strength"] = "к замедлению 'Быстрым выстрелом'"; -- 

-- Hunter Melee Weapon
L["Agile Rejoinder Heal Multiplier"] = "к эффективности исцеления 'Ловким отпором'"; -- 
L["Blindside Critical Rating"] = "к шансу критического урона 'Удара исподтишка'"; --
L["Desperate Flight Cooldown"] = "к перезарядке 'Отчаянного побега'"; --
L["Critical Magnitude in Precision Stance"] = "к критическому урону в стойке 'Меткости'"; --
L["Beneath Notice Cooldown"] = "к перезарядке 'Безобидного вида'"; --
L["Find the Path Movement Speed"] = "к скорости передвижения при 'Поиске пути'"; --
L["Improved Strength of Earth Morale Regen"] = "к исцелению улучшенной 'Силой земли'"; --
L["Maximum Targets for AoE Skills"] = "к количеству целей умений, действующих на область"; --
L["Low Cut Bleed Chance"] = "к шансу кровотечения при 'Перерезанных сухожилиях'"; --
L["Melee Critical Multiplier"] = "к критическому урону в ближнем бою"; --
L["Melee Critical Rating"] = "к шансу критического урона в ближнем бою";
L["Needful Haste Duration"] = "к длительности 'Драгоценной скорости'"; --
L["Stealth Detection"] = "к обнаружению скрытых врагов"; --
L["Power Restored by Deep Concentration"] = "к восстановлению энергии 'Намеренной сосредоточенностью'"; --
L["Swift Stroke Parry and Evade Rating"] = "к уклонению и парированию при 'Быстром ударе'"; --
L["Press Onward Cooldown"] = "к перезарядке 'Не зная отдыха'";

-- Rune-keeper Rune-Stone
L["Fire Skill Damage"] = "к урону от огня";
L["Battle Attuned Skill Power Cost"] = "к затратам энергии при настрое на битву";
L["Chill of Winter Debuff Duration"] = "к длительности умений 'Дыхания зимы'";
L["Chill of Winter Damage"] = "к урону от умений 'Дыхания зимы'";
L["Distracting Flame Cooldown"] = "к перезарядке 'Отвлекающего огня'";
L["Fury of Storm Damage"] = "к урону умений 'Бешенства бури'";
L["Healing"] = "к эффективности исцеления";
L["Glorious Foreshadowing Duration"] = "к длительности 'Славного предзнаменования'";
L["Healing Over Time"] = "к постепенному исцелению";
L["Healing Attuned Skill Power Cost"] = "к затратам энергии при настрое на исцеление";
L["Fury of Storm Critical Multiplier"] = "к критическому урону 'Бешенства бури'";
L["Vivid Imagery Targets"] = "к количеству целей 'Живого образа'";
L["Wrath of Flame Damage Over Time"] = "к постепенному урону умений 'Гнева пламени'";
L["Steady Attuned Skill Power"] = "к затратам энергии при равновесии";
L["Finesse Rating"] = "к рейтингу искусности";

-- Rune-keeper Rune-Satchel
L["Chilling Rhetoric Cooldown"] = "к перезарядке 'Холодной иронии'";
L["Ceaseless Argument Damage"] = "к урону от 'Бесконечного спора'";
L["Distracting Winds Cooldown"] = "к перезарядке 'Отвлекающего ветра'";
L["Do Not Fall This Day Cooldown"] = "к перезарядке умения 'Поражения не будет'";
L["Epic for the Ages Healing"] = "к исцелению от 'Эпоса на века'";
L["Essence of Flame Damage"] = "к урону от 'Сути пламени'";
L["Mending Verse Healing"] = "к исцелению от 'Целительных виршей'";
L["Frozen Epilogue Cooldown"] = "к перезарядке 'Леденящего эпилога'";
L["Pulses Prelude to Hope"] = "к длительности 'Прелюдии надежды'";
L["Scribe's Spark Damage"] = "к урону от 'Искры писца'";
L["Self Motivation Cooldown"] = "к перезарядке 'Стремления к Победе'";
L["Shocking Words Stun Chance"] = "к шансу оглушения 'Оглушающими словами'";
L["Writ of Fire Damage"] = "к урону от 'Письмен пламени'";
L["Writ of Health Healing"] = "к исцелению от 'Письмен здоровья'";
L["Word of Exaltation Cooldown"] = "к перезарядке 'Слов превознесения'";
L["Target Shocking Touch Resist Rating"] = "к сопротивлению 'Ошеломляющему касанию'";

-- Stat legacies
L["Agility"] = "Ловкость";
L["Fate"] = "Вера";
L["Might"] = "Сила";
L["Vitality"] = "Стойкость";
L["Will"] = "Воля";