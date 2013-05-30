-- Übersetzt von Amethadan Celebhathol (Silberklinge)
-- in Zusammenarbeit mit den Heerführern Arnors vom Server Maiar
-- www.arnor.tk

-- Diverse Einträge wurden aus dem Shop gelesen und eingefügt. Diese müssen noch überprüft und korrigiert werden!!! In LIP die ganzen mit .. am Anfang und Ende
-- Some Things are taken out of the Shop, so they need to be prooved and changed. In LIP this are all Things with .. on Beginning and the End

-- Alternative Fonts
L.Font = { 
	RightPanelList = Turbine.UI.Lotro.Font.Verdana14, 
	RightPanelHeader = Turbine.UI.Lotro.Font.Verdana14,
	SelectorLegacies = Turbine.UI.Lotro.Font.Verdana14,
	ConfiguratorLegacies = Turbine.UI.Lotro.Font.TrajanPro14
};

-- Commandos
L["show"] = nil; -- in englisch belassen
L["hide"] = nil; -- in englisch belassen
L["usage: /lip [show|hide|toggle]: show/hide/toggles the Legendary Item Planner interface"] = "Verwendung: /lip [show|hide|toggle]: zeigt/verbirgt oder schaltet das LIP Interface um";
L["/lip [show|hide|toggle]: show/hide/toggles the Legendary Item Planner interface"] = "/lip [show|hide|toggle]: zeigt/verbirgt oder schaltet das LIP Interface um";

-- Standard Elemente des Plugins
L["Choose..."] = "Wähle ...";
L["Done..."] = "Fertig ...";
L["Select..."] = "Wähle ...";
L["Pick type:"] = "Wähle Art:";
L["Max Tiers"] = "Max. Stufe";
L["Save"] = "Speichern";
L["Save All"] = "Alles speichern";
L["Restore"] = "Wiederherstellen";
L["Show when started"] = "Zeige wenn gestartet";
L["Legacies"] = "Attribute";

-- Kurzform der Ränge: "R0" .... "R9"
L["R"] = "R";

-- Attributsliste
L["Rank:"] = "Rang:";
L["Next:"] = "Weiter:";
L["Max"] = "Max:";

-- Atributslabel
L["Tier "] = "Stufe";
L["Major"] = "Haupt";
L["Minor"] = "Neben";
-- Bezeichnung eines Attributs wie in "Haupt|attribut Stufe 6"
L["%s Tier %d"] = "%sattribut %d";

-- Legendäre Item Zeitalter
L["first"] = "erstes";
L["second"] = "zweites";
L["third"] = "drittes";
-- Gesamte Zeitalter Bezeichnung eines legend\195\164ren Items (endet als "Level 75 drittes Zeitalter" zum Beispiel)
L["Level %d %s age"] = "Level %d %s Zeitalter";

-- Kristall Erweiterung Label
L["Upgrades:"] = "Erweiterungen:";

-- Punkte übrig/verbraucht
L["Available:"] = "Übrig:";
L["Spent:"] = "Verbraucht:";

-- Text im Erfahrungs Berechnungsbereich
L["Lvl"] = "Lvl";
L["Exp Total"] = "Exp gesamt"; 
L["Exp Needed"] = "Exp nötig";

-- Klassen 
L["Minstrel"] = "Barde";
L["Burglar"] = "Schurke";
L["Lore-Master"] = "Kundiger";
L["Hunter"] = "Jäger";
L["Guardian"] = "Wächter";
L["Champion"] = "Waffenmeister";
L["Captain"] = "Hauptmann";
L["Warden"] = "Hüter";
L["Rune-keeper"] = "Runenbewahrer";

-- Legendäre Item Namen
L["Weapon"] = "Waffe";
L["Song book"] = "Gesangsbuch";
L["Tools"] = "Werkzeuge";
L["Melee weapon"] = "Nahkampfwaffe";
L["Javelin"] = "Wurfspiess";
L["Staff"] = "Stab";
L["Book"] = "Buch";
L["Weapon (One Handed)"] = "Einhändige Waffe";
L["Weapon (Two Handed)"] = "Zweihändige Waffe";
L["Rune"] = "Rune";
L["Emblem"] = "Zeichen";
L["Belt"] = "Gürtel";
L["Ranged weapon"] = "Fernkampfwaffe";
L["Rune-stone"] = "Runenstein";
L["Rune-satchel"] = "Runenbeutel";
L["Light Bridle"] = "Leichtes Zaumzeug"; 
L["Medium Bridle"] = "Mittleres Zaumzeug"; 
L["Heavy Bridle"] = "Schweres Zaumzeug"; 

-- Standard Legendäre Item Attribute
L["DPS"] = "DPS";
L["Tactical Damage Rating"] = "Wert: Taktischer Schaden";
L["Tactical Healing Rating"] = "Wert: Taktische Heilung";
L["Incoming Healing Rating"] = "Wert: Empfangene Heilung";
L["Shield Use Rank"] = "Schild-Verwendungs-Rang";
L["Fury Bonus Contribution Rating"] = "Bonus für Beitrag zu 'Wut'";
 
-- H=Hauptattribut (Major) N=Nebenattribut (Minor)
-- Leichtes Zaumzeug
L["Class Skill Damage Over Time (Light Steed)"] = "Klassenfertigkeit: Schaden über Zeit (leichtes Ross)"; -- H
L["Class Skill Dismount Chance (Light Steed)"] = "Klassenfertigkeit: Abwurf-Wahrscheinlichkeit (leichtes Ross)"; -- H
L["Rider Evade Chance (Light Steed)"] = "Reiter-Ausweich-Wahrscheinlichkeit (leichtes Ross)"; -- H
L["'Wrath' Critical Chance (Light Steed)"] = "Kritische Chance durch 'Zorn' (leichtes Ross)"; -- H
L["'Disengaging Strikes' Dismount Chance (Light Steed)"] = "Entsattelnde Schläge - Abwurf-Wahrscheinlichkeit (leichtes Ross)"; -- H
L["'Motivation Through Agression' Heal Chance (Light Steed)"] = "..Heilungschance durch 'Aggressives Motivieren' (leichtes Ross).."; -- H ***** NOCH ZU PRÜFEN *****

