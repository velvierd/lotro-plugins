
-- GROUP GLOBALS
MYCHAR = Turbine.Gameplay.LocalPlayer.GetInstance();
GROUPSIZE = 0;
GROUPMEMBER = {};
MANUALGROUPMEMBER = {};
MANUALGROUPSIZE = 0;

-- Group info..

function GroupChanged()

	--MYCHAR = Turbine.Gameplay.LocalPlayer.GetInstance();
	MYPARTY = MYCHAR:GetParty();

	if MYPARTY == nil then

		-- Not in a group
		GAMessage(_LANG.MESSAGE01[SETTINGS.LANGUAGE]);
		GROUPSIZE = 0;
		GROUPMEMBER = nil;

	else

		GROUPSIZE = MYPARTY:GetMemberCount();

		GROUPMEMBER = nil;
		GROUPMEMBER = {};

		for i=1, GROUPSIZE do

			GROUPMEMBER[i] = MYPARTY:GetMember(i);

		end

		local PLAYERLEADER = MYPARTY:GetLeader();
		GROUPLEADER = PLAYERLEADER:GetName();

	end

	-- External functions to update with the new group
	if Windows.RollsFSlistBOX ~= nil then
		Windows.rolls_RefreshFSList();
	end

	if Windows.LootPlayerDropDown ~= nil then
		Windows.RefreshPlayerMenu();
	end

	if Windows.wMinShouts ~= nil then
		Windows.ShowMiniShouts();
		Windows.UpdateMiniShouts();
	end

end


function GroupLoad()

	MYPARTY = MYCHAR:GetParty();

	if MYPARTY == nil then
		-- No group detected on load
		GAMessage(_LANG.MESSAGE15[SETTINGS.LANGUAGE]);
		GROUPSIZE = 0;

	else

		Windows.DrawLogWindow();
		JoinedGroup();

	end

end


-- Keep a look out in the chat log for joining a fellowship as that seems to be the only way to keep track.
function JoinedGroup()

	Windows.StartLogging();
	GroupChanged();
	ManualGroupJoin();
	if Windows.RollslistBOX ~= nil then Windows.RollslistBOX:ClearItems() end;
	_ROLLS = nil;
	GAMessage(_LANG.MESSAGE16[SETTINGS.LANGUAGE]);
	MYPARTY = nil;

end


function LeftGroup()

	MYPARTY = nil;

	-- Not in a group
	GROUPSIZE = 0;
	GroupChanged();
	GROUPMEMBER = nil;

	MANUALGROUPMEMBER = {};
	MANUALGROUPSIZE = 0;

	GROUPLEADER = "";

	Windows.RaidLog(3,_LANG.LOGPLAYERLEAVE[SETTINGS.LANGUAGE],MYNAME)
	Windows.StopLogging();

	if Windows.RollsFSlistBOX ~= nil then
		Windows.rolls_RefreshFSList();
	end

	if Windows.LootPlayerDropDown ~= nil then
		Windows.RefreshPlayerMenu();
	end

	if Windows.lblLootRule ~= nil then
		Windows.lblLootRule:SetText("");
	end

	if Windows.wMinShouts ~= nil then
		Windows.ShowMiniShouts();
		Windows.UpdateMiniShouts();
	end
end


function GetGroup()

	--return GROUPSIZE, GROUPMEMBER;
	return MANUALGROUPSIZE, MANUALGROUPMEMBER;

end


function ManualGroupJoin()

	MANUALGROUPSIZE = GROUPSIZE;

	local sBlacklisted = "";
	local logPlayers = _LANG.LOGJOINED[SETTINGS.LANGUAGE] .. ": "	;

	for i=1, MANUALGROUPSIZE do

		local PLAYERNAME = GROUPMEMBER[i]:GetName();
		table.insert(MANUALGROUPMEMBER,PLAYERNAME);

		logPlayers = logPlayers .. PLAYERNAME;
		if i ~= MANUALGROUPSIZE then logPlayers = logPlayers .. ", " end;

		if Windows.IsBlacklisted(PLAYERNAME) == true then
			if sBlacklisted == "" then
				sBlacklisted = PLAYERNAME;
			else
				sBlacklisted = sBlacklisted .. ", " .. PLAYERNAME;
			end
		end
	end

	Windows.RaidLog(3,logPlayers,MYNAME); -- TYPES: 1 = Roll; 2 = Item; 3 = Group

	if sBlacklisted ~= "" then
		tempMsg = MessageBox.Create(_LANG.MESSAGE02[SETTINGS.LANGUAGE] .. "\n" .. sBlacklisted);
	end

	if Windows.RollsFSlistBOX ~= nil then
		Windows.rolls_RefreshFSList();
	end

	if Windows.LootPlayerDropDown ~= nil then
		Windows.RefreshPlayerMenu();
	end

	if Windows.wMinShouts ~= nil then
		Windows.ShowMiniShouts();
		Windows.UpdateMiniShouts();
	end
end


