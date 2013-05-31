

-- E.G -- wBListParent:SetText(_LANG.BListWindowTitle[SETTINGS.LANGUAGE]);

_LANG =
	{

	-- ["STRINGNAME"] = 	{["ENGLISH"] = "";	["FRENCH"] = "";	["GERMAN"] = "";	["RUSSIAN"]="";};

	["PLUGINNAME"] = 	{["ENGLISH"] = "Crafting Companion";		["FRENCH"] = "Crafting Companion";			["GERMAN"] = "Crafting Companion";	["RUSSIAN"]="Помощник в крафте";};

	["MAINWINTITLE"] = 	{["ENGLISH"] = "Crafting Companion";		["FRENCH"] = "Crafting Companion";			["GERMAN"] = "Crafting Companion";	["RUSSIAN"]="Помощник в крафте";};

	["COMMANDWARNING"] = {["ENGLISH"] = "Use command /craftcomp to open the main window";	["FRENCH"] = "Use command /craftcomp to open the main window";	["GERMAN"] = "Use command /craftcomp to open the main window";	["RUSSIAN"]="Используй команду /craftcomp для открытия окна";};

	["SHOPPINGLIST"] = 	{["ENGLISH"] = "Shopping List";		["FRENCH"] = "Shopping List";			["GERMAN"] = "Shopping List";	["RUSSIAN"]="Список покупок";};

	["INVENTORY"] = 	{["ENGLISH"] = "Inventory";		["FRENCH"] = "Inventory";			["GERMAN"] = "Inventory";	["RUSSIAN"]="Инвентори";};

	["INGREDIENTS"] = 	{["ENGLISH"] = "Ingredients";		["FRENCH"] = "Ingredients";			["GERMAN"] = "Ingredients";	["RUSSIAN"]="Ингредиенты";};

	["BASEINGREDIENTS"] = 	{["ENGLISH"] = "Base Ingredients";		["FRENCH"] = "Base Ingredients";			["GERMAN"] = "Base Ingredients";	["RUSSIAN"]="Начальные ингредиенты";};

	["MASTERED"] = 	{["ENGLISH"] = "Mastered";		["FRENCH"] = "Mastered";			["GERMAN"] = "Mastered";	["RUSSIAN"]="Мастер";};

	["COOLDOWN"] = 	{["ENGLISH"] = "Cooldown";		["FRENCH"] = "Cooldown";			["GERMAN"] = "Cooldown";	["RUSSIAN"]="Откат";};

	["DAY"] = 	{["ENGLISH"] = "day";	["FRENCH"] = "day";	["GERMAN"] = "day";	["RUSSIAN"]="день";};
	["DAYS"] = 	{["ENGLISH"] = "days";	["FRENCH"] = "days";	["GERMAN"] = "days";	["RUSSIAN"]="дней";};

	["HOUR"] = 	{["ENGLISH"] = "hour";	["FRENCH"] = "hour";	["GERMAN"] = "hour";	["RUSSIAN"]="час";};
	["HOURS"] = 	{["ENGLISH"] = "hours";	["FRENCH"] = "hours";	["GERMAN"] = "hours";	["RUSSIAN"]="часов";};

	["MINUTE"] = 	{["ENGLISH"] = "minute";	["FRENCH"] = "minute";	["GERMAN"] = "minute";	["RUSSIAN"]="минута";};
	["MINUTES"] = 	{["ENGLISH"] = "minutes";	["FRENCH"] = "minutes";	["GERMAN"] = "minutes";	["RUSSIAN"]="минут";};

	["OR"] = 	{["ENGLISH"] = "or";	["FRENCH"] = "or";	["GERMAN"] = "or";	["RUSSIAN"]="или";};

	["SINGLEUSE"] = 	{["ENGLISH"] = "Single-use";	["FRENCH"] = "Single-use";	["GERMAN"] = "Single-use";	["RUSSIAN"]="Одноразовый";};

	["CRITICALSUCCESS"] = 	{["ENGLISH"] = "Critical Success";	["FRENCH"] = "Critical Success";	["GERMAN"] = "Critical Success";	["RUSSIAN"]="Критический успех";};

	["OPTIONALINGREDIENT"] = 	{["ENGLISH"] = "Optional Ingredient";	["FRENCH"] = "Optional Ingredient";	["GERMAN"] = "Optional Ingredient";	["RUSSIAN"]="Опциональные ингридиенты";};

	["GUILDS"] = 	{["ENGLISH"] = "Guilds";	["FRENCH"] = "Guilds";	["GERMAN"] = "Guilds";	["RUSSIAN"]="Гильдии";};

	["QTY"] = 	{["ENGLISH"] = "Qty:";	["FRENCH"] = "Qty:";	["GERMAN"] = "Qty:";	["RUSSIAN"]="Кол-во:";};

	["NEED"] = 	{["ENGLISH"] = "Need:";	["FRENCH"] = "Need:";	["GERMAN"] = "Need:";	["RUSSIAN"]="Нужно:";};

	["DELETE"] = 	{["ENGLISH"] = "Delete";	["FRENCH"] = "Delete";	["GERMAN"] = "Delete";	["RUSSIAN"]="Удалить";};

	["DELETEALL"] = 	{["ENGLISH"] = "Delete All";	["FRENCH"] = "Delete All";	["GERMAN"] = "Delete All";	["RUSSIAN"]="Удалить все";};

	["AT"] = 	{["ENGLISH"] = "at";	["FRENCH"] = "at";	["GERMAN"] = "at";	["RUSSIAN"]="по";};

	["ZEROQTY"] =
		{
		["ENGLISH"] = "Zero quantity in inventory";
		["FRENCH"] = "Zero quantity in inventory";
		["GERMAN"] = "Zero quantity in inventory";
		["RUSSIAN"] = "Нетути в рюкзаках";
		};

	["ADDSHOPLIST"] =
		{
		["ENGLISH"] = "Add to shopping list";
		["FRENCH"] = "Add to shopping list";
		["GERMAN"] = "Add to shopping list";
		["RUSSIAN"] = "Добавить в список покупок";
		};

	["DONEADDSHOPLIST"] =
		{
		["ENGLISH"] = "Added to shopping list:";
		["FRENCH"] = "Added to shopping list:";
		["GERMAN"] = "Added to shopping list:";
		["RUSSIAN"] = "Добавлено в список покупок:";
		};


	["SETTINGSLOADERROR"] =
		{
		["ENGLISH"] = "Error loading saved settings";
		["FRENCH"] = "Error loading saved settings";
		["GERMAN"] = "Error loading saved settings";
		["RUSSIAN"] = "Ошибка загрузки сохраненных настроек";
		};

	["INVLOADERROR"] =
		{
		["ENGLISH"] = "Error loading saved inventory";
		["FRENCH"] = "Error loading saved inventory";
		["GERMAN"] = "Error loading saved inventory";
		["RUSSIAN"] = "Ошибка загрузки сохраненного инвентори";
		};

	["PLUGLOADED"] =
		{
		["ENGLISH"] = "Crafting Companion successfully loaded";
		["FRENCH"] = "Crafting Companion successfully loaded";
		["GERMAN"] = "Crafting Companion successfully loaded";
		["RUSSIAN"] = "Помощник в крафте удачно загрузился";
		};



	-- Chat log listeners (strings need to match game output exactly to work) ------------------------------------------------------------------
	["CHATLOG"] =
		{
		["NEWRECIPE"] =
			{
			["ENGLISH"] = "You have gained knowledge of the";
			["FRENCH"] = "You have gained knowledge of the";
			["GERMAN"] = "You have gained knowledge of the";
			["RUSSIAN"] = "Вы узнали";
			};

		["PROFESSIONS"] =
			{
			["Cook"] = 			{["ENGLISH"] = "Cook";			["FRENCH"] = "Cook";		["GERMAN"] = "Cook";		["RUSSIAN"]= "Повар";};
			["Forester"] = 		{["ENGLISH"] = "Forester";		["FRENCH"] = "Forester";	["GERMAN"] = "Forester";	["RUSSIAN"]= "Лесоруб";};
			["Metalsmith"] = 	{["ENGLISH"] = "Metalsmith";	["FRENCH"] = "Metalsmith";	["GERMAN"] = "Metalsmith";	["RUSSIAN"]= "Кузнец";};
			["Scholar"] = 		{["ENGLISH"] = "Scholar";		["FRENCH"] = "Scholar";		["GERMAN"] = "Scholar";		["RUSSIAN"]= "Ученый";};
			["Tailor"] = 		{["ENGLISH"] = "Tailor";		["FRENCH"] = "Tailor";		["GERMAN"] = "Tailor";		["RUSSIAN"]= "Портной";};
			["Prospector"] = 	{["ENGLISH"] = "Prospector";	["FRENCH"] = "Prospector";	["GERMAN"] = "Prospector";	["RUSSIAN"]= "Рудокоп";};
			["Woodworker"] = 	{["ENGLISH"] = "Woodworker";	["FRENCH"] = "Woodworker";	["GERMAN"] = "Woodworker";	["RUSSIAN"]= "Деревообработчик";};
			["Farmer"] = 		{["ENGLISH"] = "Farmer";		["FRENCH"] = "Farmer";		["GERMAN"] = "Farmer";		["RUSSIAN"]= "Фермер";};
			["Weaponsmith"] = 	{["ENGLISH"] = "Weaponsmith";	["FRENCH"] = "Weaponsmith";	["GERMAN"] = "Weaponsmith";	["RUSSIAN"]= "Оружейник";};
			["Jeweller"] = 		{["ENGLISH"] = "Jeweller";		["FRENCH"] = "Jeweller";	["GERMAN"] = "Jeweller";	["RUSSIAN"]= "Ювелир";};
			};
		};
	};