-- Mittleres Zaumzeug
L["Class Skill Damage Over Time Pulses (Medium Steed)"] = "Klassenfertigkeit: 'Schaden über Zeit' Impulse (mittleres Ross)"; -- H
L["Class Skill Slow Duration (Medium Steed)"] = "Klassenfertigkeit: Langsame Dauer (mittleres Ross)"; -- H
L["Rider Parry Chance (Medium Steed"] = "Reiter-Parier-Wahrscheinlichkeit (mittleres Ross)"; -- H
L["'Shields Will Be Splintered' Damage (Medium Steed)"] = "Schaden durch 'Schilde werden zerschlagen' (mittleres Ross)"; -- H
L["'Strong Willed' Skill Duration (Medium Steed)"] = "Dauer der Fertigkeit 'Starker Wille' (mittleres Ross)"; -- H
L["'Survivability' Damage Shield Chance (Medium Steed)"] = "Wahrscheinlichkeit dass 'Überlebensfähigkeit' einen Schild erzeugt (mittleres Ross)"; -- H

-- Schweres Zaumzeug
L["Rider Armour Value (Heavy Steed)"] = "Reiter-Rüstungswert (schweres Ross)"; -- H
L["Class Skill Forced Movement Duration (Heavy Steed)"] = "Klassenfertigkeit: Dauer von Erzwungene Bewegung (schweres Ross).."; -- H
L["Rider Block Chance (Heavy Steed)"] = "Reiter-Block-Wahrscheinlichkeit (schweres Ross)"; -- H
L["'Spears Will Be Shaken' Slow Duration (Heavy Steed)"] = "..Verlangsamungs-Dauer von 'Speere werden geschwungen' (schweres Ross).."; -- H ***** NOCH ZU PRÜFEN *****
L["'Conservative Combatant' Power Cost (Heavy Steed)"] = "Kraftkosten von 'Vorsichtiger Kämpfer' (schweres Ross)"; -- H
L["'Benevolence' Healing Rating (Heavy Steed)"] = "Heilungswert von 'Gütige Gabe' (schweres Ross)"; -- H

-- Zaumzeug komplett(Nebenattribute)
L["Red Dawn Skill Direct Damage"] = "Direkter Schaden durch 'Morgenröte'-Fertigkeit"; -- N
L["Red Dawn Skill Healing"] = "Morgenröte: Heilung"; -- N
L["Red Dawn Skill Power Cost"] = "Kraftkosten der 'Morgenröte'-Fertigkeit"; -- N
L["Riddermark Skill Direct Damage"] = "Direkter Schaden durch 'Riddermark'-Fertigkeit"; -- N
L["Riddermark Skill Healing"] = "Riddermark: Heilung"; -- N
L["Riddermark Skill Power Cost"] = "Kraftkosten der 'Riddermark'-Fertigkeit"; -- N
L["Rohirrim Skill Direct Damage"] = "Direkter Schaden durch 'Rohirim'-Fertigkeit"; -- N
L["Rohirrim Skill Healing"] = "Rohirim: Heilung"; -- N
L["Rohirrim Skill Power Cost"] = "Kraftkosten der 'Rohirim'-Fertigkeit"; -- N
L["War-steed Agility"] = "Kriegsrossbeweglichkeit"; -- N
L["War-steed Strength"] = "Kriegsrossstärke"; -- N
L["War-steed Armour"] = "Kriegsross-Rüstung"; -- N
L["War-steed Evade Rating"] = "Ausweichwert des Kriegsrosses"; -- N
L["Maximum War-steed Endurance"] = "Maximale Kriegsrossausdauer"; -- N
L["Maximum War-steed Power"] = "Maximale Kriegsrosskraft"; -- N

-- Barden Waffe
L["Healing Threat"] = "Heilungs-Bedrohung"; -- H
L["Piercing Cry Damage"] = "Schaden durch 'Durchdringender Schrei'"; -- H
L["Oromë and Eärendil Damage"] = "Schaden durch Orome und Earendil"; -- H
L["Soliloquy of Spirit Pulses"] = "Impulse bei 'Selbstgespräch des Geistes'"; -- H
L["Triumphant Spirit Cooldown"] = "Triumphierender Geist Abklingzeit"; -- H
L["Rally! Cooldown"] = "Abklingzeit für 'Neue Kraft'"; -- H
L["Target Resist Rating (Call to War)"] = "Wiederstand des Ziels ('Kampfaufforderung')"; -- H
L["Anthem Duration"] = "Dauer: Kriegsrede Anschlusseffekt (Hymnendauer)"; -- H
L["Call to Fate Critical Multiplier"] = "Krit. Schaden für 'Appell an das Schicksal'"; -- N
L["Minor Ballad Damage"] = "Schaden bei Moll-Ballade"; -- N
L["Perfect Ballad Damage"] = "Schaden bei 'Perfekte Ballade'"; -- N
L["Still as Death Cooldown"] = "Abklingzeit für 'Todesstarre'"; -- N
L["Call of the Second Age Targets"] = "Ziele von 'Ruf des zweiten Zeitalters'"; -- N
L["Target Resist Rating (Invocation of Elbereth)"] = "Resistenz des Ziels: Anrufung Elbereths"; -- N
L["Story of Courage Cooldown"] = "Abklingzeit von 'Furcht heilen'"; -- N

