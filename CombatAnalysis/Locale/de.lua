
L["DevelopedBy"] = "Developed by Evendale";
L["TranslatedBy"] = "de \195\156bersetzung von Dero/Amtholdiel";

-- Menu Headings

L["MenuTitle"] = "Kampfanalyse";

L["General"] = "Allgemein";
L["Buffs"] = "Buff Info";
L["SaveLoad"] = "Speichern/laden";


-- Value/Date Formatting

L["Thousand"] = "K";
L["Million"] = "M";
L["Billion"] = "Mrd";
L["Trillion"] = "B";

L["Jan"] = {"Jan","Januar"};
L["Feb"] = {"Feb","Februar"};
L["Mar"] = {"M\195\164r","M\195\164rz"};
L["Apr"] = {"Apr","April"};
L["May"] = {"Mai","Mai"};
L["Jun"] = {"Jun","Juni"};
L["Jul"] = {"Jul","Juli"};
L["Aug"] = {"Aug","August"};
L["Sep"] = {"Sep","September"};
L["Oct"] = {"Okt","Oktober"};
L["Nov"] = {"Nov","November"};
L["Dec"] = {"Dez","Dezember"};

-- Options

L["ResetTotalsMessage"] = "Bist du dir sicher, dass du du die Gesamtwerte zur\195\188cksetzen willst?";
L["Yes"] = "Ja";
L["No"] = "Nein";
L["OK"] = "OK";

L["SaveData"] = "Daten speichern";
L["LoadData"] = "Daten laden";

-- Select File Dialog (there will probably be more added to this later)

L["Select"] = "Ausw\195\164hlen";
L["Save"] = "Speichern";
L["Load"] = "Laden";
L["Cancel"] = "Abbrechen";

L["FileName"] = "Dateiname";

L["SelectAll"] = "Alle ausw\195\164hlen";
L["ClearAll"] = "Alle l\195\182schen";

L["Delete"] = "L\195\182schen";

L["AreYouSureYouWantToDeleteMessage"] = "Willst du die markierte(n)\nDatei(en) wirklich l\195\182schen?";

L["Encounters"] = "K\195\164mpfe";
L["Items"] = "Items";
L["CombineWith"] = "Kombinieren mit";
L["CombineInto"] = "Kombinieren nach";

L["SelectCurrentDataToCombineWith"] = "W\195\164hle aktuelle Daten zur Kombination mit geladenen Daten.";
L["LoadDataAsTotalsEncounter"] = "Ersetze Gesamte K\195\164mpfe mit geladenen Daten";

L["SelectSaveFile"] = "Speicherdatei w\195\164hlen";
L["SelectFileToLoad"] = "Datei zum laden w\195\164hlen";
L["SelectDataToSave"] = "Daten zum speichern w\195\164hlen";
L["SelectDataToCombineWith"] = "Kombinieren mit";

L["TooLong"] = "Bitte gebe maximal 64 Zeichen ein.";
L["IllegalCharacters"] = "Bitte nur Buchstaben, Zahlen und Leerzeichen/Unterstiche eingeben.";

L["NoDataMessage"] = "Es sind keine Daten zum speichern verf\195\188gbar.";
L["NoFileMessage"] = "Keine Datei angegeben.";
L["NoDataSelectedMessage"] = "Es wurden keine Daten ausgew\195\164hlt.";
L["OverwriteFileMessage"] = "Datei existiert bereits. M\195\164chtest du die gespeicherten Daten mit dieser Datei kombinieren oder sie \195\188berschreiben?";
L["CombineOrSeparateMessage"] = "Du hast mehrere Dateien gew\195\164hlt. Willst du sie kombinieren oder einzeln laden?";
L["TooManyCharactersMessage"] = "Der gew\195\164hlte Datei name ist zu lang.\n(maximale L\195\164nge = 64 Zeichen)";
L["InvalidCharactersMessage"] = "Der gew\195\164hlte Dateiname enth\195\164lt\nung\195\188ltige Zeichen";
L["FileNotFoundMessage"] = "Eine der angegebenen Dateien wurde nicht gefunden.";
L["SaveFailedMessage"] = "Speichern fehlgeschlagen: ";
L["LoadFailedMessage"] = "Laden fehlgeschlagen: ";
L["CombineMessage"] = "Bist du dir sicher, dass du die gew\195\164hlten\nDateien kombinieren willst?";
L["LoadBeforeSaveMessage"] = "Eine der gew\195\164hlten Dateien wird derzeit gespeicher und kann daher noch nicht geladen werden. Versuche es in 10-15 Sekunden erneut";

L["Combine"] = "Kombinieren";
L["Overwrite"] = "\195\188berschreiben";
L["Combined"] = "Kombiniert";
L["Separate"] = "Trennen";

-- commands

L["Options"] = "optionen";
L["Settings"] = "einstellungen";
L["Setup"] = "setup";
L["CommandUsage"] = "Verwendung: /ca "..string.lower(L.Options).." | "..string.lower(L.Save).." | "..string.lower(L.Load);

-- Encounter Default Names

L["Totals"] = "Gesamtwerte";
L["Encounter"] = "Kampf";
L["CurrentEncounter"] = "Aktueller Kampf";
L["CompletedEncounter"] = "Beendeter Kampf";

-- Right Click Menu

L["RestoreTab"] = "Tab wiederherstellen";
L["CloseTab"] = "Tab schlie\195\159en";
L["AutoSelectPlayer"] = "Spielerdetails autom. w\195\164hlen";
L["AutoHideTabs"] = "Tabs autom. verstecken";
L["ShowBackground"] = "Hintergrund anzeigen";
L["ShowMiniTitleBar"] = "Mini Titelleise anzeigen";
L["ShowTitleAndDuration"] = "Titel & Dauer anzeigen";
L["ShowEncountersList"] = "Kampfliste anzeigen";
L["ShowTargetsList"] = "Zielliste anzeigen";
L["ShowExtraButtons"] = "Extra Buttons anzeigen";
L["AutoSelectNewEncounters"] = "Neuen Kampf automatisch w\195\164hlen";
L["ResetTotals"] = "Gesamtwerte zur\195\188cksetzen";
L["ConfirmDialogOnReset"] = "Best\195\164tigungsdialog beim Zur\195\188cksetzen";

-- Chat Menu (indexed by {command, channel name})

L["Say"] = {"sagen","Sagen"};
L["Fellowship"] = {"g","Gef\195\164hrten"};
L["Raid"] = {"szc","Schlachtzug"};
L["Kinship"] = {"sc","Sippe"};
L["Tribe"] = {"st", "Stamm"};
L["Gap"] = "------------------";

-- Other

L["AllPlayers"] = "Alle Spieler";
L["AllSkills"] = "All Skills";
L["Duration"] = "Dauer";
L["SendToChat"] = "An Chat senden";
L["CombatAnalysisSummary"] = "Kampfanalyse Zusammenfassung";

L["DirectDamage"] = "Direkter Schaden";

L["MinutesAbbr"] = "m";
L["SecondsAbbr"] = "s";

L["Daze"] = "Bet\195\164ubung";
L["Root"] = "Wurzel";
L["Fear"] = "Furcht";

-- Statistics Headings

L["AllData"] = "Alle Daten";
L["NonCrits"] = "Nicht Krits";
L["Criticals"] = "Krits";
L["Devastates"] = "Zerst\195\182rerisch";
L["CritsAndDevs"] = "Krits und Zerst\195\182rerische";
L["Partials"] = "Teilweise";

L["Total"] = "Gesamt";
L["Average"] = "Durchschnitt";
L["Maximum"] = "Maximum";
L["Minimum"] = "Minimum";

L["CriticalHits"] = "kritisch Treffer";

L["Avoidance"] = "Verteidigung";
L["Attacks"] = "Angriffe";
L["Hits"] = "Treffer";
L["Absorbs"] = "Absorbiert";
L["Misses"] = "Verfehlt";
L["Deflects"] = "Deflects";
L["Immune"] = "Immun";
L["Resists"] = "Wiederstanden";
L["PhysicalAvoids"] = "Physisches Entgehen";
L["FullAvoids"] = "Komplettes Entgehen";
L["Avoids"] = "Entgehen";
L["Blocks"] = "Blocken";
L["Parrys"] = "Parieren";
L["Evades"] = "Ausweichen";
L["PartialAvoids"] = "teilweises Entgehen";
L["PartialBlocks"] = "teilweises Blocken";
L["PartialParrys"] = "teilweises Parieren";
L["PartialEvades"] = "teilweises Ausweichen";

L["Other"] = "Andere";
L["Interrupts"] = "Unterbrechungen";
L["CorruptionsRemoved"] = "Verderbtheiten";

L["DmgTypes"] = "Schadensarten";

L["TempMorale"] = "Tempor\195\164re Moral";
L["RegularHeals"] = "Normale Heilungen";
L["TempHeals"] = "Tempor\195\164re Heilungen";
L["WastedTempHeals"] = "  (verschwendet)";

-- Note the following elements are indexed by: {Short Name, Full Name}