function GroupAddManual(CHATMESSAGE)

	-- Name: Has joined or has left?
	i = string.find(CHATMESSAGE," ");

	local tempName = string.sub(CHATMESSAGE,0,(i-1));

	if Windows.IsBlacklisted(tempName) == true then
		tempMsg = MessageBox.Create(_LANG.MESSAGE03[SETTINGS.LANGUAGE] .. "\n" .. tempName);
	end

	local blExists = false;

	for k,v in pairs(MANUALGROUPMEMBER) do

		if v ==tempName then
			blExists = true;
			break;
		end
	end

	if blExists == false then
		-- add player
		table.insert(MANUALGROUPMEMBER,tempName);
		Windows.RaidLog(3,_LANG.LOGPLAYERJOIN[SETTINGS.LANGUAGE],tempName); -- TYPES: 1 = Roll; 2 = Item; 3 = Group
		MANUALGROUPSIZE = MANUALGROUPSIZE + 1;
	end

	--MANUALGROUPSIZE = MANUALGROUPSIZE + 1;

	Windows.rolls_RefreshFSList();
	Windows.RefreshPlayerMenu();

	if Windows.wMinShouts ~= nil then
		Windows.UpdateMiniShouts();
	end
end


function GroupRemoveManual(CHATMESSAGE)

	-- Name: Has joined or has left?
	i = string.find(CHATMESSAGE," ");

	local tempName = string.sub(CHATMESSAGE,0,(i-1));

	for k,v in pairs(MANUALGROUPMEMBER) do

		if v == tempName then
			table.remove(MANUALGROUPMEMBER,k);
			Windows.RaidLog(3,_LANG.LOGPLAYERLEAVE[SETTINGS.LANGUAGE],tempName); -- TYPES: 1 = Roll; 2 = Item; 3 = Group
			break;
		end
	end

	MANUALGROUPSIZE = MANUALGROUPSIZE - 1;

	if MANUALGROUPSIZE == 1 then -- no more fs.
		--Windows.RaidLog(3,_LANG.LOGPLAYERLEAVE[SETTINGS.LANGUAGE],MYNAME);
		LeftGroup();
	end;

	Windows.rolls_RefreshFSList();
	Windows.RefreshPlayerMenu();

	if Windows.wMinShouts ~= nil then
		Windows.UpdateMiniShouts();
	end
end


function NewLeader(CHATMESSAGE)

	-- DToX Start
	if SETTINGS.LANGUAGE == "RUSSIAN" then
		if (string.find(CHATMESSAGE, "Отныне")) then	-- Fellowship
			CHATMESSAGE = string.gsub(CHATMESSAGE, "Отныне ", "");	-- Remove all before name
		elseif (string.find(CHATMESSAGE, "возглавляете")) then	-- Raid and leader is 'you'
			CHATMESSAGE = "вы ";
		elseif (string.find(CHATMESSAGE, "возглавляет")) then	-- Raid and leader is another player
			CHATMESSAGE = string.gsub(CHATMESSAGE, "Теперь рейд возглавляет ", ""); -- Remove all before name
			CHATMESSAGE = string.gsub(CHATMESSAGE, "%.", " "); -- Replace '.' after name with ' '. For compatibility with the next code.
		end;
	end
	-- DToX End
	
	local i = string.find(CHATMESSAGE," ");
	local tempstring = string.sub(CHATMESSAGE,1,(i-1));

	if tempstring == _LANG.You[SETTINGS.LANGUAGE] then tempstring = MYCHAR:GetName() end;

	GROUPLEADER = tempstring;

	GAMessage(_LANG.MESSAGE04[SETTINGS.LANGUAGE] .. GROUPLEADER);

	Windows.RaidLog(3,_LANG.LOGNEWLEADER[SETTINGS.LANGUAGE],GROUPLEADER);

	Windows.rolls_RefreshFSList();

	if Windows.wMinShouts ~= nil then
		Windows.ShowMiniShouts();
		Windows.UpdateMiniShouts();
	end

end


function GetLeader()
	return GROUPLEADER;
end


function RATChange(MESSAGE)
	-- Was the person added or removed?
	local f = string.find(MESSAGE,_LANG.AddAssistTarg[SETTINGS.LANGUAGE]);
	local tempPlayer = string.sub(MESSAGE,1,(string.find(MESSAGE," ")-1));
	local tempMessage = "";

	if f ~= nil then -- Added raid assistant
		tempMessage = _LANG.LOGNEWRAT[SETTINGS.LANGUAGE];
	else -- Removed raid assistant
		tempMessage = _LANG.LOGREMRAT[SETTINGS.LANGUAGE];
	end

	Windows.RaidLog(3,tempMessage,tempPlayer);
end


function FSSkillChange(MESSAGE)

	local sa,fa = string.find(MESSAGE, _LANG.FSSKILL1[SETTINGS.LANGUAGE]);
	local sb,fb = string.find(MESSAGE, _LANG.FSSKILL2[SETTINGS.LANGUAGE]);

	-- DToX Start
	if SETTINGS.LANGUAGE == "RUSSIAN" then
		sb = string.find(MESSAGE, "%.");
	end
	-- DToX End
	
	local tempSkill = string.sub(MESSAGE, fa+1, sb-1);

	Windows.RaidLog(3,_LANG.FSSKILL1[SETTINGS.LANGUAGE] .. tempSkill,GROUPLEADER);
end