-- Barden Gesangsbuch
L["Bolster Courage Healing"] = "Heilung durch 'Ermutigung'"; -- H
L["Healing & Motivation Skills Healing"] = "Heilung durch Heilungs- und Motivationsfertigkeiten"; -- H
L["Healing Skills Power Cost"] = "Heilfertigkeiten: Kraftkosten"; -- H
L["Inspire Fellows Healing"] = "Heilung durch 'Gefährten inspirieren'"; -- H
L["Raise the Spirit Healing"] = "Heilung durch 'Auferstehung der Seele'"; -- H
L["Anthem of War Damage (Tactical)"] = "Hymne des Krieges: Taktischer Schaden"; -- H
L["Anthem of War Damage (Physical)"] = "Hymne des Krieges: Nahkampf- und Fernkampfschaden"; -- H
L["Target Resist Rating (Ballads)"] = "Resistenzwert des Ziels gegen Ballade"; -- H
L["Chord of Salvation Cooldown"] = "Abklingzeit für 'Akord der Erlösung'"; -- N
L["Cry of the Chorus Cooldown"] = "Abklingzeit für 'Schrei des Chors'"; -- N
L["Hammerhand Skills Bubble Magnitude"] = "Hammerhand-Fertigkeiten: Sphärenausmass"; -- N
L["Anthem of Composure (Tactical Mitigation)"] = "Hymne der Selbstbeherrschung (taktische Schadensreduzierung)"; -- N
L["Echoes of Battle Resistance Debuff"] = "Resistenz gegen Schwächung 'Widerhall des Kampfes'"; -- N
L["Anthem of Composure (Resistance)"] = "Hymne der Selbstbeherrschung (Resistenz)"; -- N
L["Target Resist Rating (Songs)"] = "Widerstand des Ziels (Lieder)"; -- N
L["Song of Subdual Cooldown"] = "Abklingzeit von 'Lied der Unterjochung'" -- N

-- Schurken Waffe
L["Critical Response Skill Damage"] = "Schaden bei 'Kritische Erwiederung'"; -- H
L["Feint Attack Cooldown"] = "Abklingzeit für 'Scheinangriff'"; -- H
L["Cunning Attack Bleed Stack Chance"] = "Wahrscheinlichkeit das Blutungschaden von 'Täuschender Angriff' stapelt"; -- H
L["Burglar Skill Bleed Damage Multiplier"] = "Multiplikator: Blutungsschaden durch Schurken-Fertigkeiten"; -- H
L["Position Surprise Strike from Stealth"] = "Positionsbezogener Bonus auf 'Überraschungsschlag' aus dem Schleichen"; -- H
L["Subtle Stab Critical Multiplier"] = "'Rafinierter Stich' Multiplikator für kritische Treffer"; -- H
L["Small Snag Cooldown"] = "Abklingzeit für 'Kleiner Schnitt'"; -- H
L["Surprise Strike Critical Rating"] = "Wert für kritischen Treffer mit 'Überraschungsschlag'"; -- H
L["Location is Everything Cooldown"] = "Abklingzeit für 'Gewusst wo'"; -- N
L["Lucky Strike Cooldown"] = "..Abklingzeit: 'Glückstreffer'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Provoke Threat Up Rating"] = "..Bedrohung provozieren.."; -- N ***** NOCH ZU PRÜFEN *****
L["Riddle Range"] = "..Reichweite von Rätseln.."; -- N ***** NOCH ZU PRÜFEN *****
L["Ready and Able Cooldown"] = "..Abklingzeit: 'Bereit und befähigt'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Subtle Stab Damage Multiplier"] = "..'Raffinierter Stich': Multiplikator für kritische Treffer.."; -- N ***** NOCH ZU PRÜFEN *****
L["Well Placed Strike Cooldown"] = "Abklingzeit für 'Wohlplazierter Schlag'"; -- N
L["Trick Range"] = "..Reichweite von Tricks.."; -- N ***** NOCH ZU PRÜFEN *****

-- Schurken Werkzeuge
L["Aim Cooldown"] = "Abklingzeit für 'Zielen'.."; -- H
L["Addle Cooldown"] = "Tumult-Abklingzeit"; -- H
L["Devastating Critical Buff Duration"] = "..Stärkungsdauer bei zerstörerischen kritischen Treffern.."; -- H ***** NOCH ZU PRÜFEN *****
L["Gamble Chance"] = "Risikochance"; -- H
L["Healing - Mischievous Glee"] = "Heilung - Bösartige Schadenfreude"; -- H
L["Non-Enrage Tricks Duration"] = "Dauer von 'Tricks'"; -- H
L["Off-hand Critical Chance"] = "..Wahrscheinlichkeit für kritischen Treffer mit der zweiten Hand.."; -- H
L["Positional Damage"] = "Positionsbezogener Schaden"; -- H
L["Skills Critical Multiplier"] = "..Fertigkeiten-Multiplikator für kritische Ereignisse.."; -- H ***** NOCH ZU PRÜFEN *****
L["Confound Countdown Duration"] = "..Dauer: Verwirren-Countdown.."; -- N ***** NOCH ZU PRÜFEN *****
L["Hide in Plain Sight Cooldown"] = "..Abklingzeit: 'In Luft auflösen'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Addle Induction Multiplier"] = "..Multiplikator: Tumult-Anwendung.."; -- N ***** NOCH ZU PRÜFEN *****
L["Clever Retort Damage and Healing"] = "..Schaden und Heilung bei 'Schlaue Erwiederung'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Increased Range for Reveal Weakness"] = "Schwächen aufspüren: Verbesserte Reichweite"; -- N
L["Stealth Level"] = "Schleichen"; -- N
L["Sneak Movement Speed"] = "..Bewegungsgeschwindigkeit: 'Schleichen'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Pulse Modifier for Glee"] = "..Impulsmodifikator für Schadenfreude..";-- N ***** NOCH ZU PRÜFEN *****