L["Dmg"] = {"Dmg","Schaden","DPS"}
L["Taken"] = {"Erlitten","Erlittener Schaden","DPS"}
L["Heal"] = {"Heilung","Heilung","HPS"}
L["Power"] = {"Kraft","Kraftwiederherstellung","KPS"}

L["Debuff"] = {"Debuff","Debuff"}
L["Buff"] = {"Buff","Buff"}

L["Death"] = {"Tot","Tot"}
L["Corruption"] = {"Verderbtheit","Verderbtheitsentfernung"}
L["Interrupt"] = {"Unterbrechung","Unterbrechung"}
L["CombatEntered"] = {"Kampfbeginn","Kampf begonnen"}
L["CombatExited"] = {"Kampfende","Kampf beendet"}


L["AvoidanceEnum"] = {{"Kein","Kein"},{"Verfehlt","Verfehlt"},{"Immun","Immun"},{"Wiederstanden","Wiederstanden"},
                      {"Block","Block"},{"Parade","Parade"},{"Ausweichen","Ausweichen"},
                      {"T-Block","Teilweiser Block"},{"T-Parade","Teilweise Parade"},{"T-Ausweichen","Teilweises Ausweichen"},
                      {"Deflect","Deflect"}}

L["CriticalEnum"] = {{"Kein","Kein"},{"Kritisch","Kritischer Treffer"},{"Zerst\195\182rerisch","Zerst\195\182rerischer Treffer"}}

L["DmgTypeEnum"] = {{"Allgemein","Allgemein"},{"Feuer","Feuer"},{"Blitz","Blitz"},{"Frost","Frost"},{"S\195\164ure","S\195\164ure"},{"Schatten","Schatten"},{"Licht","Licht"},
                    {"Bele","Beleriand"},{"West","Westernis"},{"UZ","Uralte Zwergenart"},{"Kein","Kein"}}

L["MoralePower"] = {{"Moral","Moral"},{"Kraft","Kraft"},{"Kein","Kein"}}




--[[

The complete parsing function. Since the order of text in the combat log is likely to differ in
different languages, this entire function is included  in the localization class.

The function is given an input line from the combat log, and parses that line to determine its meaning.
The final step in each section is to return the extracted values. These lines need not be updated, but
the correct info must be extracted into the relevant fields.

Note the use of numeric values for avoids, critical hits, dmg types, and morale/power. These numbers
correspond to the orderings in the four lists directly above this comment block.

You will need to know something about lua pattern matching and/or regex's to attempt to translate this
section. See http://www.lua.org/pil/20.2.html for more details.

]]--

local function TrimArticles(name)
	name = string.gsub(name, "^[Dd]ie ", "");
	name = string.gsub(name, "^[Dd]em ", "");
	name = string.gsub(name, "^[Dd]er ", "");
	name = string.gsub(name, "^[Dd]en ", "");
	return name;
end


L["Parse"] = function(line)

	-- 1) Damage line ---
	
	local initiatorName,avoidAndCrit,skillName,targetNameAmountAndType = string.match(line,"^(.*) gelang ein (.*)Treffer mit \"(.*)\" gegen (.*)%.$");
	
	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		
		local avoidType =
			string.match(avoidAndCrit,"^teilweise geblockter") and 8 or
			string.match(avoidAndCrit,"^teilweise parierter") and 9 or
			string.match(avoidAndCrit,"^teilweise ausgewichener") and 10 or 1;
		local critType =
			string.match(avoidAndCrit,"kritischer $") and 2 or
			string.match(avoidAndCrit,"zerst\195\182rerischer $") and 3 or 1;
		
		local targetName,amount,dmgType,moralePower = string.match(targetNameAmountAndType, "^(.*) f\195\188r ([%d,]*) Punkte Schaden des Typs \"(.*)\" auf (.*)$");
		-- damage was absorbed
		if targetName == nil then
			targetName = TrimArticles(targetNameAmountAndType);
			amount = 0;
			dmgType = 10;
			moralePower = 3;
		-- some damage was dealt
		else
			targetName = TrimArticles(targetName);
			amount = string.gsub(amount,",","")+0;
			-- note there may be no damage type
			dmgType = 
				dmgType == "Allgemein" and 1 or
				dmgType == "Feuer" and 2 or
				dmgType == "Blitz" and 3 or
				dmgType == "Frost" and 4 or
				dmgType == "S\195\164ure" and 5 or
				dmgType == "Schatten" and 6 or
				dmgType == "Licht" and 7 or
				dmgType == "Beleriand-Art" and 8 or
				dmgType == "Westernis-Art" and 9 or
				dmgType == "Uralte Zwergenart" and 10 or 11;
			moralePower = (moralePower == "Moral" and 1 or moralePower == "Kraft" and 2 or 3);
		end
		
		-- Currently ignores damage to power
		if (moralePower == 2) then return nil end
		
		-- Update
		return 1,initiatorName,targetName,skillName,amount,avoidType,critType,dmgType;
	end
	
	-- 2) Heal line --
	
	--     (note the distinction with which self heals are now handled)
	--     (note we consider the case of heals of zero magnitude, even though they presumably never occur)
	local initiatorName,crit,skillNameTargetNameAmountAndType = string.match(line,"^(.*) wandte \"(.*)Heilung\" mit (.*)%.$");

	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		local critType =
			crit == "kritische " and 2 or
			crit == "zerst\195\182rerische " and 3 or 1;
			
		local skillNameTargetNameAndAmount,ending = string.match(skillNameTargetNameAmountAndType,"^(.*) Punkte (.*) wiederherstellte$");
		moralePower = (ending == "Moral" and 1 or ending == "Kraft" and 2 or 3);
		
		skillName,targetName,amount = string.match(skillNameTargetNameAndAmount,"^\"(.*)\" auf (.*) an, was ([%d,]*)$");
		targetName = TrimArticles(targetName);
		amount = string.gsub(amount,",","")+0;
		
		-- Update
		return (moralePower == 2 and 4 or 3),initiatorName,targetName,skillName,amount,critType;
	end
	
	-- 2.2) Self Heal
	
	--		(note that the self heal line is totally differend in comparision to the normal heal line in the german client)
	
	local skillName, initiatorName, critType, amount, moralPower = string.match(line, "^(.*) verursacht bei (.*) \"(.*)Heilung\" und stellt ([%d,]*) Punkte (.*) wieder her%.");
	if(initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		amount = string.gsub(amount, ",", "")+0;
		moralPower = (moralPower == "Moral" and 1 or moralPower == "Kraft" and 2 or 3);
		critType = critType == "kritische " and 2 or
				   critType == "zerst\195\182rerische " and 3 or 1;
		
		return (moralPower == 2 and 4 or 3), initiatorName, initiatorName, skillName, amount, critType;
	end
	
	-- 3) Buff line --
	local initiatorName,skillName,targetName = string.match(line,"^(.*) wandte \"Vorteil\" mit \"(.*)\" auf (.*) an%.$");
	
	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		targetName = TrimArticles(targetName);
		-- Update
		return 17,initiatorName,targetName,skillName;
	end
	
	-- 4) Avoid line --


	-- standard avoid
	local initiatorName,targetName,skillName,erSie,avoidType = string.match(line,"^(.*) wollte (.*) mit (.*) treffen\, aber(.*)konterte den Versuch mit (.*).");
	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		targetName = TrimArticles(targetName);
		skillName = string.gsub(skillName, "\"", "");
		avoidType = string.gsub(avoidType, "\"", "");
		avoidType = 
				string.match(avoidType,"Blocken") and 5 or
				string.match(avoidType,"Parieren") and 6 or
				string.match(avoidType,"Ausweichen") and 7 or
				string.match(avoidType,"Widerstehen") and 4 or
				string.match(avoidType,"Immunit\195\164t") and 3 or 1;
		-- Sanity check: must have avoided in some manner
		if (avoidType == 1) then return nil end
		return 1,initiatorName,targetName,skillName,0,avoidType,1,10;
	end
		
	-- miss
	local initiatorName, targetName, skillName = string.match(line, "^(.*) verfehlte (.*) mit (.*)%.");
	
	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		targetName = TrimArticles(targetName);
		skillName = string.gsub(skillName, "\"", "");
		local avoidType = 2;
		-- Update
		return 1,initiatorName,targetName,skillName,0,avoidType,1,10;
	end
		
	
	-- 5) Reflect line --
	
	local initiatorName, amount, reflectType, targetName = string.match(line, "^(.*) reflektierte ([%d,]*) Punkte (.*) von (.*).$");
	if(initiatorName ~= nil) then
		local skillName = "Reflektiert";
		initiatorName = TrimArticles(initiatorName);
		targetName = TrimArticles(targetName);
		
		amount = string.gsub(amount,",","")+0;
		local dmgType = string.match(reflectType, "^Schaden des Typs (.*) auf Moral$");
		
		if(dmgType ~= nil) then
			dmgType = 
				dmgType == "\"Allgemein\""  and 1 or
				dmgType == "\"Feuer\"" and 2 or
				dmgType == "\"Blitz\"" and 3 or
				dmgType == "\"Frost\"" and 4 or
				dmgType == "\"S\195\164ure\"" and 5 or
				dmgType == "\"Schatten\"" and 6 or
				dmgType == "\"Licht\"" and 7 or
				dmgType == "\"Beleriand-Art\"" and 8 or
				dmgType == "\"Westernis-Art\"" and 9 or
				dmgType == "\"Uralte Zwergenart\"" and 10 or 11;
			
			-- a dmg reflect
			return 1,initiatorName,targetName,skillName,amount,1,1,dmgType;
		else
			-- a heal reflect
			return 3,initiatorName,targetName,skillName,amount,1;
		end
	end
	
	-- 6) Temporary Morale bubble line (as of 4.1.0)
	local amount = string.match(line,"^Ihr habt ([%d,]*) Punkte Moral (tempor\195\164r) verloren!$");
	if (amount ~= nil) then
		amount = string.gsub(amount,",","")+0;
		-- the only information we can extract directly is the target and amount
		return 14,nil,player.name,nil,amount;
	end
	
	-- 7) Combat State Break notice (as of 4.1.0)
	
	-- 7a) Root broken
	local targetName = string.match(line,"^.* hab?t die Bewegungslosigkeit von (.*) beendet!$");
	if (targetName ~= nil) then
		targetName = TrimArticles(targetName);
		-- the only information we can extract directly is the target name
		return 16,nil,targetName,nil;
	end
	
	-- 7b) Daze broken
	local targetName = string.match(line,"^.* hab?t die Benommenheit von (.*) beendet!$");
	if (targetName ~= nil) then
		targetName = TrimArticles(targetName);
		-- the only information we can extract directly is the target name
		return 16,nil,targetName,nil;
	end
	
	-- 7c) Fear broken
	local targetName = string.match(line,"^.* hab?t mit einem Angriff die Furcht von (.*) beseitigt!$");
	if(targetName ~= nil) then
		targetName = TrimArticles(targetName);
		-- the only information we can extract directly is the target name
		return 16,nil,targetName,nil;
	end
		
	
	-- 8) Interrupt line --
	local targetName,initiatorName = string.match(line,"^(.*) wurde durch (.*) unterbochen!");
	if (targetName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		targetName = TrimArticles(targetName);
		
		-- Update
		return 7,initiatorName,targetName;
	end
	
	-- 9) Dispell line (corruption removal) --
	local corruption, targetName = string.match(line,"Von (.*) geheilt: (.*)");
	
	if (corruption ~= nil) then
		-- NB: Currently ignore corruption name
		
		-- Update
		return 8,player.name,targetName;
	end
	
	-- 10) Defeat lines ---
	
	-- 10a) Defeat line 1 (mob or played was killed)
	local initiatorName = string.match(line,"^Durch .* besiegt: (.*)%.$");
	
	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		-- Update
		return 9,initiatorName;
	end
	
	-- 10b) Defeat line 2 (mob died)
	local initiatorName = string.match(line,"^(.*) ist gestorben%.$");
	
	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		-- Update
		return 9,initiatorName;
	end
	
	-- 10c) Defeat line 3 (a player was killed or died)
	local initiatorName = string.match(line,"^(.*) wurde besiegt%.$");

	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		-- Update
		return 9,initiatorName;
	end
	
	-- 10d) Defeat line 4 (you were killed)
	local match = string.match(line,"^.* hat Euch au\195\159er Gefecht gesetzt%.$");

	if (match ~= nil) then
		-- Update
		return 9,player.name;
	end
	
	-- 10e) Defeat line 5 (you died)
	local match = string.match(line,"^Ihr wurdet durch ein Missgeschick au\195\159er Gefecht gesetzt%.$");

	if (match ~= nil) then
		-- Update
		return 9,player.name;
	end
	
	-- 11) Revive lines --
	
	-- 11a) Revive line 1 (player revived)
	local initiatorName = string.match(line,"^(.*) wurde wiederbelebt%.$");
	
	if (initiatorName ~= nil) then
		initiatorName = TrimArticles(initiatorName);
		-- Update
	  return 10,initiatorName;
	end
	
	-- 11b) Revive line 2 (player succumbed)
	local initiatorName = string.match(line,"^(.*) ist .* Wunden erlegen%.$");
	
	if (initiatorName ~= nil) then
	  initiatorName = TrimArticles(initiatorName);
		-- Update
	  return 10,initiatorName;
	end
	
	-- 11c) Revive line 3 (you were revived)
	local match = string.match(line,"^Ihr wurdet wiederbelebt%.$");
	
	if (match ~= nil) then
		-- Update
	  return 10,player.name;
	end
	
	-- 11d) Revive line 4 (you succumbed)
	local match = string.match(line,"^Ihr erliegt Euren Verletzungen%.$");
	
	if (match ~= nil) then
		-- Update
	  return 10,player.name;
	end
	
	-- if we reach here, we were unable to parse the line
	--  (note there is very little that isn't parsed)
end



--[[
	
	Skill Names (for Temporary Morale & Buff/Debuff tracking)
	
	> Temporary Morale Skill Names need specify both how the skill name appears in the combat log, as
	    well as how it appears on the effect tooltip.
	
	> Buff Names must match exactly how the name of a skill appears in the effect tooltip.
	> Benefit/Debuff/Crowd-Control Names must match exactly how the name of a skill appears in the combat log.
	
--]]

-- 0) Temporary Morale Skills {combat log name, effect name}

