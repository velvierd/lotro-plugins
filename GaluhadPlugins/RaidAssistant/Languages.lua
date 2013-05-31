
-- German translations with thanks to Noirolgam and Pesti.
-- French translation by Kiki (kikiadoc@Sirannon[FR])
-- Russian translation by DToX

-- E.G -- wBListParent:SetText(_LANG.BListWindowTitle[SETTINGS.LANGUAGE]);

_LANG =
	{

	-- ROLL WINDOW ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["RollWindowTitle"] = 	{["ENGLISH"] = "Rolls";												["RUSSIAN"] = "Броски";												["FRENCH"] = "Lancés de dés";										["GERMAN"] = "Würfe";};
	["Roll_Clear"] = 		{["ENGLISH"] = "Reset";												["RUSSIAN"] = "Сброс";												["FRENCH"] = "Reinit";												["GERMAN"] = "Zurücksetzen";};
	["Roll_Unique"] = 		{["ENGLISH"] = " Unique rolls only";								["RUSSIAN"] = " Только уникальные";									["FRENCH"] = " Uniq. premier dé";									["GERMAN"] = "nur einmaliges Würfeln";};
	["NoGroup"] = 			{["ENGLISH"] = "No group";											["RUSSIAN"] = "Нет группы";											["FRENCH"] = "Groupez vous!";										["GERMAN"] = "Keine Gruppe";};
	["Roll_RollLbl"] =		{["ENGLISH"] = "Rolls..";											["RUSSIAN"] = "Бросили:";											["FRENCH"] = "Les lancés...";										["GERMAN"] = "Würfe..";};
	["Roll_FSLbl"] =		{["ENGLISH"] = "Not yet rolled..";									["RUSSIAN"] = "Не бросали:";										["FRENCH"] = "En attente de...";									["GERMAN"] = "Noch nicht gewürfelt..";};
	["SEND"] = 				{["ENGLISH"] = "Send";												["RUSSIAN"] = "В чат";												["FRENCH"] = "Send";												["GERMAN"] = "Send";};
	["ROLLRESULTS"] = 		{["ENGLISH"] = "Roll Results";										["RUSSIAN"] = "Результаты бросков";									["FRENCH"] = "Roll Results";										["GERMAN"] = "Roll Results";};
	["PASS"] = 				{["ENGLISH"] = "Players who did not roll";							["RUSSIAN"] = "Не участвовали";										["FRENCH"] = "Players who did not roll";							["GERMAN"] = "Players who did not roll";};

	-- LOOT WINDOW -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["LootWindowTitle"] = 	{["ENGLISH"] = "Loot History";										["RUSSIAN"] = "История трофеев";									["FRENCH"] = "Historique de Loot";											["GERMAN"] = "Beute Historie";};
	["LootExportTitle"] = 	{["ENGLISH"] = "Loot History Export";								["RUSSIAN"] = "Экспорт Истории трофеев";							["FRENCH"] = "Export de l'historique de Loot";								["GERMAN"] = "Beute Historie exportieren";};
	["ALL"] = 				{["ENGLISH"] = "All";												["RUSSIAN"] = "Все";												["FRENCH"] = "Tout";														["GERMAN"] = "Alle";};
	["Export"] = 			{["ENGLISH"] = "Export";											["RUSSIAN"] = "Экспорт";											["FRENCH"] = "Exporter";													["GERMAN"] = "Exportieren";};
	["IgnoreItemButton"] = 	{["ENGLISH"] = "Ignore List";										["RUSSIAN"] = "Исключенные";											["FRENCH"] = "Liste des ignorés";											["GERMAN"] = "Ignorieren-Liste";};
	["Entries"] = 			{["ENGLISH"] = "Entries";											["RUSSIAN"] = "записей";											["FRENCH"] = "Elements";													["GERMAN"] = "Ergebnisse";};
	["Items"] = 			{["ENGLISH"] = "Items";												["RUSSIAN"] = "предметов";											["FRENCH"] = "Objets";														["GERMAN"] = "Gegenstände";};
	["IgnoreItemChk"] = 	{["ENGLISH"] = "Ignore Item";										["RUSSIAN"] = "Ignore Item"; --[[ DToX: Not used in RA--]]			["FRENCH"] = "Objet ignoré";												["GERMAN"] = "Ignorierte Gegenstände";};
	["ExportHelp"] = 		{["ENGLISH"] = "Copy using Ctrl+C then paste externally to save.";	["RUSSIAN"] = "Для копирования используйте комбинацию Ctrl+C.";		["FRENCH"] = "Copier par Ctrl+C et coller ailleurs pour sauvegarder.";		["GERMAN"] = "mit Strg + c kopieren, zum Speichern danach einfügen.";};
	["SelectAll"] = 		{["ENGLISH"] = "Select All";										["RUSSIAN"] = "Выбрать все";										["FRENCH"] = "Tout sélectionner";											["GERMAN"] = "Alle wählen";};
	["IgnoredDesc"] = 		{["ENGLISH"] = "Items currently being ignored in your Loot History";["RUSSIAN"] = "Данные предметы не отображаются в Истории трофеев";	["FRENCH"] = "Elements actuellement ignorés dans votre historique de loot";	["GERMAN"] = "Gegenstände werden zur Zeit in der Historie ignoriert";};
	["ExpRollsOnly"] = 		{["ENGLISH"] = " Rolled items only";								["RUSSIAN"] = " Только с бросками";									["FRENCH"] = " Uniquement les objets joués aux dés";						["GERMAN"] = " Rolled items only";};
	["SelfLootLog"] = 		{["ENGLISH"] = "Loot Logging: Self";								["RUSSIAN"] = "Вести запись: мои";									["FRENCH"] = "Loot Logging: Self";											["GERMAN"] = "Loot Logging: Self";};
	["FellowLootLog"] = 	{["ENGLISH"] = "Loot Logging: Fellow";								["RUSSIAN"] = "Вести запись: чужие";								["FRENCH"] = "Loot Logging: Fellow";										["GERMAN"] = "Loot Logging: Fellow";};


	-- LFF WINDOW -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["LFFWindowTitle"] = 	{["ENGLISH"] = "LFF";												["RUSSIAN"] = "LFF";												["FRENCH"] = "LFF";													["GERMAN"] = "SNG";};


	-- LOG WINDOW -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["RAIDLOG"] =		 	{["ENGLISH"] = "Raid Log";											["RUSSIAN"] = "Журнал рейда";										["FRENCH"] = "Journal de raid";										["GERMAN"] = "Raid Log";};
	["LOGSTATUS01"] = 		{["ENGLISH"] = "Join a group to begin logging.";					["RUSSIAN"] = "Для ведения журнала вступите в братство/рейд.";		["FRENCH"] = "Groupez pour commencer l'enregistrement.";			["GERMAN"] = "Join a group to begin logging.";};
	["LOGSTATUS02"] = 		{["ENGLISH"] = "Logging in progress...";							["RUSSIAN"] = "Журнал активен...";									["FRENCH"] = "Enregistrement en cours...";							["GERMAN"] = "Logging in progress...";};
	["LOGPLAYERJOIN"] =		{["ENGLISH"] = "Joined the group";									["RUSSIAN"] = "Вступил в братство/рейд";							["FRENCH"] = "a rejoint le groupe";									["GERMAN"] = "Joined the group";};
	["LOGPLAYERLEAVE"] =	{["ENGLISH"] = "Left the group";									["RUSSIAN"] = "Покинул братство/рейд";								["FRENCH"] = "a quitté le groupe";									["GERMAN"] = "Left the group";};
	["LOGNEWLEADER"] =		{["ENGLISH"] = "Became group leader";								["RUSSIAN"] = "Новый предводитель братства/рейда";					["FRENCH"] = "est devenu le leader";								["GERMAN"] = "Became group leader";};
	["LOGJOINED"] =			{["ENGLISH"] = "Grouped";											["RUSSIAN"] = "В братстве";											["FRENCH"] = "groupé";												["GERMAN"] = "Grouped";};
	["LOGLEFT"] =			{["ENGLISH"] = "No longer in a group";								["RUSSIAN"] = "No longer in a group"; --[[ DToX: Not used in RA--]]	["FRENCH"] = "N'est plus dans le groupe";							["GERMAN"] = "No longer in a group";};
	["LOGLOOTRULE"] =		{["ENGLISH"] = "Loot Rule: ";										["RUSSIAN"] = "Распред. трофеев: ";									["FRENCH"] = "Regle de loot: ";										["GERMAN"] = "Loot Rule: ";};
	["LOGLOOTQUAL"] =		{["ENGLISH"] = "Loot Quality: ";									["RUSSIAN"] = "Ценность трофеев: ";									["FRENCH"] = "Qualité de loot: ";									["GERMAN"] = "Loot Quality: ";};
	["LOGNEWRAT"] =			{["ENGLISH"] = "Added to Raid Assist Target";						["RUSSIAN"] = "Добавлен в цели помощника рейда";					["FRENCH"] = "Ajouté en cible d'assist";							["GERMAN"] = "Added to Raid Assist Target";};
	["LOGREMRAT"] =			{["ENGLISH"] = "Removed from Raid Assist Target";					["RUSSIAN"] = "Убран из целей помощника рейда";						["FRENCH"] = "Supprimé des cibles d'assist";						["GERMAN"] = "Removed from Raid Assist Target";};
	["LOGHEADERTIME"] =		{["ENGLISH"] = "Time";												["RUSSIAN"] = "Время";												["FRENCH"] = "Heure";												["GERMAN"] = "Time";};
	["LOGHEADERTYPE"] =		{["ENGLISH"] = "Type";												["RUSSIAN"] = "Тип";												["FRENCH"] = "Type";												["GERMAN"] = "Type";};
	["LOGHEADERPLAYER"] =	{["ENGLISH"] = "Player";											["RUSSIAN"] = "Игрок";												["FRENCH"] = "Joueur";												["GERMAN"] = "Player";};
	["LOGHEADERMSG"] =		{["ENGLISH"] = "Message";											["RUSSIAN"] = "Сообщение";											["FRENCH"] = "Message";												["GERMAN"] = "Message";};
	["BACK"] =				{["ENGLISH"] = "Back";												["RUSSIAN"] = "Назад";												["FRENCH"] = "Retour";												["GERMAN"] = "Back";};
	["REMOVEIGNORELOOT"] =  {["ENGLISH"] = "Removed from ignore list";							["RUSSIAN"] = "Удален из списка исключений";						["FRENCH"] = "Removed from ignore list";							["GERMAN"] = "Removed from ignore list";};

	-- BLACKLIST WINDOW -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["BListWindowTitle"] = 	{["ENGLISH"] = "Blacklist";											["RUSSIAN"] = "Черный список";										["FRENCH"] = "Liste des ignorés";									["GERMAN"] = "Schwarze Liste";};
	["ADD"] = 				{["ENGLISH"] = "Add";												["RUSSIAN"] = "Новый";												["FRENCH"] = "Ajouter";												["GERMAN"] = "Hinzufügen";};
	["REMOVE"] = 			{["ENGLISH"] = "Remove";											["RUSSIAN"] = "Удалить";											["FRENCH"] = "Supprimer";											["GERMAN"] = "Entfernen";};
	["EDIT"] = 				{["ENGLISH"] = "Edit";												["RUSSIAN"] = "Изменить";											["FRENCH"] = "Editer";												["GERMAN"] = "Bearbeiten";};
	["SORT"] = 				{["ENGLISH"] = "Sort";												["RUSSIAN"] = "Сортировать";										["FRENCH"] = "Trier";												["GERMAN"] = "Sortieren";};
	["AZ"] =				{["ENGLISH"] = "A to Z";											["RUSSIAN"] = "От А до Я";											["FRENCH"] = "A à Z";												["GERMAN"] = "A to Z";};
	["ZA"] = 				{["ENGLISH"] = "Z to A";											["RUSSIAN"] = "От Я до А";											["FRENCH"] = "Z à A";												["GERMAN"] = "Z to A";};
	["NEWEST"] = 			{["ENGLISH"] = "Newest";											["RUSSIAN"] = "Newest";	--[[ DToX: Not used in RA --]]				["FRENCH"] = "+Recent";												["GERMAN"] = "Neuste";};
	["OLDEST"] = 			{["ENGLISH"] = "Oldest";											["RUSSIAN"] = "Oldest";	--[[ DToX: Not used in RA --]]				["FRENCH"] = "+Vieux";												["GERMAN"] = "Älteste";};
	["SAVE"] = 				{["ENGLISH"] = "Save";												["RUSSIAN"] = "Готово";												["FRENCH"] = "Sauvegarder";											["GERMAN"] = "Speichern";};
	["CANCEL"] = 			{["ENGLISH"] = "Cancel";											["RUSSIAN"] = "Отмена";												["FRENCH"] = "Annuler";												["GERMAN"] = "Abbrechen";};
	["NAME"] = 				{["ENGLISH"] = "Name";												["RUSSIAN"] = "Имя персонажа";										["FRENCH"] = "Nom";													["GERMAN"] = "Name";};
	["REASON"] = 			{["ENGLISH"] = "Reason";											["RUSSIAN"] = "Причина";											["FRENCH"] = "Cause";												["GERMAN"] = "Reason";};
	["REMOVEDBLIST"] =		{["ENGLISH"] = "Removed from Blacklist";							["RUSSIAN"] = "Удален из черного списка";							["FRENCH"] = "Removed from Blacklist";								["GERMAN"] = "Removed from Blacklist";};

	-- INSTANCE WINDOW ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["InstWindowTitle"] = 	{["ENGLISH"] = "Instances";											["RUSSIAN"] = "Инстансы";											["FRENCH"] = "Instances";											["GERMAN"] = "Instanzen";};


	-- SETTINGS WINDOW ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["SettWindowTitle"] = 	{["ENGLISH"] = "Settings";											["RUSSIAN"] = "Настройки";											["FRENCH"] = "Parametrage";											["GERMAN"] = "Einstellungen";};


	-- SHOUT WINDOW ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["SHOUTWINTITLE"] = 	{["ENGLISH"] = "Shouts";											["RUSSIAN"] = "Крики";												["FRENCH"] = "Shouts";												["GERMAN"] = "Shouts";};
	["SHOUTSHOW"] = 		{["ENGLISH"] = "Show/Hide";											["RUSSIAN"] = "Показывать всегда";									["FRENCH"] = "Show/Hide";											["GERMAN"] = "Show/Hide";};
	["SHOUTSHOWLEAD"] = 	{["ENGLISH"] = "Show only if leader";								["RUSSIAN"] = "Если предводитель";									["FRENCH"] = "Show only if leader";									["GERMAN"] = "Show only if leader";};
	["TARGET"] = 			{["ENGLISH"] = ";target";											["RUSSIAN"] = ";target";											["FRENCH"] = ";target";												["GERMAN"] = ";target";};
	["SHOUTADD"] = 			{["ENGLISH"] = "Add Shout";											["RUSSIAN"] = "Создание крика";										["FRENCH"] = "Add Shout";											["GERMAN"] = "Add Shout";};
	["SHOUTEDIT"] = 		{["ENGLISH"] = "Edit Shout";										["RUSSIAN"] = "Изменение крика";									["FRENCH"] = "Edit Shout";											["GERMAN"] = "Edit Shout";};
	["DELETESHOUT"] = 		{["ENGLISH"] = "Delete Shout";										["RUSSIAN"] = "Удалить крик";										["FRENCH"] = "Delete Shout";										["GERMAN"] = "Delete Shout";};
	["GENERAL"] = 			{["ENGLISH"] = "General";											["RUSSIAN"] = "Обычные";											["FRENCH"] = "General";												["GERMAN"] = "General";};
	["NEWCAT"] = 			{["ENGLISH"] = "New Category";										["RUSSIAN"] = "Новая категория";									["FRENCH"] = "New Category";										["GERMAN"] = "New Category";};
	["CATEGORY"] = 			{["ENGLISH"] = "Category";											["RUSSIAN"] = "Категория";											["FRENCH"] = "Category";											["GERMAN"] = "Category";};
	["FILTER"] = 			{["ENGLISH"] = "Filter";											["RUSSIAN"] = "Категория";												["FRENCH"] = "Filter";												["GERMAN"] = "Filter";};
	["INVALIDSHOUT"] =
		{
		["ENGLISH"] = "The shout you are trying to save is not valid.\n Please ensure you have entered something.";
		["RUSSIAN"] = "Вы пытаетесь сохранить некорректное выражение.\n Пожалуйста, убедитесь, что оно не пустое.";
		["FRENCH"] = "The shout you are trying to save is not valid.\n Please ensure you have entered something.";
		["GERMAN"] = "The shout you are trying to save is not valid.\n Please ensure you have entered something.";
		};

	-- MESSAGES ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["MESSAGE01"] = 	{["ENGLISH"] = "You are not currently in a group";						["RUSSIAN"] = "Вы не состоите в братстве/рейде";					["FRENCH"] = "Vous n'êtes pas dans un groupe";											["GERMAN"] = "Sie sind nicht in einer Gruppe";};
	["MESSAGE02"] = 	{["ENGLISH"] = "You have joined a group with blacklisted players:";		["RUSSIAN"] = "В братстве находятся игроки из черного списка:";		["FRENCH"] = "Vous avez rejoint un groupe avec un joueur de votre liste des ignorés:";	["GERMAN"] = "Sie haben sich einer Gruppe mit einem Spieler auf der Ignorieren-Liste angeschlossen:";};
	["MESSAGE03"] = 	{["ENGLISH"] = "A blacklisted player has joined your group:";			["RUSSIAN"] = "К братству присоединился игрок из черного списка:";	["FRENCH"] = "Un joueur de votre liste des ignorés a rejoint votre groupe:";			["GERMAN"] = "Ein Spieler auf der Ignorieren-Liste hat sich Ihrer Gruppe angschlossen:";};
	["MESSAGE04"] = 	{["ENGLISH"] = "New leader: ";											["RUSSIAN"] = "Новый предводитель: ";								["FRENCH"] = "Nouveau leader: ";														["GERMAN"] = "Neuer Anführer: ";};
	["MESSAGE05"] =		{["ENGLISH"] = "You need to select an entry to edit";					["RUSSIAN"] = "Для изменения сначала выберите запись";				["FRENCH"] = "Vous devez sélectionner un ignoré pour le modifier";						["GERMAN"] = "Sie müssen etwas auswählen, um es bearbeiten zu können";};
	["MESSAGE06"] = 	{["ENGLISH"] = "Remove ";												["RUSSIAN"] = "Удалить ";											["FRENCH"] = "Supprimer ";																["GERMAN"] = "Wollen Sie ";};
	["MESSAGE07"] = 	{["ENGLISH"] = " from Blacklist?";										["RUSSIAN"] = " из черного списка?";								["FRENCH"] = " de la liste des ignorés?";												["GERMAN"] = " von der Ignorieren-Liste löschen?";};
	["MESSAGE08"] = 	{["ENGLISH"] = "You need to select an entry to remove";					["RUSSIAN"] = "Для удаления сначала выберите запись";				["FRENCH"] = "Vous devez sélectionner un ignoré pour le supprimer de la liste";			["GERMAN"] = "Sie müssen etwas auswählen, um es zu löschen";};
	["MESSAGE09"] = 	{["ENGLISH"] = " added to the Blacklist";								["RUSSIAN"] = " добавлен в черный список";							["FRENCH"] = " ajouté à la liste des ignorés";											["GERMAN"] = " der Ignorieren-Liste hinzugefügt";};
	["MESSAGE10"] = 	{["ENGLISH"] = "Delete all entries from ignored list?";					["RUSSIAN"] = "Удалить все записи из списка исключений?";			["FRENCH"] = "Supprimer tout dans la liste des ignorés?";								["GERMAN"] = "Alle Einträge der Ignorieren-Liste löschen?";};
	["MESSAGE11"] = 	{["ENGLISH"] = "Ignore: ";												["RUSSIAN"] = "Исключить: ";										["FRENCH"] = "Ignorer: ";																["GERMAN"] = "Ignorieren: ";};
	["MESSAGE12"] = 	{["ENGLISH"] = "Added to ignore list: ";								["RUSSIAN"] = "Исключен трофей: ";									["FRENCH"] = "Ajouté a la liste des ignorés: ";											["GERMAN"] = "Der Ignorieren-Liste hinzugefügt: ";};
	["MESSAGE13"] = 	{["ENGLISH"] = "Use roll: ";											["RUSSIAN"] = "Бросок: ";											["FRENCH"] = "Utiliser un dé: ";														["GERMAN"] = "Use roll: ";};
	["MESSAGE14"] = 	{["ENGLISH"] = "Reset loot history?";									["RUSSIAN"] = "Очистить историю трофеев?";							["FRENCH"] = "Reinitialiser l'historique de loot?";										["GERMAN"] = "Reset loot history?";};
	["MESSAGE15"] = 	{["ENGLISH"] = "No group detected";										["RUSSIAN"] = "Вы не состоите в братстве/рейде";					["FRENCH"] = "No group detected";														["GERMAN"] = "No group detected";};
	["MESSAGE16"] = 	{["ENGLISH"] = "Group detected";										["RUSSIAN"] = "Вы состоите в братстве/рейде";						["FRENCH"] = "Group detected";															["GERMAN"] = "Group detected";};


	-- CHAT FILTERS -- DO NOT CHANGE!! ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["rolled"] = 			{["ENGLISH"] = "rolled";											["RUSSIAN"] = "выбрасывает";										["FRENCH"] = "a obtenu %(";										["GERMAN"] = "würfelt";};		-- Used to filter chat log for rolls
	["acquired"] = 			{["ENGLISH"] = "acquired";											["RUSSIAN"] = "Получено";											["FRENCH"] = "obtenu l";										["GERMAN"] = "Erhalten";};		-- Used to filter chat log for items acquired
	["acquiredGermanFS"] =	{["ENGLISH"] = "";													["RUSSIAN"] = "получает";											["FRENCH"] = "";												["GERMAN"] = "hat gefunden";};		-- Used to filter chat log for items acquired

	["joinedFS"] = 			{["ENGLISH"] = "You have joined a Fellowship";						["RUSSIAN"] = "Вы присоединились к братству";						["FRENCH"] = "Vous avez rejoint une communauté";				["GERMAN"] = "Ihr habt Euch einer Gruppe von Gefährten angeschlossen";};
	["joinedRA"] = 			{["ENGLISH"] = "You have joined a Raid";							["RUSSIAN"] = "Вы присоединились к рейду";							["FRENCH"] = "Vous avez rejoint un raid";						["GERMAN"] = "Ihr habt Euch einem Schlachtzug angeschlossen";};
	["leftFS"] = 			{["ENGLISH"] = "You leave your Fellowship";							["RUSSIAN"] = "Вы покидаете братство";								["FRENCH"] = "Vous quittez votre communauté";					["GERMAN"] = "Ihr verlasst Eure Gruppe von Gefährten.";};
	["leftRA"] = 			{["ENGLISH"] = "You leave your Raid";								["RUSSIAN"] = "Вы покидаете рейд";									["FRENCH"] = "Vous quittez votre raid";							["GERMAN"] = "Ihr verlasst Euren Schlachtzug";};

	["dismissFS"] = 		{["ENGLISH"] = "You have been dismissed from your Fellowship";		["RUSSIAN"] = "Вы исключены из братства";							["FRENCH"] = "Vous avez été renvoyé de votre communauté";		["GERMAN"] = "Ihr wurdet aus Eurer Gruppe von Gefährten ausgeschlossen";};
	["dismissGrp"] = 		{["ENGLISH"] = "You have been dismissed from your Group";			["RUSSIAN"] = "You have been dismissed from your Group";			["FRENCH"] = "Vous avez été renvoyé de votre groupe";			["GERMAN"] = "Ihr wurdet aus Eurer Gruppe ausgeschlossen";};
	["dismissRA"] = 		{["ENGLISH"] = "You have been dismissed from your Raid";			["RUSSIAN"] = "Вы исключены из рейда";								["FRENCH"] = "Vous avez été renvoyé de votre raid";				["GERMAN"] = "Ihr wurdet aus Eurem Schlachtzug ausgeschlossen";};
	["disbandFS"] = 		{["ENGLISH"] = "Your Fellowship has been disbanded";				["RUSSIAN"] = "Братство расформировано";							["FRENCH"] = "Votre communauté s'est rompue";					["GERMAN"] = "Eure Gruppe von Gefährten wurde aufgelöst";};
	["disbandRA"] = 		{["ENGLISH"] = "Your Raid has been disbanded";						["RUSSIAN"] = "Рейд распущен";										["FRENCH"] = "Votre raid a été dissout";						["GERMAN"] = "Euer Schlachtzug wurde aufgelöst";};

	["playerleftFS"] = 		{["ENGLISH"] = "has left your Fellowship";							["RUSSIAN"] = "покидает братство";									["FRENCH"] = "a quitté votre communauté";						["GERMAN"] = "hat Eure Gruppe von Gefährten verlassen";};
	["playerleftRA"] = 		{["ENGLISH"] = "has left your Raid";								["RUSSIAN"] = "покидает рейд";										["FRENCH"] = "a quitté votre raid";								["GERMAN"] = "hat Euren Schlachtzug verlassen";};
	["playerjoinFS"] = 		{["ENGLISH"] = "has joined your Fellowship";						["RUSSIAN"] = "присоединяется к братству";							["FRENCH"] = "a rejoint votre communauté";						["GERMAN"] = "hat sich Eurer Gruppe von Gefährten angeschlossen";};
	["playerjoinRA"] = 		{["ENGLISH"] = "has joined your Raid";								["RUSSIAN"] = "присоединяется к рейду";								["FRENCH"] = "a rejoint votre raid";							["GERMAN"] = "hat sich Eurem Schlachtzug angeschlossen";};
	["playerdismiss"] = 	{["ENGLISH"] = "you dismiss";										["RUSSIAN"] = "Вы исключаете";										["FRENCH"] = "you dismiss";										["GERMAN"] = "Ihr schließt";};
	["playerDismissedFS"] =	{["ENGLISH"] = "has been dismissed from your Fellowship";			["RUSSIAN"] = "исключается из братства";							["FRENCH"] = "ne fait plus partie de votre communauté";			["GERMAN"] = "wurde aus Eurer Gruppe von Gefährten ausgeschlossen";};
	["playerDismissedRA"] =	{["ENGLISH"] = "has been dismissed from your Raid";					["RUSSIAN"] = "исключается из рейда";								["FRENCH"] = "ne fait plus partie de votre raid";				["GERMAN"] = "wurde aus Eurem Schlachtzug ausgeschlossen";};

	["newFSleader"] =		{["ENGLISH"] = "now the leader of the fellowship";					["RUSSIAN"] = "предводитель братства";								["FRENCH"] = "est à présent le chef de votre communauté";		["GERMAN"] = "führt jetzt die Gruppe von Gefährten an";};
	["newRAleader"] =		{["ENGLISH"] = "now the leader of the raid";						["RUSSIAN"] = "возглавляет";										["FRENCH"] = "est à présent le chef de votre raid";				["GERMAN"] = "führt jetzt den Schlachtzug an";};

	["AddAssistTarg"] =		{["ENGLISH"] = "is now a raid assist target";						["RUSSIAN"] = "добавляется в цели помощника рейда";					["FRENCH"] = "est désormais une cible d'assistance de raid";	["GERMAN"] = "is now a raid assist target";};
	["RemAssistTarg"] =		{["ENGLISH"] = "is no longer a raid assist target";					["RUSSIAN"] = "выводится из целей помощника рейд";					["FRENCH"] = "n'est plus une cible d'assistance de raid";		["GERMAN"] = "is no longer a raid assist target";};

	["FSSKILL1"] = 			{["ENGLISH"] = "Targeted Fellowship Skill: ";						["RUSSIAN"] = "Установлено умение братства: ";						["FRENCH"] = "Targeted Fellowship Skill: ";						["GERMAN"] = "Targeted Fellowship Skill: ";};
	["FSSKILL2"] = 			{["ENGLISH"] = " has been set";										["RUSSIAN"] = " has been set"; --[[ DToX: Not used in RA--]]		["FRENCH"] = " has been set";									["GERMAN"] = " has been set";};

	["LootRule"] =			{["ENGLISH"] = "The loot rule has changed to";						["RUSSIAN"] = "Правило сбора трофеев меняется на";					["FRENCH"] = "La règle de butin a été changée pour";			["GERMAN"] = "Die Plünderregel lautet ab jetzt";};
	["LootQuality"] =		{["ENGLISH"] = "The loot quality has changed to";					["RUSSIAN"] = "Ценность трофеев меняется на";						["FRENCH"] = "La qualité de butin a été changée en";			["GERMAN"] = "Die Plünder%-Qualität liegt jetzt bei";};

	["LOOTRULES"] =
	{
	[1] = 					{["ENGLISH"] = "Free For All";										["RUSSIAN"] = "'Кто успел'";										["FRENCH"] = "Accès libre";										["GERMAN"] = "Alle dürfen plündern";};
	[2] = 					{["ENGLISH"] = "Round Robin with Need/Greed/Pass";					["RUSSIAN"] = "'По очереди: нужно\\можно\\пас'";					["FRENCH"] = "A tour de rôle avec Besoin/Envie/Passe";			["GERMAN"] = "Abwechselnd plündern nach Bedarf/Gier/Verzichten";};
	[3] = 					{["ENGLISH"] = "Free For All with Need/Greed/Pass";					["RUSSIAN"] = "'Кто успел: нужно\\можно\\пас'";						["FRENCH"] = "Chacun pour soi, avec besoin/cupidité/passe";		["GERMAN"] = "Alle dürfen plündern: Bedarf/Gier/Verzicht";};
	[4] = 					{["ENGLISH"] = "Round Robin with Roll/Pass";						["RUSSIAN"] = "'По очереди: бросок\\пас'";							["FRENCH"] = "A tour de rôle avec Tirage au sort/Passe";		["GERMAN"] = "Abwechselnd plündern nach Wurf/Verzichten";};
	[5] = 					{["ENGLISH"] = "Free For All with Roll/Pass";						["RUSSIAN"] = "'Кто успел: бросок\\пас'";							["FRENCH"] = "Chacun pour soi, avec Tirage au sort/Passe";		["GERMAN"] = "Alle dürfen plündern: Wurf/Verzicht";};
	[6] = 					{["ENGLISH"] = "Round Robin with Master Looter";					["RUSSIAN"] = "'По очереди: распределение'";						["FRENCH"] = "A tour de rôle %- chef de butin";					["GERMAN"] = "Abwechselnd plündern %(Meisterplünderer)";};
	[7] = 					{["ENGLISH"] = "Free For All with Master Looter";					["RUSSIAN"] = "'Кто успел: распределение'";							["FRENCH"] = "Chacun pour soi, avec chef du butin";				["GERMAN"] = "Alle dürfen plündern mit Meisterplünderer";};
	};

	["LOOTQUALITIES"] =
	{
	[1] = 					{["ENGLISH"] = "None";												["RUSSIAN"] = "Нет";												["FRENCH"] = "Aucun";											["GERMAN"] = "Keine";};
	[2] = 					{["ENGLISH"] = "Common";											["RUSSIAN"] = "Обычные";											["FRENCH"] = "Commun";											["GERMAN"] = "Allgemein";};
	[3] = 					{["ENGLISH"] = "Uncommon";											["RUSSIAN"] = "Необычные";											["FRENCH"] = "Peu commun";										["GERMAN"] = "Ungewцhnlich";};
	[4] = 					{["ENGLISH"] = "Rare";												["RUSSIAN"] = "Редкие";												["FRENCH"] = "Rare";											["GERMAN"] = "Rar";};
	[5] = 					{["ENGLISH"] = "Incomparable";										["RUSSIAN"] = "Несравненные";										["FRENCH"] = "Incomparable";									["GERMAN"] = "Unvergleichlich";};
	[6] = 					{["ENGLISH"] = "Epic";												["RUSSIAN"] = "Эпические";											["FRENCH"] = "Epique";											["GERMAN"] = "Epos";};
	};

	["You"] =				{["ENGLISH"] = "You";												["RUSSIAN"] = "вы";													["FRENCH"] = "Vous";											["GERMAN"] = "Ihr";};

-- {["ENGLISH"] = "";			["RUSSIAN"] = "";			["FRENCH"] = "";			["GERMAN"] = "";};

	};


--[[
function Encode(t)

	for k,v in pairs(t) do
		-- CHeck the translations and UTF encode if needed.
		if type(v) == 'table' then
			Encode(v);
		else
			if k == "GERMAN" or k == "RUSSIAN" then
				t[k] = ToUTF8(v);
			end
		end
	end

end

Encode(_LANG);
]]