-- Hüter Nahkampfwaffe
L["Fist-Spear Gambit Threat"] = "Bedrohung durch Faust-Speer-Gambits"; -- H
L["Gambit Lifetap Damage"] = "Gambit: Schaden durch Lebensentzug"; -- H
L["Power, Fist-Spear Gambit Line"] = "Kraft. Faust-Speer-Gambit-Fertigkeiten"; -- H
L["Recklessness Attack Duration"] = "Dauer von 'Angriff' bei Verwendung von 'Unvorsichtigkeit'"; -- H
L["Shield-Spear Gambit Threat"] = "Schild-Speer-Gambit: Bedrohung"; -- H
L["Shield Gambit Buff Duration"] = "'Schild-Gambit': Dauer der Stärkung"; -- H
L["Spear Gambit Damage (Melee)"] = "'Speer-Gambit': Schaden (Nahkampf)"; -- H
L["Spear Gambit Parry Rating"] = "Paradewert bei Speer-Gambits"; -- H
L["Wages of Fear Positional Damage"] = "'Lohn der Angst': Positionsbezogener Schaden"; -- H
L["Ambush Critical Multiplier"] = "Multiplikator für kritischen Schaden: Hinterhalt"; -- N
L["Boar's Rush Critical Rating"] = "Wert für kritischen Treffer mit 'Ansturm des Keilers'"; -- N
L["Critical Strike Critical Multiplier"] = "Multiplikator für kritischen Schaden: Entscheidender Schlag"; -- N
L["Hampering Javelin Duration"] = "Dauer: Hemmender Wurfspiess"; -- N
L["Surety of Death Damage Over Time"] = "Todesgewissheit: Schaden über Zeit"; -- N
L["Javelin Skills Max Range"] = "Maximale Reichweite von Wurfspiess-Fertigkeiten"; -- N
L["Resolution Damage"] = "Schaden durch 'Lösung'"; -- N
L["Shield Tactics Tactical Mitigation Bonus"] = "'Schild-Taktiken': Bonus auf taktische Schadensreduzierung"; -- N
L["Power, Shield-Spear Gambit Line"] = "Kraft. Schild-Speer-Gambit-Fertigkeiten"; -- N

-- Hüter Wurfspiess
L["Determination Morale Regen"] = "Moralregenereation im Kampf- 'Entschlossenheit'"; -- H
L["Fist Gambit Buff Duration Bonus"] = "'Faust-Gambit': Bonus auf Stärkungsdauer"; -- H
L["Fist Gambit Critical Rating"] = "Wert für kritischen Treffer mit 'Faust-Gambit'"; -- H
L["Fist Gambit Evade Rating Bonus"] = "'Fist-Gambit': Bonus auf Ausweichwert"; -- H
L["Heal Bonus for Conviction"] = "Heilbonus für 'Überzeugung'"; -- H
L["In Combat Power Regeneration"] = "Kraftregeneration im Kampf"; -- H
L["Power, Spear-Shield Gambit Line"] = "Kraft. Speer-Schild-Gambit-Fertigkeiten"; -- H
L["Shield Gambit Line Healing Bonus"] = "'Schild-Gambit'-Fertigkeiten Heilungsbonus"; -- H
L["Spear-Shield Damage Bonus"] = "Schild-Speer: Schadensbonus"; -- H
L["Ambush and Careful Step Induction"] = "Anwendungsverzögerung: 'Hinterhalt' und 'Vorsichtiger Schritt'"; -- N
L["Adroit Maneuver Duration"] = "Dauer: Geschicktes Manöver"; -- N
L["Careful Step Duration"] = "Dauer: Vorsichtiger Schritt"; -- N
L["Resolution Resist Rating"] = "Resistenzwert gegen Entschlossenheit"; -- N
L["Javelin Skills To-Hit Movement Penalty"] = "Trefferwarscheinlichkeit von Wurfspiess-Fertigkeiten in Bewegung: Verringerter Abzug"; -- N
L["Forced March Movement Bonus"] = "'Gewaltmarsch': Bewegungsbonus"; -- N
L["Shield Mastery Block Rating"] = "Wert: Blocken durch Schildbeherrschung"; -- N
L["Defiant Challenge Cooldown Modifier"] = "Abklingzeit-Modifikator von 'Trotzige Herausforderung'"; -- N
L["Shield Piercer Duration"] = "Dauer: Schild-Durchbohrer"; -- N

-- Kundigen Stab
L["Burning Ember Initial Damage"] = "Anfangsschaden bei 'Glühende Asche'"; -- H
L["Cracked Earth Range"] = "Reichweite von 'Rissige Erde'"; -- H
L["Fire Skills Critical Multiplier"] = "Multiplikator für kritischen Schaden bei Feuerfertigkeiten"; -- H
L["Light of the Rising Dawn Critical Multiplier"] = "Multiplikator für Krit.Schaden bei 'Licht der aufsteigenden Dämmerung'"; -- H
L["Light of the Rising Dawn Damage"] = "Schaden durch 'Licht der aufsteigenden Dämmerung'"; -- H
L["Share the Power Increase"] = "Erhöhung von 'Teilung der Macht'"; -- H
L["Staff Strike Cooldown"] = "Abklingzeit für 'Stabschlag'"; -- H
L["Tactical Skills Direct Damage"] = "Direkter Schaden durch Taktische Fertigkeiten"; -- H
L["Burning Embers Range"] = "..Reichweite von 'Glühende Asche'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Ents Go To War Damage"] = "..Schaden durch 'Kriegszug des Ents'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Cracked Earth Damage"] = "..Schaden durch 'Rissige Erde'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Lightning Skills Critical Rating"] = "Kritischer Wert: Blitz-Fertigkeiten"; -- N
L["Gust of Wind Damage"] = "Schaden durch 'Windstoss'"; -- N
L["Lightning Storm Damage"] = "Schaden durch 'Blitzsturm'"; -- N
L["Sticky Gourd Direct Damage"] = "Direkter Schaden: Klebrige Kalebasse"; -- N
L["Test of Will Damage"] = "Prüfung des Willens Schaden"; -- N
L["Storm-lore Damage"] = "Schaden durch 'Sturmkunde'"; -- N

