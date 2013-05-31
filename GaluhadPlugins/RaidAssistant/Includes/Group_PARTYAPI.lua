
-- AT THE MOMENT THIS ISN'T USED... HOPEFULLY IF THE PARTY API EVER GETS FIXED IT WILL
-- SERVER SOME PURPOSE.



-- GROUP GLOBALS
MANUALGROUPMEMBER = {};
MANUALGROUPSIZE = 0;



-- Functions called whenever the players 'Party' changes (usually when they join or leave a group)
MYCHAR.PartyChanged = function (sender, args)

	Turbine.Shell.WriteLine("call to: MYCHAR.PartyChanged = function (sender, args)");

	MYPARTY = MYCHAR:GetParty(); -- Get the new Party table

	if MYPARTY ~= nil then

		if MYPARTY:GetMemberCount() > 0 then

			JoinedGroup(); -- Call function to handle the joining of a group.

			-- Functions called whenever a member is added or leaves the party
			MYPARTY.MemberAdded = function (sender, args)
				GroupChanged();
			end


			MYPARTY.MemberRemoved = function (sender, args)
				GroupChanged();
			end

		else

			Turbine.Shell.WriteLine("MYPARTY ~= nil  < however >  MemberCount == 0");

			LeftGroup();

		end

	else

		LeftGroup();

	end

end



-- IS THIS USED??? ----------------------------------
MYCHAR.RaidChanged = function (sender, args)
	Turbine.Shell.WriteLine("\n\nRaid changed - if you get this message please let Galuhad know on LotroInterface explaining what happened when it appeared. Thanks\n\n");
	MYPARTY = MYCHAR:GetParty();
end





-- This function is called as the plugin loads to test for group
function GroupLoad()

	Turbine.Shell.WriteLine("call to: function GroupLoad()");

	if MYPARTY == nil then
		-- No group detected on load
		GAMessage(_LANG.MESSAGE15[SETTINGS.LANGUAGE]);
		GROUPSIZE = 0;

	else

		-- Group detected
		JoinedGroup();

	end

end


-- Function called when a group is first joined.
function JoinedGroup()

	Turbine.Shell.WriteLine("call to: function JoinedGroup()");

	Windows.StartLogging();
	GroupChanged();
	--ManualGroupJoin();
	if Windows.RollslistBOX ~= nil then Windows.RollslistBOX:ClearItems() end;
	_ROLLS = nil;
	GAMessage(_LANG.MESSAGE16[SETTINGS.LANGUAGE]);

end


-- Function called when the group size has changed (someone added or removed)
function GroupChanged()

	Turbine.Shell.WriteLine("call to: function GroupChanged()");

	if MYPARTY == nil or MYPARTY:GetMemberCount() == 0 then

		-- Not in a group
		GAMessage(_LANG.MESSAGE01[SETTINGS.LANGUAGE]);
		GROUPSIZE = 0;
		GROUPMEMBER = nil;
		MANUALGROUPMEMBER = nil;

	else

		GROUPSIZE = MYPARTY:GetMemberCount();

		GROUPMEMBER = nil;
		GROUPMEMBER = {};
		MANUALGROUPMEMBER = nil;
		MANUALGROUPMEMBER = {};

		local logPlayers = _LANG.LOGJOINED[SETTINGS.LANGUAGE] .. ": "	;

		for i=1, GROUPSIZE do

			GROUPMEMBER[i] = MYPARTY:GetMember(i);
			local PLAYERNAME = GROUPMEMBER[i]:GetName();
			table.insert(MANUALGROUPMEMBER,PLAYERNAME);

			logPlayers = logPlayers .. " " .. PLAYERNAME;

			if Windows.IsBlacklisted(PLAYERNAME) == true then
				-- Check if player is in _PARTYBLISTED table, if not add them and display warning message.

				if _PARTYBLISTED[1] == nil then -- table is empty
					tempMsg = MessageBox.Create(_LANG.MESSAGE02[SETTINGS.LANGUAGE] .. "\n" .. PLAYERNAME);
					table.insert(_PARTYBLISTED,PLAYERNAME);
				end

				for k,v in pairs (_PARTYBLISTED) do

					if v ~= PLAYERNAME then

						tempMsg = MessageBox.Create(_LANG.MESSAGE02[SETTINGS.LANGUAGE] .. "\n" .. PLAYERNAME);
						table.insert(_PARTYBLISTED,PLAYERNAME);

						Turbine.Shell.WriteLine(dump(_PARTYBLISTED));

					end

				end

			end

		end


		local PLAYERLEADER = MYPARTY:GetLeader();
		GROUPLEADER = PLAYERLEADER:GetName();

		Windows.RaidLog(3,logPlayers,MYNAME); -- TYPES: 1 = Roll; 2 = Item; 3 = Group

	end

	if Windows.RollsFSlistBOX ~= nil then
		Windows.rolls_RefreshFSList();
	end

	if Windows.LootPlayerDropDown ~= nil then
		Windows.RefreshPlayerMenu();
	end

end


function LeftGroup()

	Turbine.Shell.WriteLine("call to: function LeftGroup()");

	-- Not in a group
	GROUPSIZE = 0;
	GroupChanged();
	GROUPMEMBER = nil;

	MANUALGROUPMEMBER = {};
	MANUALGROUPSIZE = 0;

	_PARTYBLISTED = nil;
	_PARTYBLISTED = {};

	Windows.RaidLog(3,_LANG.LOGPLAYERLEAVE[SETTINGS.LANGUAGE],MYNAME);
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
end


function GetGroup()

	Turbine.Shell.WriteLine("call to: function GetGroup()");

	--return GROUPSIZE, GROUPMEMBER;
	return GROUPSIZE, MANUALGROUPMEMBER;

end


function NewLeader(CHATMESSAGE)

	local i = string.find(CHATMESSAGE," ");
	local tempstring = string.sub(CHATMESSAGE,1,(i-1));

	if tempstring == _LANG.You[SETTINGS.LANGUAGE] then tempstring = MYCHAR:GetName() end;

	GROUPLEADER = tempstring;

	GAMessage(_LANG.MESSAGE04[SETTINGS.LANGUAGE] .. GROUPLEADER);

	Windows.RaidLog(3,_LANG.LOGNEWLEADER[SETTINGS.LANGUAGE],GROUPLEADER);

	Windows.rolls_RefreshFSList();

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

	local tempSkill = string.sub(MESSAGE, fa+1, sb-1);

	Windows.RaidLog(3,_LANG.FSSKILL1[SETTINGS.LANGUAGE] .. tempSkill,GROUPLEADER);
end