-- Captain
L["ShieldOfTheDunedainTM"] = {"Schild der D\195\186nedain","Schild der D\195\186nedain"};
-- Champion
L["TrueHeroicsTM"] = {"Wahre Heldentaten","Freude der Schlacht"};
L["SuddenDefenceTM"] = {"Pl\195\182tzliche Verteidigung","Pl\195\182tzliche Verteidigung"};
-- Minstrel
L["StoryOfTheHammerhandTM"] = {"Hammerhand-Erz\195\164hlung","Lied der Hammerhand"};
L["SongOfTheHammerhandTM"] = {"Dichtung der Hammerhand","Lied der Hammerhand"};
L["GiftOfTheHammerhandTM"] = {"Gabe der Hammerhand","Erz\195\164hlung der Hammerhand"};
-- Rune-Keeper
L["WordOfExaltationTM"] = {"Wort des Hochgef\195\188hls","Wort des Hochgef\195\188hls"};
L["EssayOfExaltationTM"] = {"Abhandlung des Hochgef\195\188hls","Wort des Hochgef\195\188hls"};
-- Other
L["MartyrsFortitudeTM"] = {"Standhaftigkeit des M\195\164rtyrers","Standhaftigkeit des M\195\164rtyrers"};
L["FrostRingTM"] = {"NA","NA"};

-- 1) Burglar Skills

-- Buffs (effect name)
L["TouchAndGo"] = "Gewandtheit";
L["KnivesOut"] = "Messerkampf";
L["Mischievous"] = "Schelmisch";
L["QuietKnife"] = "Lautloses Messer";
L["Gambler"] = "Spieler";
L["TheMischiefMaker"] = "Der Unheilstifter";
L["TheQuietKnife"] = "Das lautlose Messer";
L["TheGambler"] = "Der Spieler";
L["Feint"] = "T\195\164uschen";
L["ImprovedFeint"] = "Verbesserung: Scheinangriff";
L["ArmourOfTheUnseen"] = "R\195\188stung des Unsichtbaren";
-- Debuffs (log name)
L["RevealWeakness"] = "Schw\195\164chen aufsp\195\188ren";
L["Addle"] = "Tumult";
L["TrickDisable"] = "Trick: Behindern";
L["TrickCounterDefence"] = "Trick: Abwehr reduzieren";
L["TrickImprovedCounterDefence"] = "Trick: Verbessertes \"Abwehr reduzieren\"";
L["TrickDustInTheEyes"] = "Trick: Staub in die Augen";
L["Slowed"] = "Verlangsamt";
L["TrickEnrage"] = "Trick: Erz\195\188rnt";
L["ASmallSnag"] = "Ein kleiner Schnitt";
L["QuiteASnag"] = "Ein ziemlicher Haken";
-- Removals (log name)
L["MischievousDelight"] = "B\195\182sartige Schadenfreude";
L["MischievousGlee"] = "B\195\182sartige Freude";
-- Crowd Control (log name)
L["Riddle"] = "R\195\164tsel";
L["ImprovedRiddle"] = "Verbesserung: R\195\164tsel";
L["Confound"] = "Verwirren";
L["StartlingTwist"] = "\195\156berraschende Wende";
L["ImprovedStartlingTwist"] = "Verbesserte \"\195\156berraschende Wende\"";
L["AdvancedStartlingTwist"] = "Bessere \195\188berraschende Wende";
L["StunDustTier1"] = "Bet\195\164ubungsstaub (St. 1)";
L["StunDustTier2"] = "Bet\195\164ubungsstaub (St. 2)";
L["StunDustTier3"] = "Bet\195\164ubungsstaub (St. 3)";
L["ExploitOpening"] = "M\195\182glichkeit ausnutzen";
L["Trip"] = "Zu Fall bringen";
L["MarblesTier1"] = "Murmeln (Stufe 1)";
L["MarblesTier2"] = "Murmeln (Stufe 2)";
L["MarblesTier3"] = "Murmeln (Stufe 3)";

-- 2) Captain Skills