-- Kundigen Buch
L["Burning Embers Pulses"] = "Brennende-Asche-Impulse"; -- H
L["Fire Skills Critical Rating"] = "Wert für kritische Ereignisse bei Einsatz von Feuerfertigkeiten"; -- H
L["Healing from Beacon of Hope"] = "Heilung durch 'Signalfeuer der Hoffnung'"; -- H
L["Signs of Power Durations"] = "Dauer von 'Zeichen der Macht'"; -- H
L["Target Resistance (Damaging Skills)"] = "Zielresistenz"; -- H
L["Target Resistance (Debuffing Skills)"] = "Zielresistenz (Schwächungsfertigkeiten)"; -- H
L["Target Resistance (Fire Skills)"] = "Zielresistenz (Feuerfertigkeiten)"; -- H
L["Wizard Fire Pulses"] = "Magierfeuer-Impulse"; -- H
L["Ancient Craft Targets"] = "Uraltes Handwerk: Ziele"; -- N
L["Bane Flare Target"] = "Ziele von 'Bannglühen'"; -- N
L["Cure Resistance Duration"] = "..Resistenz heilen Abklingzeit.."; -- N ***** NOCH ZU PRÜFEN ***** (deprecated in RoI)
L["Fire Damage Over Time"] = "Feuerschaden über Zeit"; -- N
L["Threat - Sign of the Wild: Rage"] = "Bedrohung - Zeichen der Wildniss: Wut"; -- N
L["Test of Will Devastate Damage"] = "..Zerst\195\182rerischer Schaden: 'Prüfung des Willens'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Fire-lore Targets"] = "Ziele der Feuerkunde"; -- N
L["Inner Flame Healing"] = "..Heilung: 'Innere Flamme'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Morale - Sign of the Wild: Protection"] = ".. Moral - Zeichen der Wildniss: Schutz.."; -- N ***** NOCH ZU PRÜFEN *****

--- Waffenmeister Waffe
L["Area of Effect Skill Damage"] = "..Schaden durch Fertigkeiten mit Flächenwirkung.."; -- H ***** NOCH ZU PRÜFEN *****
L["Brutal Strikes Damage"] = "Schaden durch 'Brutale Schläge'"; -- H
L["Critical Damage Multiplier"] = "Multiplikator für Kritischen Schaden"; -- H
L["Feral/Savage Strikes Damage"] = "Schaden durch 'Barbarische Schläge'/'Wilde Schläge'"; -- H
L["Relentless/Remorless Strikes Damage"] = "Schaden durch 'Unerbittliche Schläge'/'Erbarmungslose Schläge'"; -- H
L["Wild Attack Damage"] = "Schaden bei 'Wilder Angriff'"; -- H
L["Ferocious Strikes Cooldown"] = "Abklingzeit für 'Grimmige Schläge'"; -- H
L["Rend Bleed Damage"] = "Blutungsschaden durch 'Zerreissen'"; -- H
L["Targeted Melee Skills Range"] = "Fertigkeiten-Reichweite bei gezieltem Nahkampf"; -- N
L["Fear Nothing Cooldown"] = "Abklingzeit: 'Keine Furcht'"; -- N
L["Hamstring Duration"] = "Dauer von 'Achillessehne'"; -- N
L["Horn Damage"] = "..Schaden durch Horn-Fertigkeit.."; -- N ***** NOCH ZU PRÜFEN *****
L["Increased Rend Armour Reduction"] = "Rüstungsspalter wird stärker reduziert"; -- N
L["Battle Frenzy Cooldown"] = "..Abklingzeit: 'Kampfrausch'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Sudden Defence Cooldown"] = "Dauer von 'Plötzliche Verteidigung'"; -- N
L["Sprint Duration"] = "Sprintdauer"; -- N

-- Waffenmeister Rune
L["Blade Line Area Damage Power Cost"] = "Kraftkosten: Klingen-Fertigkeiten mit Flächenwirkung"; -- H
L["Ardour/Glory Pip Interval"] = "Eifer/Ruhm: Punktintervall"; -- H
L["Swift Strike/Swift Blade Power Cost"] = "Kraftkosten für 'Schneller Schlag'/'Flinke Klinge'"; -- H
L["Stun Duration - Champion's Horn"] = "Dauer von Betäuben - Horn des Waffenmeisters"; -- H
L["Bracing Attack Heal"] = "Heilung: Stärkender Angriff"; -- H
L["Dire Need Cooldown"] = "Abklingzeit für 'Verzweiflung'"; -- H
L["Ebbing Ire Cooldown"] = "Abklingzeit für 'Zorn verkleinern'"; -- H
L["Ardour/Glory Parry and Evade Rating"] = "Wert: Parieren und Ausweichen (Eifer/Ruhm)"; -- H
L["Ardour/Glory in-Combat Power Regen"] = "..Eifer/Ruhm: Kraftregeneration im Kampf.."; -- N ***** NOCH ZU PRÜFEN *****
L["Adamant/Invincible Duration"] = "Dauer: Felsenfest/Unbesiegbar"; -- N
L["Champion Skill Bubble Magnitude"] = "Wert: Parade und Ausweichen von 'Plötzliche Verteidigung'"; -- N
L["Heroics Morale Heal Chance"] = "Chance für Moralheilung (Heldentaten)"; -- N
L["(Glory) Hedge Armour Rating Mod"] = "..Rüstungswertmodifikator (Ruhm).."; -- N ***** NOCH ZU PRÜFEN *****
L["Strikes Line Power Cost"] = "Kraftkosten: Schlag-Fertigkeiten"; -- N
L["Fight On Duration"] = "Dauer: Weiterkämpfen"; -- N
L["Rend Pulses"] = "Impulse: Zerreissen"; -- N
L["Battle Acuity Duration"] = "..Dauer-Modifikator von 'Heimtückischer Kampf'.."; -- N ***** NOCH ZU PRÜFEN *****

