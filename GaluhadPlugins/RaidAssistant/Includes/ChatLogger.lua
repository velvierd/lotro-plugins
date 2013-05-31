
-- Chat log filter.
-- Controls chat messages and actions the appropriate functions based on the message.

function InitiateChatLogger()

	CHATLOG.Received = function (sender, args)

		local tempMessage = tostring(args.Message);

		-- 36 (loot self)
		if args.ChatType == 36 then
			FilterSelfLoot(tempMessage);
			return;
		end

		-- 37 (loot fellow)
		if args.ChatType == 37 then
			FilterFellowLoot(tempMessage);
			return;
		end



		if args.ChatType == Turbine.ChatType.Combat then
			FilterCombat(tempMessage);
			return;
		end

		if args.ChatType == Turbine.ChatType.Standard then
			FilterStandard(tempMessage);
			return;
		end

		if args.ChatType == Turbine.ChatType.Quest then
			FilterQuest(tempMessage);
			return;
		end

		if args.ChatType == Turbine.ChatType.Fellowship then
			FilterFellowship(tempMessage);
			return;
		end

	end

end


function FilterSelfLoot(cMessage)
-- Filters here for use with the loof (self) channel.
	if SETTINGS.LOOT.SELF_ENABLED == true and ( string.find(cMessage,(_LANG.acquired[SETTINGS.LANGUAGE])) or string.find(cMessage,(_LANG.acquiredGermanFS[SETTINGS.LANGUAGE])) ) then	-- DToX; Plugin default: _LANG.acquiredGermanFS["GERMAN"]
		Windows.ItemLog(cMessage);
	end
end


function FilterFellowLoot(cMessage)
-- Filters here for use with the loof (fellow) channel.
	if SETTINGS.LOOT.FELLOW_ENABLED == true then
		Windows.ItemLog(cMessage);
	end
end


function FilterCombat(cMessage)
-- Filters here for use with the combat channel.

end