-- Buffs (effect name)
L["MusterCourage"] = "Mut";
L["InHarmsWay"] = "In den Weg werfen";
L["WarCry"] = "Kriegsschrei";
L["BladeOfElendil"] = "Licht Elendils";
L["Motivated"] = "Motiviert";
L["OnGuard"] = "In Bereitschaft";
L["RelentlessAttack"] = "Gnadenloser Angriff";
L["Focus"] = "Fokus";
L["ShieldBrother"] = "Schildbruder";
L["WatchfulShieldBrother"] = "Wachsamer Schildbruder";
L["SongBrother"] = "Liedbruder";
L["BladeBrother"] = "Klingenbruder";
L["ToArmsShieldBrother"] = "Zu den Waffen (Schildbruder)";
L["ToArmsFellowshipShieldBrother"] = "Zu den Waffen (Gef\195\164hrtengruppen-Schildbruder)";
L["ToArmsSongBrother"] = "Zu den Waffen (Liedbruder)";
L["ToArmsFellowshipSongBrother"] = "Zu den Waffen (Gef\195\164hrtengruppen-Liedbruder)";
L["ToArmsBladeBrother"] = "Zu den Waffen (Klingenbruder)";
L["ToArmsFellowshipBladeBrother"] = "Zu den Waffen (Gef\195\164hrtengruppen-Klingenbruder)";
L["StrengthOfWillShieldBrother"] = "Willenskraft (Schildbruder)";
L["StrengthOfWillFellowshipShieldBrother"] = "Willenskraft (Gef\195\164hrtengruppen-Schildbruder)";
L["StrengthOfWillSongBrother"] = "Willenskraft (Liedbruder)";
L["StrengthOfWillFellowshipSongBrother"] = "Willenskraft (Gef\195\164hrtengruppen-Liedbruder)";
L["StrengthOfWillBladeBrother"] = "Willenskraft (Klingenbruder)";
L["StrengthOfWillFellowshipBladeBrother"] = "Willenskraft (Gef\195\164hrtengruppen-Klingenbruder)";
L["RallyingCry"] = "Racheschrei";
L["InDefenceOfMiddleEarth"] = "Verteidigung von Mittelerde";
L["DefensiveStrike"] = "Defensiver Schlag";
L["ImprovedDefensiveStrike"] = "Verbesserung: Defensiver Schlag";
L["LastStand"] = "Letztes Gefecht";
-- Debuffs (log name)
L["NobleMark"] = "Edles Zeichen";
L["TellingMark"] = "Zeichen setzen";
L["RevealingMark"] = "Verr\195\164terisches Zeichen";

-- 3) Champion Skills

-- Buffs (effect name)
L["Fervour"] = "Leidenschaft des Waffenmeisters";
L["Glory"] = "Ruhm";
L["Ardour"] = "Eifer";
L["ControlledBurn"] = "Kontrollierte Wut";
L["Flurry"] = "Wirbel";
L["SuddenDefence"] = "Pl\195\182tzliche Verteidigung";
L["SeekingBlades"] = "Suchende Klingen";
L["Adamant"] = "Felsenfest";
L["Invincible"] = "Unbesiegbar";
-- Benefits (log name)
L["EbbingIre"] = "Zorn verkleinern";
L["RisingIre"] = "Zorn vergr\195\182\195\159ern";

-- 4) Guardian Skills

-- Buffs (effect name)
L["Protection"] = "Schutz";
L["ProtectionByTheSword"] = "Schutz durch das Schwert";
L["ShieldWall"] = "Schildwall";
L["GuardiansBlockStance"] = "Blockhaltung des W\195\164chters";
L["GuardiansParryStance"] = "Paradehaltung des W\195\164chters";
L["Overpower"] = "\195\156berw\195\164ltigen";
L["GuardiansThreatStance"] = "Haltung: Bedrohung des W\195\164chters";
L["GuardiansPledge"] = "Gel\195\182bnis des W\195\164chters";
L["GuardiansWard"] = "W\195\164chterschild";
L["ImprovedGuardiansWard"] = "Verbesserung: W\195\164chterschild";
L["GuardiansWardTactics"] = "W\195\164chterschild-Taktiken";
L["ImprovedGuardiansWardTactics"] = "Verbesserung: W\195\164chterschild-Taktiken";
L["WarriorsBlock"] = "Blocken des Kriegers";
L["WarriorsParry"] = "Parade des Kriegers";
L["WarriorsPower"] = "Macht des Kriegers";
L["WarriorsThreat"] = "Bedrohung des Kriegers";
-- Debuffs (log name)
L["Challenge"] = "Herausforderung";
L["ImprovedChallenge"] = "Verbesserung: Herausforderung";
L["ChallengeTheDarkness"] = "Kampfansage an die Dunkelheit";
L["ImprovedOverwhelm"] = "Verbesserung: \195\156bermannen";
L["ImprovedSting"] = "Verbessertes Stechen";
L["ImminentCleansing"] = "Bevorstehende Reinigung";

-- 5) Hunter Skills

-- Buffs (effect name)
L["StanceStrength"] = "Haltung: St\195\164rke";
L["StancePrecision"] = "Haltung: Pr\195\164zision";
L["StanceEndurance"] = "Haltung: Ausdauer";
L["BurnHot"] = "Heisse Flamme";
L["CoolBurn"] = "Selbstbeherrschte Flamme";
L["Fleetness"] = "Schnellf\195\188ssigkeit";
L["ImprovedFleetness"] = "Verbesserte Schnellf\195\188ssigkeit";
L["SwiftStroke"] = "Schneller Hieb";
L["NeedfulHaste"] = "N\195\182tige Hast";
L["HuntersArt"] = "Kunst des J\195\164gers";
-- Crowd Control (log name)
L["DazingBlow"] = "Bet\195\164ubender Schlag";
L["ImprovedDazingBlow"] = "Verbesserter bet\195\164ubender Schlag";
L["DistractingShot"] = "Irritierender Schuss";
L["RainOfThorns"] = "Dornenregen";
L["CryOfThePredator"] = "Ruf des Raubtiers";
L["BardsArrow"] = "Bards Pfeil";
L["TrapDamage"] = "Fallenschaden";

-- 6) Lore-Master Skills

-- Buffs (effect name)
L["AirLore"] = "Prickelnde Luft";
L["ContinualAirLore"] = "Prickelnde Luft";
L["SignOfPowerRighteousness"] = "Z.d.M.: Rechtschaffenheit";
L["SignOfPowerVigilance"] = "Z. d. Macht: Wachsamkeit";
L["SignOfTheWildRage"] = "Zeichen der Wildnis: Wut";
L["ImprovedSignOfTheWildRage"] = "Verbessertes Zeichen der Wildnis: Wut";
L["SignOfTheWildProtection"] = "Z. d. Wildnis: Schutz";
-- Debuffs (log name)
L["KnowledgeOfTheLoreMaster"] = "Wissen des Kundigen";
L["GustOfWind"] = "Windsto\195\159";
L["FireLore"] = "Feuerkunde";
L["WindLore"] = "Windkunde";
L["FrostLore"] = "Frostwissen";
L["AncientCraft"] = "Uraltes Handwerk";
L["SignOfPowerCommand"] = "Zeichen der Macht: Befehl";
L["ImprovedSignOfPowerCommand"] = "Zeichen der Macht: Verbesserter Befehl";
L["SignOfPowerSeeAllEnds"] = "Zeichen der Macht: Umsichtigkeit";
-- Crowd Control (log name)
L["BlindingFlash"] = "Blendender Blitzstrahl";
L["ImprovedBlindingFlash"] = "Verbesserung: Blendender Blitzstrahl";
L["BaneFlare"] = "Banngl\195\188hen";
L["HerbLore"] = "Kr\195\164uterkunde";
L["CrackedEarth"] = "Rissige Erde";

-- 7) Minstrel Skills

-- Buffs (effect name)
L["AnthemOfWar"] = "Hymne des Krieges";
L["AnthemOfTheFreePeoples"] = "Hymne der freien V\195\182lker";
L["AnthemOfProwess"] = "Hymne der T\195\188chtigkeit";
L["AnthemOfComposure"] = "Hymne der Selbstbeherrschung";
L["TheMelodyOfBattle"] = "Melodie des Kampfes";
L["InspireFellows"] = "St\195\164rkung durch \"Gef\195\164hrten inspirieren\"";
L["SoliloquyOfSpirit"] = "Selbstgespr\195\164ch des Geistes";
L["ImprovedChordOfSalvation"] = "Belebender Akkord";
L["TaleOfHeroism"] = "Heldensage";
L["TaleOfBattle"] = "Geschichte des Gefechts";
L["TaleOfWarding"] = "Geschichte der Bewachung";
L["TaleOfWardingAndHope"] = "Geschichte der Bewachung und Hoffnung";
L["TaleOfFrostAndFlame"] = "Geschichte von Frost- und Flamme";
L["TaleOfFrostAndFlamesBattle"] = "Geschichte vom Frost- und Flammengefecht";
L["TaleOfWardingAndHeroism"] = "Verbesserung: Geschichte der Bewachung";
L["SymphonyOfTheHopefulHeart"] = "Symphonie des hoffnungsvollen Herzens";
L["Harmony"] = "Harmonie";
L["WarSpeech"] = "Kriegsrede";
L["AnthemOfCompassion"] = "Hymne des Mitgef\195\188hls";
L["AnthemOfTheThirdAge"] = "Hymne des Dritten Zeitalters";
L["AnthemOfTheThirdAgeWarSpeech"] = "Hymne des Dritten Zeitalters (Kriegsrede)";
L["AnthemOfTheThirdAgeHarmony"] = "Hymne des Dritten Zeitalters (Harmonie)";
L["MinorBallad"] = "Bonus: Balladenschaden";
L["MajorBallad"] = "Balladenheilungs-Bonus";
L["PerfectBallad"] = "Bonus: Balladenkraft";
L["StillAsDeath"] = "Todesstarre";
-- Crowd Control (log name)
L["SongOfTheDead"] = "Lied der Toten";
L["InvocationOfElbereth"] = "Schrei der Valar";