-- Hauptmann Waffe
L["Devastating Blow Critical Rating"] = "Wahrscheinlichkeit, das 'Zerstörerischer Schlag' zu einem kritischen Treffer führt"; -- H
L["Kick Cooldown"] = "Abklingzeit für 'Treten"; -- H
L["Pressing Attack Max Targets"] = "Höchstzahl der Ziele für 'Doppelschlag'"; -- H
L["Melee Skill Power Cost"] = "Kraftkosten von Nahkampf-Fertigkeiten"; -- H
L["Pressing Attack Critical Rating"] = "Wahrscheinlichkeit, das 'Doppelschlag' zu einem kritischen Treffer führt"; -- H
L["Telling Mark Damage"] = "..Schaden durch 'Verräterisches Zeichen'.."; -- H ***** NOCH ZU PRÜFEN *****
L["Morale from Motivating Speech"] = "Moral von 'Motivierende Rede'"; -- H
L["To Arms Duration"] = "Dauer von 'Rekrutierung'"; -- H
L["Blade of Elendil Damage"] = "..Schaden durch 'Klinge Elendils'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Cry Power Cost"] = "..Schrei: Kraftkosten.."; -- N ***** NOCH ZU PRÜFEN *****
L["Defensive Strike Armour Buff"] = "..Rüstungsstärkung 'Defensiver Schlag'.:"; -- N ***** NOCH ZU PRÜFEN *****
L["Cutting Attack Bleed Damage"] = "..Blutungsschaden durch 'Schneidiger Angriff'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Make Haste Duration"] = "..Dauer von 'Beeilung'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Routing Cry Damage"] = "..'Spottruf': Schaden.."; -- N ***** NOCH ZU PRÜFEN *****
L["Tactics: On Guard Parry Rating Buff"] = "..'Taktik: In Bereitschaft': Wert der Stärkung.."; -- N ***** NOCH ZU PRÜFEN *****
L["Tactics: Relentless Attack Critical Rating Buff"] = "..'Taktik: Gnadenloser Angriff': Werterhöhung bei kritischen Treffern.."; -- N ***** NOCH ZU PRÜFEN *****
L["Battle States and Defeat Response Duration"] = "..Dauer von Kampfzuständen und Erwiderung 'Vernichtung'.."; -- N ***** NOCH ZU PRÜFEN *****

-- Hauptmann Zeichen
L["Rallying Cry Healing"] = "Heilung durch 'Schlachtruf'"; -- H
L["Strength of Will Effects"] = "..Wirkungen von 'Willenskraft'.."; -- H ***** NOCH ZU PRÜFEN *****
L["Rallying Cry Cooldown"] = "..Abklingzeit für 'Schlachtruf'.."; -- H ***** NOCH ZU PRÜFEN *****
L["Melee Skills Healing"] = "..Heilung durch Nahkampf-Heilfertigkeiten.."; -- H ***** NOCH ZU PRÜFEN *****
L["Valiant Strike Morale Return"] = "'Tapferer Schlag': Moralrückgewinn"; -- H
L["Tactics: Focus in-Combat Power Regen Buff"] = "..'Taktik: Focus': Kraftregeneration im Kampf.."; -- H ***** NOCH ZU PRÜFEN *****
L["Vocal Skills Healing"] = "..Heilung durch stimmlich basierte Heilfertigkeiten.."; -- H ***** NOCH ZU PRÜFEN *****
L["Words of Courage Power and Morale Cost"] = "Kraft- und Moralkosten von 'Worte der Ermutigung'"; -- H
L["Escape from Darkness Cooldown"] = "..Abklingzeig für 'Flucht aus der Dunkelheit'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Shield of the Dunedain Cooldown"] = "..Abklingzeit für 'Schild der Dünedain'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Words of Courage Pulses"] = "..Impulse von 'Worte der Ermutigung'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Grave Wound Cooldown"] = "..Abklingzeit für 'Ernsthafte Wunde'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Muster Courage Cooldown"] = "..Abklingzeit für 'Mut fassen'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Shadow's Lament Cooldown"] = "..Abklingzeit für 'Berührung des Schattens'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Time of Need Morale Cost"] = "..Moralkosten für 'Große Verzweiflung'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Time of Need Cooldown"] = "..Abklingzeit für 'Große Verzweiflung'.."; -- N ***** NOCH ZU PRÜFEN *****

