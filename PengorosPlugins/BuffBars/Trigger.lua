import "Turbine.Gameplay";
import "PengorosPlugins.BuffBars";

Trigger = class();

function Trigger:Constructor(values)
    self.template = values.template;
    self.triggerType = values.triggerType; -- the type of trigger, effect or level for now
    self.name = values.name; -- the name of the trigger
    
    -- effect values
    self.category = values.category; -- effect category, can be nil for all
    self.isCurable = values.isCurable; -- is the effect curable
    self.match = values.match; -- name match string
    if (self.match == "") then
        self.match = nil;
    end
--	Obscurus	
--    if (self.match ~= nil) then
--    	self.match = self.match:lower(); -- store patterns in lowercase
--    end
    self.hasEffect = values.hasEffect; -- trigger matches if the effect is present or absent

    -- level values
    self.level = values.level; -- level power or morale
    self.threshold = values.threshold; -- type specific threshold, i.e. morale percent level
    
    -- response
    self.shortcutType = values.shortcutType;
    self.shortcutData = values.shortcutData;
    self.shortcuts = values.shortcuts;
    if (self.shortcuts == nil) then
        self.shortcuts = {};
    end
end

function Trigger:GetOptionName()
	if (not self:HasShortcut()) then
		return self.name .. " " .. L["(edit to set the shortcut)"]
	else
		local shortcut = self:GetShortcut();
		if (shortcut ~= nil) then
			-- display a name that identifies the shortcut
			local type = shortcut:GetType();
			if (type == Turbine.UI.Lotro.ShortcutType.Item) then
				local item = shortcut:GetItem();
				item._qty = 0;
				pcall(function()
					item._qty = item:GetQuantity();
	        	end);
				return self.name.." ("..item._qty.." "..L["items"]..")"; 
			elseif (type == Turbine.UI.Lotro.ShortcutType.Skill) then
				return self.name .. " " .. L["(skill)"]
			elseif (type == Turbine.UI.Lotro.ShortcutType.Alias) then
				return self.name .. " " .. L["(alias)"]
			elseif (type == Turbine.UI.Lotro.ShortcutType.Pet) then
				return self.name .. " " .. L["(pet)"]
			elseif (type == Turbine.UI.Lotro.ShortcutType.Hobby) then
				return self.name .. " " .. L["(hobby)"]
			end
		end
		return self.name;
	end
end

function Trigger:HasEffect()
    return self.hasEffect;
end

function Trigger:MatchesEffect(effect)
    if (self.category ~= nil and self.category ~= effect:GetCategory()) then
        return false;
    elseif (self.isCurable ~= nil and self.isCurable ~= effect:IsCurable()) then
        return false;
--	Obscurus
--	elseif (self.match ~= nil and string.match(effect:GetName():lower(), self.match) == nil) then
	elseif (self.match ~= nil and string.match(string.lower(effect:GetName()), string.lower(self.match)) == nil) then		
        return false;
    end
    
    return true;
end

function Trigger:MatchesLevel(level)
    if (self.threshold <= level) then
        return false;
    end
    
    return true;
end

function Trigger:MatchesLevelType(levelType)
    if (self.level ~= levelType) then
        return false;
    end

    return true;
end

function Trigger:HasShortcut()
    local name = PengorosPlugins.Utils.PlayerManager.GetPlayer():GetName();
    return self.shortcuts[name] ~= nil and self.shortcuts[name].shortcutData ~= nil;
end

function Trigger:GetShortcut()
    local name = PengorosPlugins.Utils.PlayerManager.GetPlayer():GetName();
    return Turbine.UI.Lotro.Shortcut(self.shortcuts[name] and self.shortcuts[name].shortcutType or nil, self.shortcuts[name] and self.shortcuts[name].shortcutData or nil);
end

function Trigger:GetShortcutType()
    local name = PengorosPlugins.Utils.PlayerManager.GetPlayer():GetName();
    return self.shortcuts[name] and self.shortcuts[name].shortcutType or nil;
end

function Trigger:GetShortcutData()
    local name = PengorosPlugins.Utils.PlayerManager.GetPlayer():GetName();
    return self.shortcuts[name] and self.shortcuts[name].shortcutData or nil;
end

function Trigger:SetShortcut(shortcut)
    local name = PengorosPlugins.Utils.PlayerManager.GetPlayer():GetName();
    self.shortcuts[name] = {};
    self.shortcuts[name].shortcutType = shortcut:GetType();
    self.shortcuts[name].shortcutData = shortcut:GetData();
end