-- 8) Rune-Keeper Skills

-- Buffs (effect name)
L["DoNotFallToStorm"] = "Blitz nicht unterliegen";
L["DoNotFallToFlame"] = "Feuer nicht unterliegen";
L["DoNotFallToWinter"] = "Frost nicht unterliegen";
L["DoNotFallThisDay"] = "Tod heute nicht unterliegen";
L["ShallNotFallThisDay"] = "Soll heute nicht Fallen";
L["PreludeToHope"] = "Pr\195\164ludium der Hoffnung";
L["RuneOfRestoration"] = "Rune der Wiederherstellung";
L["WritOfHealthTier1"] = "Sinnbild der Gesundheit - Stufe 1";
L["WritOfHealthTier2"] = "Sinnbild der Gesundheit - Stufe 2";
L["WritOfHealthTier3"] = "Sinnbild der Gesundheit - Stufe 3";
L["OurFatesEntwined"] = "Verbundenes Schicksal";
L["AllFatesEntwined"] = "Alle Schicksale verbunden";
L["GloriousForeshadowing"] = "Glorreiche Ahnungen";
L["WondrousForeshadowing"] = "Wundersame Ahnungen";

-- 9) Warden Skills

-- Buffs (effect name)
L["Conviction"] = "\195\156berzeugung";
L["DeterminationStance"] = "Entschlossenheit des H\195\188ters";
L["Conservation"] = "Schonung";
L["Recklessness"] = "Unvorsichtigkeit";
L["WayOfTheWarden"] = "Weg des H\195\188ters";
L["ShieldBashBlock"] = "Heftiger Schildschag - Blocken";
L["WallOfSteelParry"] = "Stahlwand - Parieren";
L["AdroitManoeuvre"] = "Geschicktes Man\195\182ver";
L["WardensTriumph"] = "Triumph des H\195\188ters";
L["DefensiveStrikeBlock"] = "Defensiver Schlag - Blocken";
L["Persevere"] = "Durchhalten";
L["ShieldDefence"] = "Schild-Verteidigung";
L["ShieldMastery"] = "Schildbeherrschung";
L["DanceOfBattleEvade"] = "Tanz des Kampfes - Ausweichen";
L["ShieldTactics"] = "Schild-Taktiken";
L["TacticallySound"] = "Taktisch einwandfrei";
L["T1HealOverTime"] = "Stufe 1 Heilung \195\188ber Zeit";
L["T2HealOverTime"] = "Medium HoT";
L["T3HealOverTime"] = "Stufe 3 Heilung \195\188ber Zeit";
L["T4HealOverTime"] = "Stufe 4 Heilung \195\188ber Zeit";

-- 10) Racial Skills
L["DutyBound"] = "Verpflichtet";
L["DwarfEndurance"] = "Zwergen-Ausdauer";

-- Other
L["VagabondsCraft"] = "Vagabond's Craft";
L["StunImmunity"] = "Stun Immunit\195\164t";

















L["DevelopedBy"] = "Entwickelt von Evendale";
L["TranslatedBy"] = "\195\156bersetzt von Dero";

L["FailedToLoadTraitsResetConfirmation"] = "Laden der Einstellungen fehlgeschlagen. Zur\195\188cksetzen und fortfahren?".."\n".."Warnung: Alle vorgenommenen Einstellungen gehen dabei verloren (ausgenommen Buff- & Debuff-Einstellungen).";
L["FailedToLoadTraitsMessage"] = "Es wird empfohlen, das Plugin jetzt zu entfernen. Sie k\195\182nnen versuchen, die Einstellungs-Datei auf Fehler zu \195\188berpr\195\188fen:\n\"Documents\\The Lord of the Rings Online\\PluginData\\<AccountName>\\<Server>\\<CharakterName>\\CombatAnalysis.plugindata\"";
L["FailedToLoadSettingsResetConfirmation"] = "Laden der Eigenschaften fehlgeschlagen. Zur\195\188cksetzen und fortfahren?".."\n".."Warnung: Alle vorgenommenen Buff- und Debuff-Einstellungen gehen dabei verloren.";
L["FailedToLoadSettingsMessage"] = "Es wird empfohlen, das Plugin jetzt zu entfernen. Sie k\195\182nnen versuchen, die Eigenschaften-Datei auf Fehler zu \195\188berpr\195\188fen:\n\"Documents\\The Lord of the Rings Online\\PluginData\\<AccountName>\\<Server>\\<CharakterName>\\CombatAnalysisTraits.plugindata\"";

-- Icon Menu

L["Logo"] = "Logo";
L["LockWindows"] = "Fenster sperren";
L["UnlockWindows"] = "Fenster entsperren";
L["SaveData"] = "Daten speichern";
L["LoadData"] = "Daten laden";
L["OpenTheMenu"] = "\195\150ffne das Men\195\188";

-- Menu Headings

L["Stats"] = "Stats";
L["Buffs"] = "Buffs";
L["About"] = "\195\150ber";

-- General Menu

L["GeneralSettingsTitle"] = "Allgemeine Einstellungen";
L["AutoSelectNewEncounters"] = "Neuen Kampf automatisch w\195\164hlen";
L["ConfirmDialogOnReset"] = "Best\195\164tigungsdialog beim Zur\195\188cksetzen anzeigen";
L["MaxStandardEncounters"] = "Max. normale K\195\164mpfe";
L["MaxLoadedEncounters"] = "Max. geladene K\195\164mpfe";

L["TimerConfigurationsTitle"] = "Timer Konfigurationen";
L["CombatTimeout"] = "Kampf Timeout";
L["TargetTimeout"] = "Ziel Timeout";
L["LogDelay"] = "Log Verz\195\182gerung";
L["EffectDelay"] = "Effekt Verz\195\182gerung";

L["SaveLoadTitle"] = "Speicher/Laden";
L["AutoSaveData"] = "Daten automatisch speichern";
L["Off"] = "Aus";
L["SaveOnExit"] = "Beim Beenden speichern";
L["SaveEncounters"] = "K\195\164mpfe speichern";

L["ShowLogo"] = "Zeige das Combat Analysis Logo";

-- UI Menu

L["UI"] = "Oberfl\195\164che";
L["Tabs"] = "Tabs";
L["Windows"] = "Fenster";
L["Tab"] = "Tab";
L["Window"] = "Fenster";

L["TabsAndWindowsConfigurationTitle"] = "Tabs & Fenster Konfiguration";
L["TabsAndWindowsDescription"] = "> Ziehe die Tabs umher, um die Oberfl\195\164che zu rekonfigurieren\n> Ziehe unerw\195\188nschte Tabs in die Ablage auf der rechten Seite";

L["TabSettingsTitle"] = "Tab Einstellungen";
L["SelectedTab"] = "Ausgew\195\164hlter Tab";
L["ColorScheme"] = "Farb-Schema";
L["TempMorale"] = "Temp Moral";
L["AutoSelectPlayer"] = "Spieler Details automatisch w\195\164hlen";

L["WindowSettingsTitle"] = "Fenster Einstellungen";
L["SelectedWindow"] = "Ausgew\195\164hltes Fenster";
L["Background"] = "Hintergrund";
L["XPos"] = "x-Pos";
L["YPos"] = "y-Pos";
L["Width"] = "Breite";
L["Height"] = "H\195\182he";
L["Minimized"] = "Minimiert";
L["CenterOnScreen"] = " Auf Bildschirm zentrieren ";
L["AutoHideTabs"] = "Tabs verstecken, wenn die Maus verschwindet";
L["ShowBackground"] = "Zeige Hintergrund & Rahmen";
L["ShowMiniTitleBar"] = "Mini Titelleiste anzeigen";
L["ShowTitleAndDuration"] = "Titel & Dauer anzeigen";
L["ShowEncountersList"] = "Liste der K\195\164mpfe anzeigen";
L["ShowTargetsList"] = "Liste der Ziele anzeigen";
L["ShowExtraButtons"] = "'An Chat senden' & andere Buttons anzeigen";

L["StatsWindowsConfigurationTitle"] = "Statistik-Fenster Konfiguration";
L["StatsWindowsDescription"] = "> Ziehe die Statistik-Felder herum, um die Oberfl\195\164che zu rekonfig\n> Ziehe unerw\195\188nschte Felder in die Ablage auf der rechten Seite";