-- Wächter Waffe
L["Guardian's Ward Duration"] = "..Dauer: 'Wächterschild'.."; -- H ***** NOCH ZU PRÜFEN *****
L["Guardian's Pledge Cooldown"] = "Abklingzeit für 'Gelöbnis des Wächters'"; -- H
L["Guardian Area Effect Melee Targets"] = "Wächter: Nahkampfziele von Fertigkeiten mit Bereichswirkung"; -- H
L["Bash Damage"] = "..Schaden: 'Heftiger Schlag'.."; -- H ***** NOCH ZU PRÜFEN *****
L["Brutal Assault Damage"] = "Schaden durch 'Brutaler Angriff'"; -- H
L["Overwhelm Critical Rating"] = "Wert für kritisches Ereigniss durch Übermannen"; -- H
L["Overwhelm Damage"] = "Schaden durch 'Übermannen'"; -- H
L["Sweeping Cut Damage"] = "Schaden: Fegender Schnitt"; -- H
L["Whirling Retaliation Damage"] = "Schaden: Wirbelnde Vergeltung"; -- H
L["Vexing Blow Damage"] = "Schaden durch 'Irritierender Schlag'"; -- H
L["Charge Duration"] = "Dauer des Angriffs"; -- N
L["Guardian Bleed Damage"] = "..Wächter: Blutungsschaden.."; -- N ***** NOCH ZU PRÜFEN *****
L["Guardian Bleed Pulses"] = "..Wächter: Blutungszähler.."; -- N ***** NOCH ZU PRÜFEN *****
L["Stamp Cooldown"] = "..Abklingzeit: 'Stampfen'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Targeted Melee Skills Range"] = "Fertigkeiten-Reichweite bei gezieltem Nahkampf"; -- N
L["Turn the Tables Cooldown"] = "'Spiess Umdrehen': Abklingzeit"; -- N
L["Warrior's Heart/Fortitude Duration"] = "Dauer von 'Kriegerherz'"; -- N
L["To the King Damage"] = "Schaden: Für den König"; -- N

-- Wächter Gürtel
L["Cry Resist Chance"] = "Resistenz-Wahrscheinlichkeit gegen Schrei"; -- H
L["Challenge Targets"] = "..Ziele herausfordern.."; -- H ***** NOCH ZU PRÜFEN *****
L["Guardian's Ward Parry Rating"] = "Wert: Parade (Wächterschild)"; -- H
L["Guardian's Ward Block Rating"] = "Wert: Blocken (Wächterschild)"; -- H
L["Guardian's Ward Damage"] = "Schaden: Wächterschild"; -- H
L["Shield Damage"] = "Schildschaden"; -- H
L["Sting Damage"] = "Stechschaden"; -- H
L["Threat Generation Up Rating"] = "Erhöh.: Bedrohungsauusstrahlung"; -- H
L["Catch a Breath Cooldown"] = "Abklingzeit für 'Luft Holen'"; -- H
L["Catch a Breath Morale Heal"] = "Luft Holen (Heilung der Moral)"; -- H
L["Guardian's Threat Block and Parry Rating"] = "Wert: Blocken und Parade (Bedrohung des Wächters)"; -- N
L["Power Restore on Reactions"] = "Kraftwiederherstellung: Reaktionen"; -- N
L["Reactive Block Damage"] = "Schaden durch 'Aktives Blocken'"; -- N
L["Increased Block, Parry and Evade from Protection"] = "..Schutz: Erhöhtes Blocken/Parieren/Ausweichen.."; -- N ***** NOCH ZU PRÜFEN *****
L["Shield Wall Range"] = "..Reichweite: 'Schildwall'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Shield Smash Damage"] = "Schaden: Schild zerschmettern"; -- N
L["Stagger Critical Rating"] = "Wert für kritisches Ereigniss mit 'Torkeln'"; -- N
L["Stagger Effect Duration"] = "..Effektdauer: 'Torkeln'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Warrior's Heart/Fortitude Morale Heal"] = "..Moralheilung: 'Kriegerherz'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Stagger Positional Damage"] = "..Positionsbezogener Schaden: 'Torkeln'.."; -- N ***** NOCH ZU PRÜFEN *****

-- Jäger Fernkampfwaffe
L["Focus Bow Critical Multiplier"] = "Fokus: Multiplikator für Kritischen Schaden bei Verwendung von Bogenfertigkeiten"; -- H
L["Focus Bow Power Cost"] = "Fokus: Kraftkosten für Bogen"; -- H
L["Induction Bow Critical Multiplier"] = "Multiplikator für Kritischen Schaden bei Bogenfertigkeiten mit Anwendungsverzögerung"; -- H
L["Induction Bow Power Cost"] = "Kraftkosten für Bogen"; -- H
L["Merciful Shot Cooldown"] = "Abklingzeit für 'Gnadenschuss'"; -- H
L["Quick Shot Critical Chance"] = "Wert für kritischen Treffer mit 'Schneller Schuss'"; -- H
L["Quick Shot Slow in Strength"] = "Verlangsammung durch 'Schneller Schuss' in Stärke-Haltung"; -- H
L["Ranged Skill Block Chance Modifier"] = "Mod.: Block-Wahrsch. (Fernkampf)"; -- H
L["Ranged Skill Evade Chance Modifier"] = "Mod.: Ausweich-Wahrsch. (Fernkampf)"; -- H
L["Burn Hot Damage"] = "Heisse Flamme: Schaden"; -- N
L["Distracting Shot Resistance Penetration"] = "Resistenzpenetration 'Irritierender Schuss'"; -- N
L["Endurance Quick Shot Threat Down, Rating"] = "Verring.: Ausdauerbe. durch 'Schneller Schuss'"; -- N
L["Distracting Shot Cooldown"] = "'Irritierender Schuss': Abklingzeit"; -- N
L["Barbed Arrow Bleed Damage"] = "Blutungsschaden durch 'Stachelpfeil'"; -- N
L["Focus Bow Threat Down, Rating"] = "Verring.: Fokus: Bogenbedrohung. Wert.:"; -- N
L["Heart Seeker Damage"] = "Schaden durch Herzsucher"; -- N
L["Ranged Evade Rating"] = "..Wert: Ausweichen bei Fernkampfangriffen.."; -- N ***** NOCH ZU PRÜFEN *****
L["Induction Bow Threat Down, Rating"] = "Verring.: Anwendung Bogenbedrohung"; -- N