function FilterStandard(cMessage)
-- Filters here for use with the Standard channel.

	a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y = nil;
	
	-- DToX Start
	if SETTINGS.LANGUAGE == "RUSSIAN" then -- For compatibility. We have U8, not U10.
		t = string.find(cMessage,(_LANG.acquired[SETTINGS.LANGUAGE]));
		u = string.find(cMessage,(_LANG.acquiredGermanFS[SETTINGS.LANGUAGE]));

		if t ~= nil or u ~= nil then
			if (SETTINGS.LOOT.SELF_ENABLED == true) or (SETTINGS.LOOT.FELLOW_ENABLED == true) then
				Windows.ItemLog(cMessage);
				return;
			end
		end
	end
	-- DToX End

	-- ROLLS ------------------------------------------------------------
	-- Check string for rolls.
	a = string.find(cMessage,(" " .. _LANG.rolled[SETTINGS.LANGUAGE]));

	if a ~= nil then
		Windows.ChatRolls(cMessage); -- 'Rolled' was found so perform function.
		return;
	end

	-- JOINED GROUP -----------------------------------------------------
	-- Check for message saying YOU have joined a group
	b = string.find(cMessage,(_LANG.joinedFS[SETTINGS.LANGUAGE]));
	c = string.find(cMessage,(_LANG.joinedRA[SETTINGS.LANGUAGE]));

	if b ~= nil or c ~= nil then
		JoinedGroup()-- Joined group message found.
		return;
	end

	-- LEFT GROUP -----------------------------------------------------
	-- Check for message saying YOU have left a group
	d = string.find(cMessage,(_LANG.leftFS[SETTINGS.LANGUAGE]));
	e = string.find(cMessage,(_LANG.leftRA[SETTINGS.LANGUAGE]));
	f = string.find(cMessage,(_LANG.dismissFS[SETTINGS.LANGUAGE]));
	g = string.find(cMessage,(_LANG.dismissRA[SETTINGS.LANGUAGE]));
	h = string.find(cMessage,(_LANG.disbandFS[SETTINGS.LANGUAGE]));
	i = string.find(cMessage,(_LANG.disbandRA[SETTINGS.LANGUAGE]));
	j = string.find(cMessage,(_LANG.dismissGrp[SETTINGS.LANGUAGE]));

	if d ~= nil or e ~= nil or f ~= nil or g ~= nil or h ~= nil or i ~= nil or j ~= nil then
		LeftGroup();-- Left group message found.
		return;
	end

	-- MEMBER JOINS/LEAVES GROUP -----------------------------------------
	-- Check for messages of another person joining or leaving the group
	k = string.find(cMessage,(_LANG.playerleftFS[SETTINGS.LANGUAGE]));
	l = string.find(cMessage,(_LANG.playerleftRA[SETTINGS.LANGUAGE]));
	m = string.find(cMessage,(_LANG.playerjoinFS[SETTINGS.LANGUAGE]));
	n = string.find(cMessage,(_LANG.playerjoinRA[SETTINGS.LANGUAGE]));
	o = string.find(cMessage,(_LANG.playerdismiss[SETTINGS.LANGUAGE]));
	p = string.find(cMessage,(_LANG.playerDismissedFS[SETTINGS.LANGUAGE]));
	q = string.find(cMessage,(_LANG.playerDismissedRA[SETTINGS.LANGUAGE]));

	if k ~= nil or l ~= nil or m ~= nil or n ~= nil or o ~= nil or p ~= nil or q ~= nil then
	--	GroupChanged(); --message found.
	end

	if m ~= nil or n ~= nil then
		GroupAddManual(cMessage); --message found.
		return;
	end

	if k ~= nil or l ~= nil or o ~= nil or p ~= nil or q ~= nil then
		GroupRemoveManual(cMessage); --message found.
		return;
	end


	-- FILTER FOR WHEN LOOT RULE CHANGES -------------------------------
	r = string.find(cMessage,(_LANG.LootRule[SETTINGS.LANGUAGE]));
	s = string.find(cMessage,(_LANG.LootQuality[SETTINGS.LANGUAGE]));
	if r ~= nil or s ~= nil then
		Windows.ChangeRules(cMessage);
		return;
	end

	-- FILTER FOR WHEN THE RAID/FS LEADER CHANGES ------------------------
	v = string.find(cMessage,(_LANG.newFSleader[SETTINGS.LANGUAGE]));
	w = string.find(cMessage,(_LANG.newRAleader[SETTINGS.LANGUAGE]));
	if v ~= nil or w ~= nil then
		NewLeader(cMessage);
		return;
	end

	-- FILTER FOR WHEN THE ASSIST TARGET CHANGES ------------------------
	x = string.find(cMessage,(_LANG.AddAssistTarg[SETTINGS.LANGUAGE]));
	y = string.find(cMessage,(_LANG.RemAssistTarg[SETTINGS.LANGUAGE]));
	if x ~= nil or y ~= nil then
		RATChange(cMessage);
		return;
	end

end


function FilterQuest(cMessage)
-- Filters here for use with the Quest channel.



end



function FilterFellowship(cMessage)
-- Filters here for use with the Fellowship channel.

	a,b = nil;

	-- FILTER FOR WHEN THE FELLOWSHIP SKILL CHANGES --------------------- MAY BE FELLOWSHIP CHANNEL.
	a = string.find(cMessage,(_LANG.FSSKILL1[SETTINGS.LANGUAGE]));
	b = string.find(cMessage,(_LANG.FSSKILL2[SETTINGS.LANGUAGE]));
	if a ~= nil or b ~= nil then
		FSSkillChange(cMessage);
		return;
	end

end


function DisectMessage(MESSAGESTRING)

	-- This function splits up the message to find hidden coding.
	local msgLEN = string.len(MESSAGESTRING);
	local OUTPUTSTRING = "";

	for i=1, msgLEN do
		OUTPUTSTRING = OUTPUTSTRING .. string.sub(MESSAGESTRING,i,i) .. " ";
	end

	Turbine.Shell.WriteLine(OUTPUTSTRING);

end