L["StatsWindowSettingsTitle"] = "Statistik-Fenster Einstellungen";
L["Visibility"] = "Sichtbarkeit";
L["AlwaysShow"] = "Immer anzeigen";
L["ShowOnHover"] = "Beim her\195\188berfahren anzeigen";
L["ShowOnLock"] = "Beim sperren anzeigen";

L["ReOrder"] = "Neu-\nsortieren";
L["InsertTab"] = "Tab\neinf\195\188gen";
L["NewWindow"] = "Neues\nFenster";
L["CloseWindow"] = "Fenster schlie\195\159en";

-- Buffs Menu

L["Debuffs"] = "Debuffs";
L["CC"] = "CC";
L["CrowdControl"] = "CC";
L["Bubbles"] = "Bubbles";

L["TraitConfigurationsTitle"] = "Eigenschafts-Konfigurationen";
L["SelectedConfiguration"] = "Gew\195\164hlte Konfiguration";
L["RemoveTraitConfigurationConfirmation"] = "Sind Sie sich sicher, dass Sie die Eigenschafts-Konfiguration l\195\182schen wollen?";

L["AddConfiguration"] = "Konfiguration hinzuf\195\188gen";
L["ConfigurationName"] = "Konfigurations-Name";
L["CopyDebuffsFrom"] = "Debuffs kopieren von";
L["None"] = "Kein";
L["Add"] = "Hinzuf\195\188gen";
L["Remove"] = "Entfernen";

L["ConfigurationNameRequired"] = "Es wird ein Konfigurationsname ben\195\182tigt.";
L["ConfigurationNameAlreadyExists"] = "Es existiert bereits eine Konfiguration mit diesem Namen";
L["ColorSchemeRequired"] = "Es wird ein Farbschema ben\195\182tigt";

L["AddBuff"] = "Buff hinzuf\195\188gen";
L["AddDebuff"] = "Debuff hinzuf\195\188gen";
L["RemoveBuff"] = "Buff entfernen";
L["RemoveDebuff"] = "Debuff entfernen";
L["FilterList"] = "Liste filtern";
L["Remov"] = "entfern"; -- lowercase (for filtering by removal only debuffs/CC)
L["Class"] = "Klasse";

-- { Full Name, Full Name with no spaces, Two Letter Abbreviation}
L["BuffBars"] = {"BuffBars", "BuffBars", "BB"}
L["CombatAnalysis"] = {"Combat Analysis", "CombatAnalysis", "CA"}
L["ConfigureInBuffBars"] = "In BuffBars Konfigurieren";
L["BuffBarsNotLoadedMessage"] = "BuffBars ist derzeit nicht geladen.\nIst dies nicht der Fall, benutzen Sie m\195\182glicherweise eine \195\164ltere Version, die nicht mit Combat Analysis kompatibel ist.";

L["RemoverPrefix"] = "Entferner";
L["NameRequiredPrefix"] = "Name erfordert";

L["EffectName"] = "Effekt Name";
L["BuffName"] = "Buff Name";
L["DebuffName"] = "Debuff Name";
L["IconFileName"] = "Icon-Datei Name";
L["RemovalOnly"] = "Nur entfernen";
L["ToggleSkill"] = "Umschalt-Skill";
L["Removes"] = "Entfernt";
L["ConflictsWith"] = "Steht im Konflikt mit";
L["EffectModifiers"] = "Effekt Modifikatoren";
L["IsStance"] = "Ist Haltung";
L["StackingBuffs"] = "Stapelbare Buffs";
L["LogName"] = "Log Name";
L["AppliedBy"] = "Verursacht durch";
L["CritsOnlyAbbreviation"] = "Krit";
L["DelayAbbreviation"] = "Verz";
L["DurationAbbreviation"] = "Dauer";

-- About Menu

L["AboutTitle"] = "\195\188ber";
L["VersionNo"] = "Versionsnummer";
L["RestoreSettings"] = "Einstellungen wiederherstellen";
L["RestoreSettingsConfirmation"] = "Sind Sie sich sicher, dass Sie alle Einstellungen (abgesehen der Eigenschats-Konfigurationen) auf die Standardwerte zur\195\188cksetzen wollen?";
L["RestoreTraits"] = "Eigenschaften zur\195\188cksetzen";
L["RestoreTraitsConfirmation"] = "Sind Sie sich sicher, dass Sie alle Eigenschaften auf die Standardwerte zur\195\188cksetzen wollen?";
L["PluginUsageMessage"] = "F\195\188r mehr Informationen \195\188ber die Verwendung des Plugins besuche:";
L["FoundABugMessage"] = "Einen Bug gefunden? Melde ihn durch das Hinterlassen eines Kommentars unter der oben verlinkten URL.";

-- Tooltips

L["AutoSelectTooltip"] = "Sobald ein Kampf begint, automatisch den neuen Kampf auswh\195\164len.";
L["ConfirmOnResetTooltip"] = "Best\195\164tigungsdialog anzeigen, bevor gesamte K\195\164mpfe zur\195\188ckgesetzt werden.";
L["MaxEncountersTooltip"] = "Setze die Anzahl von K\195\164mpfen, die im Verlauf gespeichert werden k\195\182nnen.";
L["MaxLoadedEncountersTooltip"] = "Setze die Anzahl von geladenen K\195\164mpfen, die im Verlauf gespeichert werden k\195\182nnen.";
L["CombatTimeoutTooltip"] = "Setze die Toleranzzeit nach Beendigung eines Kampfes, in der Schaden weiterhin f\195\188r den Kampf gewertet wird.";
L["TargetTimeoutTooltip"] = "Setze die Toleranzzeit nach dem Tod eines Gegners oder eines Spielers, in der Schaden weiterhin f\195\188r das Ziel gewertet wird. Beachte, dass diese Zeit ger�n�ger sein muss als der Kampf-Timeout.";
L["LogDelayTooltip"] = "Setze die maximale Zeispanne zwischen der Erkennung eines Log-Eintrags und der Erkennung des entspechenden Effekts.";
L["EffectDelayTooltip"] = "Setze die maximale Zeispanne zwischen der Erkennung der Anwendung eines Effekts und der erkennung des entspechenden Log-Eintrags.";
L["AutoSaveTooltip"] = "Konfiguriere, wie Daten automatisch gespeichert werden:\na) Daten werden nicht automatisch gespeichert\nb) Alle Daten (die gesamten K\195\164mpfe) werden beim Ausloggen gespeichert (oder beim entfernen des Plugins)\nc) Jeder Kampf wird gespeichert, sobald er beendet wird";

L["SelectedTabTooltip"] = "W\195\164hle ein Tab zum konfigurieren.";
L["ColorSchemeTooltip"] = "Setze das Farbschema, das von diesem Tab verwendet wird.";
L["TempMoraleTooltip"] = "Setze das Farbschema, das von den Temp. Moral details verwendet wird.";
L["AutoSelectPlayerTooltip"] = "F\195\188r diesen Tab: W\195\164hle automatisch die Spielerdetails wenn ein neuer Kampf ausgew\195\164hlt wird.";
L["SelectWindowTooltip"] = "W\195\164hle ein fenster zum Konfigurieren.";
L["BackgroundTooltip"] = "Setze die Hintergrundfarbe f\195\188r dieses Fenster.";
L["WindowTabsTooltip"] = "Eine Liste von Tabs die sich derzeit in diesem Fenster befinden.";
L["CenterWindowOnScreenTooltip"] = "Zentriere dieses Fenster auf dem Bildschirm. Dadurch wird das Fenster zudem maximiert und sichergestellt, dass alle Tabs und Hintergr\195\188nde sichtbar sind.";
L["AutoHideTabsTooltip"] = "F\195\188r dieses Fenster: Tabs nur anzeigen, wenn sich die Maus \195\188ber dem Fenster befindet.";
L["ShowBackgroundTooltip"] = "F\195\188r dieses Fenster: Zeige oder verstecke Hintergrund und Rahmen \195\188ber dem Haupt-Anzeigefeld.";
L["ShowMiniTitleBarTooltip"] = "F\195\188r dieses Fenster: Zeige oder verstecke den Titel der Minibar (mit dem Men\195\188, Minimieren und Schlie\195\159en Symbolen).";
L["ShowTitleAndDurationTooltip"] = "F\195\188r dieses Fenster: Zeige oder Verstecke den farbigen Titel der das gew\195\164hlte Ziel und die Dauer anzeigt.";
L["ShowEncountersListTooltip"] = "F\195\188r dieses Fenster: Zeige oder Verstecke die Kampf-Auswahlliste.";
L["ShowTargetsListTooltip"] = "F\195\188r dieses Fenster: Zeige oder verstekce die Ziel-Auswahlliste.";
L["ShowExtraButtonsTooltip"] = "F\195\188r dieses Fenster: Zeige oder verstecke die 'An Chat senden' und 'Info'-Buttons.";
L["SelectedWindowTooltip"] = "W\195\164hle ein Statistik-Fenster zum Konfigurieren.";
L["StatsBackgroundTooltip"] = "Setze die Hintergrundfarbe f\195\188r dieses Statistik-Fenster.";
L["StatsWindowTabsTooltip"] = "Eine Liste von Tabs die sich derzeit in diesem Fenster befinden.";
L["CenterStatsWindowOnScreenTooltip"] = "Zentriere das Statistik-Fenster auf dem Bildschirm. Dadurch wird sichergestellt, dass das Statistik-Fenster angezeigt wird (Immer anzeigen).";
L["VisibilityTooltip"] = "F\195\188r dieses Statistik-Fenster gib an, ob:\na) Das Fenster soll immer angezeigt werden\nb) Das Fenster ist sichtbar, wenn eine Leiste in einem Tab markiert oder selektiert ist\nc) Das Fenster soll nur gezeigt werden, wenn die Details einer Leister selektiert wurde (geschlossenes Schloss-Symbol)";