-- Jäger Nahkampfwaffe
L["Beneath Notice Cooldown"] = "Abklingzeit von 'Unscheinbar'"; -- H
L["Blindside Critical Rating"] = "Wert für Kritischen Treffer auf Schwacher Seite"; -- H
L["Critical Magnitude in Precision Stance"] = "Kritisches Ausmass in Präzisionshaltung"; -- H
L["Find the Path Movement Speed"] = "Bewegungsgeschwindigkeits bei 'Weg finden'"; -- H
L["Improved Strength of Earth Morale Regen"] = "Verbesserte Moralregeneration durch 'Stärke der Erde'"; -- H
L["Maximum Targets for AoE Skills"] = "Max. Ziele bei Fertigkeiten mit Bereichswirkung"; -- H
L["Melee Critical Multiplier"] = "Multiplikator bei kritischen Nahkampf"; -- H
L["Needful Haste Duration"] = "Dauer: Nötige Hast"; -- H
L["Agile Rejoinder Heal Multiplier"] = "Heilungs-Multiplikator von 'Gewandte Erwiederung'"; -- N
L["Desperate Flight Cooldown"] = "Abklingzeit für 'Verzweifelte Flucht'"; -- N
L["Low Cut Bleed Chance"] = "Blutungschance für 'Niedriger Schnitt'"; -- N
L["Melee Critical Rating"] = "Wert: Kritischer Treffer (Nahkampf)"; -- N
L["Stealth Detection"] = "Schleich-Erkennung"; -- N
L["Power Restored by Deep Concentration"] = "Kraft durch 'Hohe Konzentration'"; -- N
L["Swift Stroke Parry and Evade Rating"] = "Wert: Parade und Ausweichen eines Schnellen Hiebes"; -- N
L["Press Onward Cooldown"] = "Abklingzeit für 'Weiter Vorrücken'"; -- N

-- Runenbewahrer Runenstein
L["Fire Skill Damage"] = "Schaden durch Feuerfertigkeiten"; -- H
L["Battle Attuned Skill Power Cost"] = "..Fertigkeiten mit Kampfeinstimmung: Kraftkosten.."; -- H ***** NOCH ZU PRÜFEN *****
L["Fury of Storm Damage"] = "'Sturmwut': Schaden"; -- H
L["Healing"] = "Heilung"; -- H
L["Healing Attuned Skill Power Cost"] = "Fertigkeiten mit Heilungseinstimmung: Kraftkosten"; -- H
L["Healing Over Time"] = "Heilung über Zeit"; -- H
L["Wrath of Flame Damage Over Time"] = "..Schaden über Zeit durch 'Flammenzorn'.."; -- H ***** NOCH ZU PRÜFEN *****
L["Chill of Winter Debuff Duration"] = "..Dauer der Schwächung durch 'Winterkälte'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Chill of Winter Damage"] = "..Schaden durch 'Winterkälte'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Distracting Flame Cooldown"] = "..Abklingzeit von 'Verwirrende Flamme'.."; -- N ***** NOCH ZU PRÜFEN *****
L["Finesse Rating"] = "Wert: Finesse"; -- N
L["Fury of Storm Critical Multiplier"] = "'Sturmwut': Kritischer Schaden"; -- N
L["Glorious Foreshadowing Duration"] = "'Glorreiche Ahnungen':  Dauer"; -- N 
L["Steady Attuned Skill Power"] = "..Kraftkosten für Fertigkeiten mit neutraler Einstimmung.."; -- N ***** NOCH ZU PRÜFEN *****
L["Vivid Imagery Targets"] = "'Anschauliche Symbolik': Ziele"; -- N

-- Runenbewahrer Runenbeutel
L["Distracting Winds Cooldown"] = "'Irritierende Winde': Abklingzeit"; -- H
L["Essence of Flame Damage"] = "'Wesen der Flamme': Schaden"; -- H
L["Pulses Prelude to Hope"] = "'Präludium der Hoffnung': Impulse"; -- H
L["Scribe's Spark Damage"] = "'Funke des Schreibers': Schaden"; -- H
L["Self Motivation Cooldown"] = "Abklingzeit für 'Selbstmotivation'"; -- H
L["Shocking Words Stun Chance"] = "Chance auf Betäuben bei Verwendung von 'Schockierende Worte'"; -- H
L["Writ of Fire Damage"] = "'Sinnbild des Feuers': Schaden"; -- H
L["Writ of Health Healing"] = "'Sinnbild der Gesundheit': Heilung"; -- H
L["Chilling Rhetoric Cooldown"] = "'Frostige Phrasen': Abklingzeit"; -- N
L["Ceaseless Argument Damage"] = "Schaden durch 'Endloses Streitgespräch'"; -- N
L["Do Not Fall This Day Cooldown"] = "'Tod heute nicht unterliegen': Abklingzeit"; -- N
L["Epic for the Ages Healing"] = "'Epos für die Ewigkeit': Heilung"; -- N
L["Mending Verse Healing"] = "'Heilender Vers': Heilung"; -- N
L["Frozen Epilogue Cooldown"] = "Abklingzeit: Eingefrorener Epilog"; -- N
L["Word of Exaltation Cooldown"] = "'Wort des Hochgefühls': Abklingzeit"; -- N
L["Target Shocking Touch Resist Rating"] = "'Erschütternde Berührung': Resistenzwert des Ziels"; -- N

-- Stat legacies
L["Agility"] = "Beweglichkeit";
L["Fate"] = "Schicksal";
L["Might"] = "Macht";
L["Vitality"] = "Vitalität";
L["Will"] = "Wille";