L["SelectedConfigurationTooltip"] = "W\195\164hle, welche Eigenschafts-Konfiguration unten verwendet und editiert werden soll. Dies betrifft nur Debuff und  This only affects the Debuff and CC-Informationen.";
L["AddConfigurationTooltip"] = "F\195\188ge eine neue Eigenschats-Konfiguration hinzu.";
L["RemoveConfigurationTooltip"] = "Entferne die gew\195\164hlte Eigenschafts-Konfiguration.";
L["ConfigurationNameTooltip"] = "Definiere einen Namen f\195\188r die Eigenschats-Konfiguration. Dieser kann sp\195\164ter nicht ge\195\164ndert werden.";
L["CopyDebuffsFromTooltip"] = "W\195\164hle eine existierende Eigenschafts-Konfiguration von welcher das initiale Set von Debuffs kopiert werden.";
L["ConfigurationColorSchemeTooltip"] = "W\195\164hle ein Farbschema f\195\188r die neue Konfiguration.";
L["AddNewBuffTooltip"] = "F\195\188ge einen neuen Buff hinzu.";
L["AddNewDebuffTooltip"] = "F\195\188ge einen neuen Debuff hinzu.";
L["RemoveBuffTooltip"] = "Entferne diesen Buff/Debuff.";
L["BuffsActiveInCombatAnalysisTooltip"] = "Verfolge Buffs in Combat Analysis.";
L["DebuffsActiveInCombatAnalysisTooltip"] = "Verfolge Debuffs in Combat Analysis.";
L["DebuffsActiveInBuffBarsTooltip"] = "Verfolge Debuffs in BuffBars.";
L["MakeDebuffActiveInCombatAnalysisTooltip"] = "Ankreuzen um diesen Debuff in Combat Analysis zu verfolgen.";
L["MakeDebuffActiveInBuffBarsTooltip"] = "Ankreuzen, um diesen Debuff in BuffBars zu verfolgen.";
L["ConfigureInBuffBarsLinkTooltip"] = "Klicke um zum BuffBars Men\195\188 zu wechseln, in dem Effekt Fenster zum Anzeigen von Debuffs und/oder Crowd Control Effekte in Abh\195\164ngigkeit der unten gew\195\164hlten Einstellungen. Beachte, dass diese zu den \"Mob Debuffs\" & \"Mob CC\" Kategorien in BuffBars z\195\164hlen.";
L["ClassTooltip"] = "Spezifiziere die Klasse, zu der dieser Buff/Debuff geh\195\182rt.";
L["TempMoraleEffectNameTooltip"] = "Spezifiziere den Effektnamen f\195\188r diesen tempor\195\164re Moral Skill. Der Name muss exakt mit dem Namen des Effekts \195\188bereinstimmen.";
L["SkillNameTooltip"] = "Spezifiziere einen einzigartigen Namen f\195\188r diesen Buff/Debuff. Dieser wird im Buff/Debuff Tab angezeigt, und, wenn anwendbar, im Effektfenster von BuffBars.";
L["IconFileNameTooltip"] = "Spezifiziere den Dateinamen (inklusive Dateieindung) von dem Icon das f\195\188r diesen Debuff verwendet werden soll. Das Icon muss im Ordner 'CombatAnalysis/Resources/DebuffIcons' gespeichert sein und sollte 16x16 Pixel gro\195\159 sein.";
L["RemovalOnlyTooltip"] = "Ein 'Nur entfernen' Debuff wird nicht verfolgt, und wird anstatt dessen daf\195\188r verwendet, andere Debuffs zu entfernen.";
L["ToggleSkillTooltip"] = "Ein 'Umschalt-Skill' ist ein Skill, der eingeschaltet wird und unendlich lang anh\195\164lt. F\195\188r diese Debuffs wird angenommen, dass sie anhalten bis das Ziel stirbt, der Kampf beendet wird oder ein \195\188berschreibendes Umschalten angewandt wird.";
L["RemovesTooltip"] = "Eine Liste von Debuffs und Crowd Control Skills die entfernt werden, wenn diese Debuff angewandt wird.";
L["AddRemoveTooltip"] = "F\195\188ge einen neuen Debuff hinzu, der entfernt wird, wenn dieser Debuff angewandt wird.";
L["RemoveRemoveTooltip"] = "Entferne den gew\195\164hlten Debuff aus der Liste der Debuffs, die entfernt werden, wenn dieser Debuff angewandt wird.";
L["ConflictsWithTooltip"] = "Eine Liste von Debuffs oder Crowd Control Skills die verhindern, dass dieser Debuff angewandt wird, wenn sie aktiv sind.";
L["AddConflictTooltip"] = "F\195\188ge einen neuen debuff hinzu, der mit diesem Debuff in Konflikt steht.";
L["RemoveConflictTooltip"] = "Entferne den gew\195\164hlten Debuff aus der Liste in Konflikt stehender Debuffs.";
L["EffectModifiersTooltip"] = "Eine Liste von Effekten, die, wenn im Moment der Aktivierung des Debuffs auf dem Spieler aktiv, die Dauer des Debuffs verl\195\164ngern (oder verk\195\188rzen).";
L["AddEffectModifierTooltip"] = "F\195\188ge einen neuen Effekt hinzu, der die Dauer dieses Debuffs ver\195\164ndert.";
L["RemoveEffectModifierTooltip"] = "Entferne den gew\195\164hlten effekt aus der Liste der Effekt Modifikatoren.";
L["EffectModifierDurationTooltip"] = "Setze die positive oder negative Erh\195\182hung/Verminderung der Dauer des Debuffs, wenn im Moment der Aktivierung des Debuffs dieser Effekt aktiv ist.";
L["IsStanceTooltip"] = "F\195\188r Skills, die als Haltung gelten, wird die Anzahl der Anwendungen nicht gez\195\164hlt.";
L["StackingBuffsTooltip"] = "Eine Liste von Namen die f\195\188r den Buff angezeigt wird, wenn der Buff erfolgreich angewandt wird und der Buff beim Wiederanwenden noch aktiv ist.";
L["AddStackingBuffTooltip"] = "F\195\188ge einen neuen stapelbaren Effekt-Namen hinzu.";
L["RemoveStackingBuffTooltip"] = "Entferne den gew\195\164hlten Namen aus der Liste der stapelbaren Effektnamen.";
L["LogNameTooltip"] = "Spezifiziere den Namen des Kampflog Eintrags der zu dem tempor\195\164re Moral Skill passt, der genutzt wird, um einen Bubble Effekt dem ausl\195\182senden Spieler zuzuordnen. Der Name muss exakt mit dem Namen des Skills \195\188bereinstimmen, wie er im Kampflog erscheint.";
L["BuffAppliedByTooltip"] = "Eine Liste von Effektnamen, die die Anwendung dieses Buffs ausl\195\182sen. Die Namen m\195\188ssen exakt mit den Namen der Effekte \195\188bereinstimmen.";
L["DebuffAppliedByTooltip"] = "Eine Liste von Kampflog-Skillnamen, die die Anwendung dieses Debuffs ausl\195\182sen, und die verkn\195\188pften Details. Die Namen m\195\188ssen exakt mit den Namen der Skills \195\188bereinstimmen, wie sie im Kampflog erscheinen.";
L["AddAppliedByTooltip"] = "F\195\188ge eine neue Anwendung hinzu.";
L["RemoveAppliedByTooltip"] = "Entferne die gew\195\164hlte Anwendung aus der Liste von Anwendungen.";
L["CritsOnlyTooltip"] = "Wenn angekreuzt, wird der Debuff nur angewandt, wenn der Skill einen kritischen oder zerst\195\182rerischen Treffer erzielt.";
L["DelayTooltip"] = "Setze die Verz\195\182gerung nachdem die Anwendung stattfindet bis der Skill aktiviert wird. Beachte, dass dies ein kleiner negativer Wert sein kann, um eine Verz\195\182gerung einzustellen bevor der Kampfflog eintrag erscheint.";
L["DurationTooltip"] = "Setze die Dauer, \195\188ber die der Debuff anh\195\164lt.";

L["ShowLogoTooltip"] = "Zeige oder verstecke das CombatAnalysis Logo das verwendet wird, um alle anderen Fenster zu zeigen/verstecken oder um das Men\195\188 aufzurufen.";
L["LockWindowsTooltip"] = "Sperre alle Fenster an ihrem Ort, sodass sie nichtmehr bewegt, vergr\195\182\195\159ert/verkleinert oder geschlossen werden k\195\182nnen, au\195\159er dies wird \195\188ber das Tab Men\195\188 oder das Hauptmen\195\188 gemacht.";

-- Tutorials

L["DoNotShowHintInFuture"] = " Do not show this\n hint in the future"; -- be sure to include line break and spaces
L["LogoTitle"] = "Using the Combat Analysis Logo";
L["LogoMessage"] = "Left click on the new logo to show or hide all of the Combat Analysis windows. Right click to bring up a mini-menu from which you can access the Save/Load Dialog or the Main Menu.\n\nMove the Logo by pressing 'Control-\\', or alternatively you can disable it from the Menu.";
								
-- Colors by { FullName, Single Letter Abbreviation }
L["Yellow"] = {"Gelb", "Ge"};
L["Red"] = {"Rot", "R"};
L["Green"] = {"Gr\195\188n", "Gr"};
L["Blue"] = {"Blau", "B"};
L["Alpha"] = {"Alpha", "A"};

-- Commands

L["Options"] = "optionen";
L["Settings"] = "einstellungen";
L["Setup"] = "setup";
L["ShowCommand"] = "zeigen";
L["HideCommand"] = "verstecken";
L["ToggleCommand"] = "unschalten";
L["SaveCommand"] = "speichern";
L["LoadCommand"] = "laden";
L["LockCommand"] = "sperren";
L["UnlockCommand"] = "entsperren";
L["LockToggleCommand"] = "sperren umschalten";

L["CommandUsage"] = "Verwendung: /ca "..L.Options.." | "..L.SaveCommand.." | "..L.LoadCommand.." | "..L.ToggleCommand.." | "..L.ShowCommand.." | "..L.HideCommand.." | "..L.LockToggleCommand.." | "..L.LockCommand.." | "..L.UnlockCommand;

-- Classes

L["Burglar"] = {"Schurke","SCH"};
L["Captain"] = {"Hauptmann","HPT"};
L["Champion"] = {"Waffenmeister","WAF"};
L["Guardian"] = {"W\195\164chter","W\195\164C"};
L["Hunter"] = {"J\195\164ger","J\195\164G"};
L["LoreMaster"] = {"Kundiger","KUN"};
L["Minstrel"] = {"Barde","BAR"};
L["RuneKeeper"] = {"runenbewahrer","RBW"};
L["Warden"] = {"H\195\188ter","HTR"};

L["BlackArrow"] = {"Schwarzpfeil","SPF"};
L["Defiler"] = {"Saboteur","SAB"};
L["Reaver"] = {"Schnitter","SHN"};
L["Stalker"] = {"Pirscher","PIR"};
L["WarLeader"] = {"Kriegsanf\195\188hrer","KAF"};
L["Weaver"] = {"Weberspinne","WBR"};

															L["Racial"] = {"Racial","RCL"};
L["Item"] = {"Item","ITM"};
L["OtherClass"] = {"Unbekannt","UBK"};

-- Select File Dialog

															L["Saves"] = "Saves";
															L["Loads"] = "Loads";
															L["Combines"] = "Combines";

-- Other

L["Stun"] = "Stun";
L["Knockdown"] = "Bet\195\164ubung1";

-- Note the following elements are indexed by: {Short Name, Full Name, Per Second Abbreviation, Tab Title, Tab Tooltip}

L["Dmg"] = {"Dmg","Schaden","DPS","Schaden Tab","Ausgehender Schaden Tab"}
L["Taken"] = {"Erlitten","Erlittener Schaden","DPS","Erlittener Tab","Eingehender (erlittener) Schaden Tab"}
L["Heal"] = {"Heilung","Heilung","HPS","Heilungs Tab","Eingehende & ausgehende Heilung Tab"}
L["Power"] = {"Kraft","Kraft","KPS","Kraft Tab","Eingehende & ausgehende Kraftwiederherstellung Tab"}

L["Debuff"] = {"Debuff","Debuff","Debuff","Debuff Tab","Debuff Dauer Tab"}
L["Buff"] = {"Buff","Buff","Buff","Buff Tab","Buff Dauer Tab"}

L["Default"] = "Standard";

-- Champion
L["TrueHeroicsEffect"] = "Freude der Schlacht";
L["TrueHeroicsLog"] = "Wahre Heldentaten";
L["SuddenDefenceEffect"] = "Pl\195\182tzliche Verteidigung";
L["SuddenDefenceLog"] = "Pl\195\182tzliche Verteidigung";
-- Minstrel
L["StoryOfTheHammerhandEffect"] = "Lied der Hammerhand";
L["StoryOfTheHammerhandLog"] = "Hammerhand-Erz\195\164hlung";
L["SongOfTheHammerhandEffect"] = "Lied der Hammerhand";
L["SongOfTheHammerhandLog"] = "Dichtung der Hammerhand";
L["GiftOfTheHammerhandEffect"] = "Gabe der Hammerhand";
L["GiftOfTheHammerhandLog"] = "Erz\195\164hlung der Hammerhand";
-- Rune-Keeper
L["WordOfExaltationEffect"] = "Wort des Hochgef\195\188hls";
L["WordOfExaltationLog"] = "Wort des Hochgef\195\188hls";
L["EssayOfExaltationEffect"] = "Wort des Hochgef\195\188hls";
L["EssayOfExaltationLog"] = "Abhandlung des Hochgef\195\188hls";
-- Other
L["MartyrsFortitudeEffect"] = "Standhaftigkeit des M\195\164rtyrers";
L["MartyrsFortitudeLog"] = "Standhaftigkeit des M\195\164rtyrers";
															L["FrostRingEffect"] = "Ring of Frost";
															L["FrostRingLog"] = "Shield of the Blizzard";

-- New Skills

-- Captain
L["ShieldOfTheDunedain"] = "Schild der D\195\186nedain";
-- Guardian
L["Bash"] = "Heftiger Schlag";
L["ShieldSmash"] = "Schildhieb";
L["ToTheKing"] = "F\195\188r den K\195\182nig";
-- Racial
L["DwarfEndurance"] = "Zwergenausdauer";
-- Other
L["VagabondsCraft"] = "Kunstfertigkeit des Vagabunden";

-- Trait Lines

-- Captain
L["LeadTheCharge"] = "Den Angriff anf\195\188hren";
L["LeaderOfMen"] = "Anf\195\188hrer der Menschen";
L["HandsOfHealing"] = "Heilende H\195\164nde";
-- Champion
L["TheBerserker"] = "Der Berserker";
L["TheDeadlyStorm"] = "Der t\195\182dliche Sturm";
L["TheMartialChampion"] = "Der Meister der Kampfkunst";
-- Guardian
L["TheKeenBlade"] = "Die k\195\188hne Klinge";
L["TheFighterOfShadow"] = "Der Schattenk\195\164mpfer";
L["TheDefenderOfTheFree"] = "Der Verteidiger der Freien";
-- Hunter
L["TheBowmaster"] = "Der Bogenmeister";
L["TheTrapperOfFoes"] = "Der Fallensteller";
L["TheHuntsman"] = "Meister der Jagd";
-- Lore-Master
L["MasterOfNaturesFury"] = "Meister der Naturgewalten";
L["TheAncientMaster"] = "Der uralte Meister";
L["TheKeeperOfAnimals"] = "Der Tierh\195\188ter";
-- Minstrel
L["TheWarriorSkald"] = "Der Krieger-Skalde";
L["TheProtectorOfSong"] = "Der Sch\195\188tzer des Gesangs";
L["TheWatcherOfResolve"] = "Der W\195\164chter der Entschlossenheit";
-- Rune-Keeper
L["CleansingFires"] = "Reinigendes Feuer";
L["SolitaryThunder"] = "Einsamer Donner";
L["BenedictionsOfPeace"] = "Segnungen des Friedens";
-- Warden
L["WayOfTheSpear"] = "Weg des Speers";
L["WayOfTheFist"] = "Weg der Faust";
L["WayOfTheShield"] = "Weg des Schildes";
															
-- Champion

-- Hamstring (log name)
L["Hamstring"] = "Achillessehne";
-- Crowd Control (log name)
L["HornOfGondor"] = "Horn aus Gondor";
L["Horn"] = "Sturmangriff";

-- Lore Master

-- Crowd Control (log name)
L["StormLore"] = "Storm-lore";
L["LightOfTheRisingDawn"] = "Light of the Rising Dawn";
L["TestOfWill"] = "Test of Will";
L["EntsGoToWar"] = "Ents go to War";
L["ImprovedStaffStrike"] = "Improved Staff Strike";

-- Minstrel

-- Debuffs (log name)
L["CallOfOrome"] = "Ruf von Orom\195\171";
L["CryOfTheWizards"] = "Schrei der Zauberer";
L["EchoesOfBattle"] = "Widerhall des Kampfes";
L["TimelessEchoesOfBattle"] = "Zeitloser Widerhall des Kampfes";

-- Hunter

-- Debuffs (log name)
L["QuickShot"] = "Quick Shot";
L["LowCut"] = "Low Cut";
L["CripplingShot"] = "Crippling Shot";
L["SlowingCut"] = "Slowing Cut";

