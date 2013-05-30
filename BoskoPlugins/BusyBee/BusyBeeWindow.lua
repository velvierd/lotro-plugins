--
-- Busy Bee Tasks plugin for Lord of The Rings Online
--
-- by Bosko
-- Patches:
-- Gardori
-- zonk
--
-- http://www.lotrointerface.com/downloads/fileinfo.php?id=733
--

import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Extensions";
import "Turbine.UI.Lotro";
import "BoskoPlugins.BusyBee.BusyBeeTasks"

--FIX for locale in saving routine (German version) using Vindarpatch
--inserted by zonk, note can be removed for next version
import "BoskoPlugins.BusyBee.Patch";
--FIX end

function writeln(str)
    Turbine.Shell.WriteLine("[BusyBee] " .. str);
end

function gettablestr(t, fExpandTable)
    str = "{ ";
    for k, v in pairs(t) do
    
        if fExpandTable and type(v) == "table" then
            str = str .. k .. " = " .. gettablestr(v, false) .. ", ";
        elseif type(v) == "string" then
            str = str .. k .. " = \"" .. v .. "\", ";
        elseif type(v) == "number" then
            str = str .. k .. " = " .. v .. ", ";
        elseif type(v) == "boolean" then
            if v then
                str = str .. k .. " = true, ";
            else
                str = str .. k .. " = false, ";
            end
        else
            mt = getmetatable(v);
            if mt == nil then
                str = str .. k .. " = ?(" .. type(v) .. "), ";
            else
                str = str .. k .. " = " .. type(v) .. " " .. gettablestr(mt) .. ", ";
            end
        end
    end
    
    return str .. "}";
end

function printtable(t)
    Turbine.Shell.WriteLine(gettablestr(t, true));
end

--==============================================================================
-- Settings
--==============================================================================

local BusyBeeSettingsVersion = 1.2;

local TurbineTaskCategory = 207;

local HeadingTextColor = Turbine.UI.Color(0.80, 0.80, 0.30);
local EntryTextColor   = Turbine.UI.Color(1.00, 1.00, 0.70);
local ItemLabelColor   = Turbine.UI.Color(0.40, 0.40, 0.40);

local clrLevelTooLow0  = Turbine.UI.Color(0.28, 0.28, 0.28);
local clrLevelTooLow1  = Turbine.UI.Color(0.41, 0.41, 0.41);
local clrLevelTooLow2  = Turbine.UI.Color(0.51, 0.55, 0.52);
local clrLevelInRange0 = Turbine.UI.Color(0.56, 0.51, 0.35);
local clrLevelInRange1 = Turbine.UI.Color(0.80, 0.80, 0.47);
local clrLevelInRange2 = Turbine.UI.Color(0.33, 0.80, 0.15);
local clrLevelTooHigh0 = Turbine.UI.Color(0.45, 0.31, 0.31);
local clrLevelTooHigh1 = Turbine.UI.Color(0.60, 0.40, 0.40);
local clrLevelTooHigh2 = Turbine.UI.Color(0.80, 0.52, 0.45);

local clrTextButton = Turbine.UI.Color(0.40, 0.40, 0.40);
local clrTextButtonMouseOver = Turbine.UI.Color(0.65, 0.65, 0.65);
local clrTextButtonMouseDown = Turbine.UI.Color(1.00, 1.00, 1.00);

local minWindowSize = {w = 250, h = 100 };

local headingWidth = 400;
local headingHeight = 16;
local entryHeight = 14;

local itemCtrlPos = {x = -18, y = -17, w = 32, h = 29 };

local windowOpacityActive = 1.0;
local windowOpacityPassive = 1.0;

local WindowColorParams = {base = 40.0, low = -8, high = 20, R = 0.0, G = 0.0, B = 0.0 };

local windowOriginalWidth = 415;
local windowOriginalHeight = 200;

local marginX = 10;
local marginTop = 5;
local marginBottom = 10;
local buttonWidth0 = 42;
local button01margin = 8;
local buttonWidth1 = 54;
local buttonWidth2 = 16;
local buttonHeight = 20;

local buttonFont = Turbine.UI.Lotro.Font.Verdana12;
local buttonFont2 = Turbine.UI.Lotro.Font.Verdana16;

local buttonWidthLock = 18;
local fileLockedIcon = "BoskoPlugins/Resources/locked18.tga";
local fileUnlockedIcon = "BoskoPlugins/Resources/unlocked18.tga";
local resizeBottomRightIcon = "BoskoPlugins/Resources/resizeBR20.tga";

local FactionNone = "(none)";

local lvlRangeTooLow = "Too Low";
local lvlRangeMyLevel = "My Level";
local lvlRangeTooHigh = "Too High";

--==============================================================================
-- Data Generation
--==============================================================================

--------------------------------------------------------------------------------
local function BusyBeeSortById(itemA, itemB)

    return itemA.id < itemB.id;
end

--------------------------------------------------------------------------------
local function BusyBeeSortByFullName(itemA, itemB)

    if itemA.fullname == itemB.fullname then
        if itemA.lvlmin == itemB.lvlmin then
            return itemA.lvlmax < itemB.lvlmax;
        else
            return itemA.lvlmin < itemB.lvlmin;
        end
    else
        return itemA.fullname < itemB.fullname;
    end
end

--------------------------------------------------------------------------------
local function BusyBeeSortByLevel(itemA, itemB)

    if itemA.lvlmin == itemB.lvlmin and itemA.lvlmax == itemB.lvlmax then
        return BusyBeeSortByFullName(itemA, itemB);
    else
        if itemA.lvlmin == itemB.lvlmin then
            return itemA.lvlmax < itemB.lvlmax;
        else
            return itemA.lvlmin < itemB.lvlmin;
        end
    end
end

--------------------------------------------------------------------------------
local function BusyBeeSortByLocation(itemA, itemB)

    if itemA.location == itemB.location then
        return BusyBeeSortByLevel(itemA, itemB);
    else
        return itemA.location < itemB.location;
    end
end

--------------------------------------------------------------------------------
local function BusyBeeSortByName(itemA, itemB)

    if itemA.fullname == itemB.fullname then
        return BusyBeeSortByLevel(itemA, itemB);
    else
        return itemA.fullname < itemB.fullname;
    end
end

--------------------------------------------------------------------------------
local function BusyBeeSortByFaction(itemA, itemB)

    if itemA.faction == itemB.faction then
        return BusyBeeSortByLevel(itemA, itemB);
    else
        return itemA.faction < itemB.faction;
    end
end

--------------------------------------------------------------------------------
local function BusyBeeBuildTreeDataByKey(key, fnSort)

    local list = { };
    local count = 0;
    local lastKey = nil;
    
    -- Sort by key
    table.sort(BusyBeeTasks, fnSort);
    
    -- valid key or global group
    if BusyBeeTasks[1][key] == nil then
        table.insert(list, {key = key, ids = {}});
        count = 1;
        key = nil;
    end
    
    -- Build list
    for i, item in ipairs(BusyBeeTasks) do
        if key ~= nil then
            local thisKey = item[key];
            if thisKey ~= lastKey then
                table.insert(list, {key = thisKey, ids = {}});
                count = count + 1;
                lastKey = thisKey;
            end
        end
        
        -- Add item information
        table.insert(list[count].ids, item.id);
    end
    
    -- Restore order of tasks
    table.sort(BusyBeeTasks, function(a,b) return a.id < b.id; end );
    
    -- Return list
    return list;
end

--------------------------------------------------------------------------------
function BusyBeeFixLevelRanges()
    local playerLevel = Turbine.Gameplay.LocalPlayer.GetInstance():GetLevel();
    
    for i, item in ipairs(BusyBeeTasks) do
        if item.lvlmax < playerLevel then
            item.lvlrange = 0;
            item.lvlrangetext = lvlRangeTooLow;
        elseif item.lvlmin > playerLevel then
            item.lvlrange = 2;
            item.lvlrangetext = lvlRangeTooHigh;
        else
            item.lvlrange = 1;
            item.lvlrangetext = lvlRangeMyLevel;
        end
    end
end

------------------------------------------------------------------------------
function BusyBeeSortByLevelRange(itemA, itemB)
    if itemA.lvlrange == itemB.lvlrange then
        return BusyBeeSortByLevel(itemA, itemB);
    else
        return itemA.lvlrange < itemB.lvlrange;
    end
end

--==============================================================================
-- Tree Data
--==============================================================================

-- Sort by item name
table.sort(BusyBeeTasks, BusyBeeSortByFullName);

for i, item in ipairs(BusyBeeTasks) do
    item.visible = true;
    item.nodes = { };
    item.location = item.zone .. " - " .. item.place;
	--FIX for items without prefix (German version)
	--inserted by zonk, note can be removed for next version
	if item.prefix == "" then
		item.fullname=item.name;
	else
		item.fullname = item.prefix .. " " .. item.name;
	end
	--FIX end
    if item.faction == "-" then
        item.faction = FactionNone;
    end
    
end

BusyBeeFixLevelRanges();

------------------------------------------------------------------------------
-- Build BusyBeeCounts
local BusyBeeCounts = { };
for i, item in ipairs(BusyBeeTasks) do
    local index = item.fullname;
    local tableItem = BusyBeeCounts[index];
    if (tableItem == nil) then
        -- Initialize the item
        BusyBeeCounts[index] = {count = 0, quantity = item.quantity, ids = {}, nodes = {}};
    end
    
    -- Add item information
    table.insert(BusyBeeCounts[index].ids, item.id);
end

------------------------------------------------------------------------------

local entryFont = Turbine.UI.Lotro.Font.Verdana12;

local BusyBeeTreeData = {
    { data = BusyBeeBuildTreeDataByKey("location", BusyBeeSortByLocation), 
        left = 0, fields = {
        { key = "level",  width = 50, alignment = "left" }, 
        { key = "fullname",  width = 124, alignment = "left" }, 
        { key = "count",  width = 60, alignment = "center" }, 
        { key = "faction",  width = 125, alignment = "left" }, 
    } },
    { data = BusyBeeBuildTreeDataByKey("faction", BusyBeeSortByFaction), 
        left = 0, fields = {
        { key = "level",  width = 50, alignment = "left" }, 
        { key = "fullname",  width = 124, alignment = "left" }, 
        { key = "count",  width = 60, alignment = "center" }, 
        { key = "location",  width = 165, alignment = "left" }, 
    } },
--     { data = BusyBeeBuildTreeDataByKey("lvlrangetext", BusyBeeSortByLevelRange), 
--         left = 0, fields = {
--         { key = "level",  width = 50, alignment = "left" }, 
--         { key = "fullname",  width = 124, alignment = "left" }, 
--         { key = "count",  width = 60, alignment = "center" }, 
--         { key = "faction",  width = 125, alignment = "left" }, 
--         { key = "location",  width = 165, alignment = "left" }, 
--     } },
--     { data = BusyBeeBuildTreeDataByKey("All Items (by Name)", BusyBeeSortByName), 
--         left = 0, fields = {
--         { key = "level",  width = 50, alignment = "left" }, 
--         { key = "fullname",  width = 124, alignment = "left" }, 
--         { key = "count",  width = 60, alignment = "center" }, 
--         { key = "faction",  width = 125, alignment = "left" }, 
--         { key = "location",  width = 165, alignment = "left" }, 
--     } },
    { data = BusyBeeBuildTreeDataByKey("fullname", BusyBeeSortByName), 
        left = 26, headerfields = {
        { key = "level",  width = 50, alignment = "left" }, 
        { key = "fullname",  width = 124, alignment = "left" }, 
        { key = "count",  width = 60, alignment = "center" }, 
        }, fields = {
        { key = "level",  width = 50, alignment = "left" }, 
        { key = "faction",  width = 125, alignment = "left" }, 
        { key = "location",  width = 165, alignment = "left" }, 
    } },
};


--==============================================================================
-- BusyBeeLabel
--==============================================================================
BusyBeeLabel = class(Turbine.UI.Label);

function BusyBeeLabel:Constructor(parent, x, w, h, alignment)
    Turbine.UI.Label.Constructor(self);
    
    -- Set the format
    self:SetParent(parent);
    self:SetPosition(x, 0);
    self:SetSize(w, h);
    self:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self:SetOutlineColor(Turbine.UI.Color(0.00, 0.00, 0.00));
    self:SetTextAlignment(alignment);
    self:SetForeColor(EntryTextColor);
    self:SetFont(entryFont);
end

--==============================================================================
-- BusyBeeHeading
--==============================================================================

BusyBeeHeading = class(Turbine.UI.TreeNode);

--------------------------------------------------------------------------------
function BusyBeeHeading:Constructor(szText)
    Turbine.UI.TreeNode.Constructor(self);
    
    self:SetSize(headingWidth, headingHeight);
    
    -- Create and format the heading label
    self.header = Turbine.UI.Label();
    self.header:SetParent(self);
    self.header:SetPosition(0, 0);
    self.header:SetSize(headingWidth, headingHeight);
    self.header:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.header:SetForeColor(HeadingTextColor);
    self.header:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.header:SetFont(Turbine.UI.Lotro.Font.TrajanPro15);
    self.header:SetText(szText);
end

--------------------------------------------------------------------------------
function BusyBeeHeading:GetMaxHeight()
    return headingHeight;
end

--------------------------------------------------------------------------------
function BusyBeeHeading:UpdateCount()
    -- noop
end

--------------------------------------------------------------------------------
function BusyBeeHeading:ShowIcon(fShow)
    -- noop
end

--==============================================================================
-- BusyBeeNode
--==============================================================================

BusyBeeNode = class(Turbine.UI.TreeNode);

--------------------------------------------------------------------------------
function BusyBeeNode:Constructor(item, left, fields)
    Turbine.UI.TreeNode.Constructor(self);
    
    self.item = item;
    self.left = left;
    self.fields = fields;
    self.countField = nil;
    self.levelField = nil;
    self.fShowIcon = false;
    
    -- Full name and quantity are fixed values
    self.quantity = self:GetField(item, "quantity");
    self.fullname = self:GetField(item, "fullname");
    
    -- Create item control
    if left == 0 then
        self.itemCtrl = Turbine.UI.Lotro.ItemControl();
        self.itemCtrl:SetVisible(true);
        self.itemCtrl:SetParent(self);
        
        self.itemCtrl:SetPosition(left, 0);
        self.itemCtrl:SetSize(0, 0);
        self.itemCtrl:SetMouseVisible(true);
    end
    
    -- Create and populate the labels
    local nFields = 0;
    for i, desc in ipairs(fields) do
        nFields = nFields + 1;
        
        -- Identify alignment
        alignment = Turbine.UI.ContentAlignment.MiddleCenter;
        if (desc.alignment == "left") then
            alignment = Turbine.UI.ContentAlignment.MiddleLeft;
        elseif (desc.alignment == "right") then
            alignment = Turbine.UI.ContentAlignment.MiddleRight;
        end
        
        -- Create the label and fill the text
        self["field" .. nFields] = BusyBeeLabel(self, left, desc.width, entryHeight, alignment);
        self["field" .. nFields]:SetText(self:FormatText(desc.key));
        left = left + desc.width;
        
        -- Remember which field is "count"
        if desc.key == "count" then
            self.countField = nFields;
        end
        if desc.key == "level" then
            self.levelField = nFields;
        end
    end
    
--     if item.ids then
--         for i, desc in ipairs(self.fields) do
--             self["field" .. i]:SetFont(Turbine.UI.Lotro.Font.Verdana12);
--         end
--     end
    
    -- Set the size and update the count
    self:SetSize(left, self:GetMaxHeight());
end

--------------------------------------------------------------------------------
function BusyBeeNode:GetField(item, field)
    local value = item[field];
    if (value == nil) then
        local n = 0;
        for i, id in ipairs(item.ids) do
            local item2 = BusyBeeTasks[id];
            if item2.visible then
                n = n + 1;
                if (n == 1) then
                    -- First field
                    value = item2[field];
                elseif n == 2 then
                    if value ~= item2[field] then
                        -- Different field, mark as such
                        value = "multiple " .. field .. "s";
                    else
                        -- Same field as before
                        n = 1;
                    end
                end
            end
        end
    end
    
    if value == nil then
        value = "???";
    end
    return value;
end

--------------------------------------------------------------------------------
function BusyBeeNode:GetFieldRange(item, field)
    local minValue = item[field];
    local maxValue = item[field];
    if (minValue == nil) then
        minValue = 0;
        maxValue = 0;
        local n = 0;
        for i, id in ipairs(item.ids) do
            local item2 = BusyBeeTasks[id];
            if item2.visible then
                n = n + 1;
                if (n == 1) then
                    minValue = item2[field];
                    maxValue = item2[field];
                else
                    if (minValue > item2[field]) then
                        minValue = item2[field];
                    elseif (maxValue < item2[field]) then
                        maxValue = item2[field];
                    end
                end
            end
        end
    end
    return minValue, maxValue;
end


--------------------------------------------------------------------------------
function BusyBeeNode:FormatText(field)

    local id = self.item.id;
    if id == nil then
        if type(self.item.ids) ~= "table" then
            return "";
        end
        id = self.item.ids[1];
    end
    
    if (field == "level") then
        local min1, max1 = self:GetFieldRange(self.item, "lvlmin");
        local min2, max2 = self:GetFieldRange(self.item, "lvlmax");
        return string.format("[%d-%d]", min1, max2);
    elseif (field == "fullname") then
        return self.fullname;
    elseif (field == "count") then
        return "";
    elseif (field == "sellvalue") then
        return string.format("%.2f", BusyBeeTasks[id].sellvalue);
    else
        return self:GetField(self.item, field);
    end
end

--------------------------------------------------------------------------------
function BusyBeeNode:UpdateCount()
    local lvlMin, lvlMax2 = self:GetFieldRange(self.item, "lvlmin");
    local lvlMin2, lvlMax = self:GetFieldRange(self.item, "lvlmax");
    local lvlrangemin, lvlrangemax = self:GetFieldRange(self.item, "lvlrange");
    local lvlrange = 1;
    count = BusyBeeCounts[self.fullname].count;
    quantity = BusyBeeCounts[self.fullname].quantity;
    
    if lvlrangemin == lvlrangemax then
        lvlrange = lvlrangemin;
    end
    
    local clr = clrLevelInRange0;
    
    if self.countField ~= nil then
        self["field" .. self.countField]:SetText(count .. "/" .. quantity);
    end
    
    if self.levelField ~= nil then
        self["field" .. self.levelField]:SetText("[" .. lvlMin .. "-" .. lvlMax .. "]");
    end
    
    if lvlrange == 0 then
        if count == 0 then
            clr = clrLevelTooLow0;
        elseif count < quantity then
            clr = clrLevelTooLow1;
        else
            clr = clrLevelTooLow2;
        end
    elseif lvlrange == 2 then
        if count == 0 then
            clr = clrLevelTooHigh0;
        elseif count < quantity then
            clr = clrLevelTooHigh1;
        else
            clr = clrLevelTooHigh2;
        end
    else
        if count == 0 then
            clr = clrLevelInRange0;
        elseif count < quantity then
            clr = clrLevelInRange1;
        else
            clr = clrLevelInRange2;
        end
    end
    
    for i, desc in ipairs(self.fields) do
        self["field" .. i]:SetForeColor(clr);
    end
end

--------------------------------------------------------------------------------
function BusyBeeNode:FixVisibility()
    local oldHeight = self:GetHeight();
    local height = 0;
    local parentNode = self:GetParentNode();
    if parentNode ~= nil then
        
        for i, desc in ipairs(self.fields) do
            if i ~= self.countField then
                self["field" .. i]:SetText(self:FormatText(desc.key));
            end
        end
        
        if self.item.id ~= nil then
            if BusyBeeTasks[self.item.id].visible then
                height = self:GetMaxHeight();
            end
        else
            for i, id in ipairs(self.item.ids) do
                if BusyBeeTasks[id].visible then
                    height = self:GetMaxHeight();
                end
            end
        end
        
        if oldHeight ~= height then
            self:SetHeight(height);
            
            local childNodes = parentNode:GetChildNodes();
            local fFound = 0;
            for j = 1,childNodes:GetCount(), 1 do
                local subItem = childNodes:Get(j);
                if 0 < subItem:GetHeight() then
                    fFound = 1;
                    break;
                end
            end
            parentNode:SetHeight(parentNode:GetMaxHeight() * fFound);
        end
    else
        self:UpdateCount();
    end
end

--------------------------------------------------------------------------------
function BusyBeeNode:FixItemCtrl(backpack)
    local itemBeingRemoved = nil;    
    if self.itemCtrl ~= nil then
        local itemOld = self.itemCtrl:GetItem();
        
        if BusyBeeCounts[self.fullname].count > 0 then
            -- find the best item
            local backpackSize = backpack:GetSize();
            local bestItem = nil;
            for i = 1, backpackSize, 1 do
                local item = backpack:GetItem(i);
                if item ~= nil and item ~= itemBeingRemoved and item:GetName() == self.fullname then
                    if bestItem == nil or bestItem:GetQuantity() < item:GetQuantity() then
                        bestItem = item;
                    end
                end
            end
            
            self.itemCtrl:SetItem(bestItem);
            if itemOld == nil then
                self:FixLayout();
            end
        else
            self.itemCtrl:SetItem(nil);
            if itemOld ~= nil then
                self:FixLayout();
            end
        end
    end
end

--------------------------------------------------------------------------------
function BusyBeeNode:GetMaxHeight()
    local height = entryHeight;
--     if self.item.ids then
--         height = headingHeight;
--     end
    if (self.itemCtrl ~= nil and self.fShowIcon 
        and self.itemCtrl:GetItem() ~= nil 
        and self.itemCtrl:GetItem():GetQuantity() > 0) then
        height = math.max(height, itemCtrlPos.y + itemCtrlPos.h);
    end
    
    return height;
end

--------------------------------------------------------------------------------
function BusyBeeNode:ShowIcon(fShow)

    if self.fShowIcon ~= fShow then
        self.fShowIcon = fShow;
        self:FixLayout();
    end
end


--------------------------------------------------------------------------------
function BusyBeeNode:FixLayout()

    local left = self.left;
    local height = self:GetMaxHeight();
    local oldHeight = self:GetHeight();
    
    if self.itemCtrl ~= nil then
        self.itemCtrl:SetPosition(left, 0);
        
        -- Show or hide item control
        if self.fShowIcon then
            if (self.itemCtrl:GetItem() ~= nil and self.itemCtrl:GetItem():GetQuantity() > 0) then
            self.itemCtrl:SetPosition(left + itemCtrlPos.x, itemCtrlPos.y);
                self.itemCtrl:SetSize(itemCtrlPos.w, itemCtrlPos.h);
                height = self:GetMaxHeight();
            else
                self.itemCtrl:SetSize(0, 0);
            end
            left = left + itemCtrlPos.x + itemCtrlPos.w + 2;
        else
            self.itemCtrl:SetSize(0, 0);
        end
        
--         self.itemCtrl:SetBackColor(ItemLabelColor);
    end
    
    -- Move the labels
    for i, desc in ipairs(self.fields) do
        -- Create the label and fill the text
        self["field" .. i]:SetPosition(left, 0);
        self["field" .. i]:SetSize(desc.width, height);
        left = left + desc.width;
    end
    
    self:SetWidth(left);
    if oldHeight > 0 then
        self:SetHeight(height);
    end
end

--==============================================================================
-- BusyBeeTree
--==============================================================================
BusyBeeTree = class(Turbine.UI.Control);

--------------------------------------------------------------------------------
function BusyBeeTree:Constructor(items, left, headerfields, fields)
    Turbine.UI.Control.Constructor(self);
    
    -- Create tree view
    self.treeView = Turbine.UI.TreeView();
    self.treeView:SetParent(self);

    -- Create tree view scrollbar
    self.scrollBar = Turbine.UI.Lotro.ScrollBar();
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.scrollBar:SetParent(self);
    self.treeView:SetVerticalScrollBar(self.scrollBar);

    -- Populate the tree view
    local level1 = self.treeView:GetNodes();
    
    for i, value in ipairs(items) do
        local heading = nil;
        if headerfields == nil then
            heading = BusyBeeHeading(value.key);
        else
            heading = BusyBeeNode(value, 0, headerfields);
            table.insert(BusyBeeCounts[heading.fullname].nodes, heading);
        end
        level1:Add(heading);
        local level2 = heading:GetChildNodes();
        for j, id in ipairs(value.ids) do
            local item = BusyBeeTasks[id];
            local node = BusyBeeNode(item, left, fields);
            level2:Add(node);
            table.insert(BusyBeeCounts[BusyBeeTasks[id].fullname].nodes, node);
            table.insert(BusyBeeTasks[id].nodes, node);
            if headerfields ~= nil then
                table.insert(BusyBeeTasks[id].nodes, heading);
            end
        end
    end
    
    self.SizeChanged = function(sender, args)
        sender:FixLayout();
    end
end

--------------------------------------------------------------------------------
function BusyBeeTree:GetState()

    -- Compute state
    local level1 = self.treeView:GetNodes();
    local treeState = 0;
    for i = 1,level1:GetCount(), 1 do
        local item = level1:Get(i);
        local level2 = item:GetChildNodes();
        local subItem = level2:Get(1);
        treeState = 2 * treeState;
        if subItem:IsVisible() then
            treeState = treeState + 1;
        end
    end
    
    return treeState;
end

--------------------------------------------------------------------------------
function BusyBeeTree:RestoreState(treeState)

    -- Restore tree state (expand appropriate nodes)
    local level1 = self.treeView:GetNodes();
    for i = level1:GetCount(), 1, -1 do
        if (treeState % 2 ~= 0) then
            local item = level1:Get(i);
            item:SetExpanded(true);
            treeState = treeState - 1;
        end
        treeState = treeState / 2;
    end
end

--------------------------------------------------------------------------------
function BusyBeeTree:FixLayout()
    self:Layout({ });
end

--------------------------------------------------------------------------------
function BusyBeeTree:Layout(args)
    local left, top = self:GetPosition();
    local width, height = self:GetSize();
    local scrollWidth = 10;
    
    self.scrollBar:SetPosition(width - scrollWidth, 0);
    self.scrollBar:SetSize(scrollWidth, height);
    self.treeView:SetPosition(0, 0);
    self.treeView:SetSize(width - scrollWidth, height);
end

--------------------------------------------------------------------------------
function BusyBeeTree:ExpandAll()
    self.treeView:ExpandAll();
end

--------------------------------------------------------------------------------
function BusyBeeTree:CollapseAll()
    self.treeView:CollapseAll();
end

--------------------------------------------------------------------------------
function BusyBeeTree:GetSubTreeHeight(childNodes)
    local totalHeight = 0;
    for i = childNodes:GetCount(), 1, -1 do
        local childNode = childNodes:Get(i);
        local childHeight = childNode:GetHeight();
        if childNode:IsExpanded() and childNode:GetChildNodes() then
            childHeight = childHeight + self:GetSubTreeHeight(childNode:GetChildNodes());
        end
        
        totalHeight = totalHeight + childHeight;
    end
    
    return totalHeight;
end

--------------------------------------------------------------------------------
function BusyBeeTree:ShowIcons(fShow)

    local level1 = self.treeView:GetNodes();
    for i = 1, level1:GetCount(), 1 do
        local childNode = level1:Get(i);
        childNode:ShowIcon(fShow);
        local level2 = childNode:GetChildNodes();
        for i = 1, level2:GetCount(), 1 do
            local childNode2 = level2:Get(i);
            childNode2:ShowIcon(fShow);
        end
    end
end

--------------------------------------------------------------------------------
function BusyBeeTree:ShowScrollBar(show)

    -- Only show the scrollbar if 
    if show then
        local totalHeight = self:GetSubTreeHeight(self.treeView:GetNodes());
        local height = self:GetHeight();
        if height < totalHeight then
            self.scrollBar:SetVisible(true);
        end
    else
        self.scrollBar:SetVisible(false);
    end
    
end

--==============================================================================
-- BusyBeeWindow
--==============================================================================
BusyBeeWindow = class(Turbine.UI.Window);

--------------------------------------------------------------------------------
function BusyBeeWindow:Constructor()
    Turbine.UI.Window.Constructor(self);

    self:LoadSettings();

    self.dragging = false;
    
    -- Position the window in top-center
    self:SetSize(self.settings.windowWidth, self.settings.windowHeight);
    self:SetBackColor(Turbine.UI.Color(0.0, 
        WindowColorParams.R, WindowColorParams.G, WindowColorParams.B));
    self:SetPosition(self.settings.windowLeft, self.settings.windowTop);
    self:SetText("Busy Bee Tasks");
    self:SetMouseVisible(true);

    -- Set up mouse-triggered fade
--     self:SetFadeSpeed(0.4);
    self:SetPassiveOpacity(self.settings.passiveOpacity);
    self:SetZOrder(-1);
    self.bkOpacity = 0;
    self.targetBkOpacity = self.bkOpacity;
    self.Update = function(sender, args)
--         writeln(self.bkOpacity .. "->" .. self.targetBkOpacity);
        if self.bkOpacity == self.targetBkOpacity then
            self:SetWantsUpdates(false);
        elseif self.bkOpacity < self.targetBkOpacity then
            self.bkOpacity = self.bkOpacity + 1;
            if self.bkOpacity > 0 then
                self:SetBackColor(Turbine.UI.Color(self.bkOpacity / WindowColorParams.base, 
                    WindowColorParams.R, WindowColorParams.G, WindowColorParams.B));
            end
        elseif self.bkOpacity > self.targetBkOpacity then
            self.bkOpacity = self.bkOpacity - 1;
            self:SetBackColor(Turbine.UI.Color(self.bkOpacity / WindowColorParams.base, 
                WindowColorParams.R, WindowColorParams.G, WindowColorParams.B));
        end
    end
    
    self.MouseEnter = function(sender, args)
        if not self.dragging then
            self:FadeIn();
            if not self.isLocked then
                local bkOpacity = math.floor(WindowColorParams.base * self:GetBackColor().A);
                if bkOpacity == 0 then
                    bkOpacity = WindowColorParams.low;
                end
                self.bkOpacity = bkOpacity;
                self.targetBkOpacity = WindowColorParams.high;
                self:SetWantsUpdates(true);
            end
        end
    end

    self.MouseLeave = function(sender, args)
        if not self.dragging then
            self:FadeOut();
            if not self.isLocked then
                local bkOpacity = math.floor(WindowColorParams.base * self:GetBackColor().A);
                if bkOpacity > 0 then
                    self.targetBkOpacity = 0;
                    self:SetWantsUpdates(true);
                else
                    self.bkOpacity = 0;
                    self:SetWantsUpdates(false);
                end
            end
            self:SaveSettings();
        end
    end

    self.player = Turbine.Gameplay.LocalPlayer.GetInstance();
    self.backpack = self.player:GetBackpack();

    local mainWindow = self;
    
    -- Level change handler
     self.player.LevelChanged = function(sender, args)
        BusyBeeFixLevelRanges();
        --TODO: Rebuild 'by level' tree
        for k, v in pairs(BusyBeeCounts) do
            for i, node in ipairs(v.nodes) do
                node:UpdateCount();
            end
        end
        self:UpdateAllTasks();
    end

    -- Button-related states
    self.fShowButtons = false;
    self.nShowCount = self.settings.nShowCount;
    self.fShowAllLevels = self.settings.fShowAllLevels;
    self.fShowRepAward = self.settings.fShowRepAward;
    self.fShowIcons = self.settings.fShowIcons;
    
    -- Create mode button
    self.ModeButton = Turbine.UI.Lotro.Button();
    self.ModeButton:SetParent(self);
    self.ModeButton:SetFont(buttonFont);
    self.ModeButton:SetText("Next");
    self.ModeButton.Click = function(sender, args)
        local fNextTree = false;
        for i, tree in ipairs(mainWindow.trees) do
            if fNextTree then
                tree:SetVisible(true);
                fNextTree = false;
            elseif tree:IsVisible() then
                tree:SetVisible(false);
                fNextTree = true;
            end
        end
        if fNextTree then
            mainWindow.trees[1]:SetVisible(true);
        end
    end
    
--     -- Create menu items
--     contextMenu = Turbine.UI.ContextMenu();
--     
--     -- Populate the menu with some items.
--     menuItems = contextMenu:GetItems();
--     menuItems:Add(Turbine.UI.MenuItem("Show Icon"));
--     menuItems:Add(Turbine.UI.MenuItem(nil));
--     menuItems:Add(Turbine.UI.MenuItem( "By Location"));
--     menuItems:Add(Turbine.UI.MenuItem( "By Faction"));
--     menuItems:Add(Turbine.UI.MenuItem( "By Name"));
--     
--     -- Register event handlers with all the menu items.
--     local i;
--     
--     -- Register an event handler to display what menu item was clicked
--     -- in the chat window.
--     for i = 1, menuItems:GetCount() do
--         local menuItem = menuItems:Get( i );
--         
--         menuItem.Click = function( sender, args )
--             Turbine.Shell.WriteLine( "You have selected " .. sender:GetText() .. "." );
--         end
--     end
    
    -- Create show icon toggle button
    self.ShowIconButton = Turbine.UI.Lotro.Button();
    self.ShowIconButton:SetParent(self);
    self.ShowIconButton:SetFont(buttonFont);
    self.ShowIconButton:SetText("Icon");
    self.ShowIconButton.Click = function(sender, args)
        mainWindow.fShowIcons = not mainWindow.fShowIcons;
        mainWindow:ShowIcons();
        mainWindow:PerformLayout();
        
--         -- Display the menu at the current mouse location.
--         contextMenu:ShowMenu();
    end
    
    -- Create item count toggle button
    self.ItemCountButton = Turbine.UI.Lotro.GoldButton();
    self.ItemCountButton:SetParent(self);
    self.ItemCountButton:SetFont(buttonFont);
    self.ItemCountButton.Click = function(sender, args)
        mainWindow.nShowCount = (mainWindow.nShowCount + 1) % 3;
        mainWindow:UpdateAllTasks();
        mainWindow:PerformLayout();
    end
    
    -- Create level eligibility toggle button
    self.AllLevelsButton = Turbine.UI.Lotro.GoldButton();
    self.AllLevelsButton:SetParent(self);
    self.AllLevelsButton:SetFont(buttonFont);
    self.AllLevelsButton.Click = function(sender, args)
        mainWindow.fShowAllLevels = not mainWindow.fShowAllLevels;
        mainWindow:UpdateAllTasks();
        mainWindow:PerformLayout();
    end
    
    -- Create reputation award toggle button
    self.RepAwardButton = Turbine.UI.Lotro.GoldButton();
    self.RepAwardButton:SetParent(self);
    self.RepAwardButton:SetFont(buttonFont);
    self.RepAwardButton.Click = function(sender, args)
        mainWindow.fShowRepAward = not mainWindow.fShowRepAward;
        mainWindow:UpdateAllTasks();
        mainWindow:PerformLayout();
    end
    
    -- Create 'Expand All' button
    self.ExpandButton = Turbine.UI.Button();
    self.ExpandButton:SetParent(self);
    self.ExpandButton:SetFont(buttonFont2);
    self.ExpandButton:SetText("+");
    self.ExpandButton:SetForeColor(clrTextButton);
    self.ExpandButton.Click = function(sender, args)
        for i, tree in ipairs(self.trees) do
            if tree:IsVisible() then
                tree:ExpandAll();
            end
        end
    end
    self.ExpandButton.MouseEnter = function(sender, args)
        sender.over = true;
        sender:SetForeColor(clrTextButtonMouseOver);
    end
    self.ExpandButton.MouseLeave = function(sender, args)
        sender.over = false;
        sender:SetForeColor(clrTextButton);
    end
    self.ExpandButton.MouseDown = function(sender, args)
        sender:SetForeColor(clrTextButtonMouseDown);
    end
    self.ExpandButton.MouseUp = function(sender, args)
        if sender.over then
            sender:SetForeColor(clrTextButtonMouseOver);
        else
            sender:SetForeColor(clrTextButton);
        end
    end
    
    -- Create 'Collapse All' button
    self.CollapseButton = Turbine.UI.Button();
    self.CollapseButton:SetParent(self);
    self.CollapseButton:SetFont(buttonFont2);
    self.CollapseButton:SetText("-");
    self.CollapseButton:SetForeColor(clrTextButton);
    self.CollapseButton.Click = function(sender, args)
        for i, tree in ipairs(self.trees) do
            if tree:IsVisible() then
                tree:CollapseAll();
            end
        end
    end
    self.CollapseButton.MouseEnter = function(sender, args)
        sender.over = true;
        sender:SetForeColor(clrTextButtonMouseOver);
    end
    self.CollapseButton.MouseLeave = function(sender, args)
        sender.over = false;
        sender:SetForeColor(clrTextButton);
    end
    self.CollapseButton.MouseDown = function(sender, args)
        sender:SetForeColor(clrTextButtonMouseDown);
    end
    self.CollapseButton.MouseUp = function(sender, args)
        if sender.over then
            sender:SetForeColor(clrTextButtonMouseOver);
        else
            sender:SetForeColor(clrTextButton);
        end
    end

    -- Create 'Lock' button
    self.LockButton = Turbine.UI.Button();
    self.LockButton:SetParent(self);
    self.LockButton:SetBackground(fileUnlockedIcon);
    self.isLocked = false;
    self.LockButton:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.LockButton.Click = function(sender, args)
        self:SetLocked();
        self:SaveSettings();
    end

    -- Create the resize handle and set up the resize behavior
    self.resizeHandle = Turbine.UI.Control();
    self.resizeHandle:SetParent(self);
    self.resizeHandle:SetZOrder(100);
    self.resizeHandle:SetSize(20, 20);
    self.resizeHandle:SetBackground(resizeBottomRightIcon);
    self.resizeHandle:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.resizeHandle:SetPosition(self:GetWidth() - self.resizeHandle:GetWidth(), 
        self:GetHeight() - self.resizeHandle:GetHeight());

    self.resizeHandle.MouseDown = function(sender, args)
        if not self.isLocked then
            sender.dragStartX = args.X;
            sender.dragStartY = args.Y;
            self.dragging = true;
        end
    end

    self.resizeHandle.MouseMove = function(sender, args)
        local width, height = self:GetSize();
        if (self.dragging) then
            local newWidth = math.max(minWindowSize.w, width + (args.X - sender.dragStartX));
            local newHeight = math.max(minWindowSize.h, height + (args.Y - sender.dragStartY));
            self:SetSize(newWidth, newHeight);
            sender:SetPosition(self:GetWidth() - self.resizeHandle:GetWidth(), 
                self:GetHeight() - self.resizeHandle:GetHeight())
            self:PerformLayout();
        end
    end

    self.resizeHandle.MouseUp = function(sender, args)
        self.dragging = false;
    end

    -- Setup the window move behavior
    self.MouseDown = function(sender, args)
        if not self.isLocked then
            sender.dragStartX = args.X;
            sender.dragStartY = args.Y;
            self.dragging = true;
        end
    end

    self.MouseMove = function(sender, args)
        local width, height = mainWindow:GetSize();

        if (sender.dragging) then
            sender:SetPosition(mainWindow:GetLeft() + (args.X - sender.dragStartX), 
                mainWindow:GetTop() + (args.Y - sender.dragStartY));
            mainWindow:PerformLayout();
        end
    end

    self.MouseUp = function(sender, args)
        self.dragging = false;
    end

    -- Set up QuantityChanged callbacks for all items
    local backpackSize = self.backpack:GetSize();
    for j = 1, backpackSize, 1 do
        local item = self.backpack:GetItem(j);
        if item and item.QuantityChanged == nil then
            item.QuantityChanged = function(sender, args)
                if item:GetCategory() == TurbineTaskCategory then
                    mainWindow:UpdateCount(item:GetName());
                end
            end
        end
    end

    -- Backpack size changed should almost never happen
    self.backpack.SizeChanged = function(sender, args)
        -- Set up QuantityChanged callbacks for all items
        local backpackSize = self.backpack:GetSize();
        for j = 1, backpackSize, 1 do
            local item = self.backpack:GetItem(j);
            if item and item.QuantityChanged == nil then
                item.QuantityChanged = function(sender, args)
                    if item:GetCategory() == TurbineTaskCategory then
                        mainWindow:UpdateCount(item:GetName());
                    end
                end
            end
        end
    end

    -- Refresh list on backpack item added event
    self.backpack.ItemAdded = function(sender, args)
        local item = self.backpack:GetItem(args.Index);
        if item:GetCategory() == TurbineTaskCategory then
            mainWindow:UpdateCount(item:GetName());
        end
        -- Restore QuantityChanged event -- not sure if this is needed
        if item.QuantityChanged == nil then
            item.QuantityChanged = function(sender, args)
                if item:GetCategory() == TurbineTaskCategory then
                    mainWindow:UpdateCount(item:GetName());
                end
            end
        end
    end

    -- Refresh list on backpack item removed event
    self.backpack.ItemRemoved = function(sender, args)
        local item = self.backpack:GetItem(args.Index);
        if item:GetCategory() == TurbineTaskCategory then
            		itemBeingRemoved = item;
		mainWindow:UpdateCount(item:GetName(), item:GetQuantity());
        		itemBeingRemoved = nil;
	end
    end

    -- Create the trees
    self.trees = { };
    self.nOfTrees = 0;
    for i, item in ipairs(BusyBeeTreeData) do
        self.nOfTrees = self.nOfTrees + 1;
        self.trees[self.nOfTrees] = BusyBeeTree(item.data, item.left, 
            item.headerfields, item.fields);
        self.trees[self.nOfTrees]:SetParent(self);
        self.trees[self.nOfTrees]:SetVisible(self.settings.visibleTree == self.nOfTrees);
        if self.settings.treeStates ~= nil and self.settings.treeStates[self.nOfTrees] then
            self.trees[self.nOfTrees]:RestoreState(self.settings.treeStates[self.nOfTrees]);
        end
    end
    if self.settings.visibleTree < 1 or self.settings.visibleTree > self.nOfTrees then
        self.trees[1]:SetVisible(true);
    end
    
    -- Update counts
    for k, v in pairs(BusyBeeCounts) do
        for i, node in ipairs(v.nodes) do
            node:UpdateCount();
        end
    end
    
    -- Create the item count label
    self.itemLabel = Turbine.UI.Label();
    self.itemLabel:SetParent(self);
    self.itemLabel:SetPosition(10, 10);
    self.itemLabel:SetSize(200, 20);
    self.itemLabel:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.itemLabel:SetForeColor(ItemLabelColor);
    self.itemLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.itemLabel:SetFont(entryFont);
    self.itemLabelText = "";
    self.itemLabel:SetMouseVisible(false);
    
    self:SetLocked(self.settings.isLocked);
    self.showFullItemLabel = false;
    self:ShowIcons();
    self:UpdateAllTasks();
    self:UpdateCount();
    self:PerformLayout();
end

--------------------------------------------------------------------------------
function BusyBeeWindow:FadeIn()
    if not self.isLocked then
        self:SetOpacity(windowOpacityActive);
        self.fShowButtons = true;
--         self.resizeHandle:SetVisible(true);
    else
        self.showFullItemLabel = true;
    end
    for i, tree in ipairs(self.trees) do
        tree:ShowScrollBar(true);
    end
    self:PerformLayout();
end

--------------------------------------------------------------------------------
function BusyBeeWindow:FadeOut()
    if self.isLocked then
        self.showFullItemLabel = false;
    end
    self:SetOpacity(windowOpacityPassive);
    self.fShowButtons = false;
    for i, tree in ipairs(self.trees) do
        tree:ShowScrollBar(false);
    end
--     self.resizeHandle:SetVisible(false);
    self:PerformLayout();
    self:SaveSettings();
end

--------------------------------------------------------------------------------
function BusyBeeWindow:ShowIcons()
    for i, tree in ipairs(self.trees) do
        tree:ShowIcons(self.fShowIcons);
        tree:SetSize(listWidth, listHeight);
    end
    
end

--------------------------------------------------------------------------------
function BusyBeeWindow:Sort()
    local backpackSize = self.backpack:GetSize();
    local first = 1;
    local size = self.backpack:GetSize();
    
    -- Count how many task items
    local nTaskItems = 0;
    for i = 1, size, 1 do
        local item = self.backpack:GetItem(i);
        if item ~= nil and item:GetCategory() == TurbineTaskCategory then
            nTaskItems = nTaskItems + 1;
        end
    end
    
    writeln(string.format("Task Items: %d", nTaskItems));
    
    -- Clear out the last N items
    first = size - nTaskItems;
    for i = size, size - nTaskItems + 1, -1 do
        local item = self.backpack:GetItem(i);
        if item ~= nil and item:GetCategory() ~= TurbineTaskCategory then
            local item2 = self.backpack:GetItem(first);
            while item2 ~= nil and item2:GetCategory() ~= TurbineTaskCategory do
                first = first - 1;
                item2 = self.backpack:GetItem(first);
            end
            
            writeln(string.format("Moving: %s(%d) to %d", item:GetName(), i, first));
            self.backpack:PerformItemDrop(item, first, false);
            first = first - 1;
        end
    end
    
    first = size - nTaskItems + 1;
    for i = 1, size - nTaskItems, 1 do
        local item = self.backpack:GetItem(i);
        if item ~= nil and item:GetCategory() == TurbineTaskCategory then
            local item2 = self.backpack:GetItem(first);
            while item2 ~= nil and item2:GetCategory() == TurbineTaskCategory do
                first = first + 1;
                item2 = self.backpack:GetItem(first);
            end
            
            writeln(string.format("Moving: %s(%d) to %d", item:GetName(), i, first));
            self.backpack:PerformItemDrop(item, first, false);
            first = first + 1;
        end
    end
end

--------------------------------------------------------------------------------
function BusyBeeWindow:SetLocked(fLocked)

    -- There is only something to do if setting to a different value
    if fLocked == self.isLocked then
        return;
    end
    
    -- Flip the locked value
    self.isLocked = not self.isLocked;
    
    -- Change the appearance
    if self.isLocked then
        self.LockButton:SetBackground(fileLockedIcon);
        self:SetOpacity(windowOpacityPassive);
        self:SetBackColor(Turbine.UI.Color(0.0, 
            WindowColorParams.R, WindowColorParams.G, WindowColorParams.B));
        self.showFullItemLabel = true;
    else
        self.LockButton:SetBackground(fileUnlockedIcon);
        self:SetOpacity(windowOpacityActive);
        self:SetBackColor(Turbine.UI.Color(WindowColorParams.high / WindowColorParams.base, 
            WindowColorParams.R, WindowColorParams.G, WindowColorParams.B));
        self.showFullItemLabel = false;
    end
    
    -- Show/hide buttons
    self.fShowButtons = not self.isLocked;
    
    -- Enable or disable resizing
    self.resizeHandle:SetMouseVisible(not self.isLocked);
    
    -- Hide the main window from the mouse (tree can still be manipulated)
    self:SetMouseVisible(not self.isLocked);
    
    -- Update the layout
    self:PerformLayout();
end

--------------------------------------------------------------------------------
function BusyBeeWindow:SetPassiveOpacity(opacity)
    windowOpacityPassive = opacity;
    self:SetOpacity(windowOpacityPassive);
end

--------------------------------------------------------------------------------
function BusyBeeWindow:UpdateVisibility(item, fForceUpdate)

    local fChanged = false;
    
    if item == nil then
        for i, item2 in ipairs(BusyBeeTasks) do
            local fChanged2 = self:UpdateVisibility(item2, true);
            fChanged = fChanged or fChanged2;
        end
    elseif item.id == nil then
        for i, id in ipairs(item.ids) do
            local fChanged2 = self:UpdateVisibility(BusyBeeTasks[id]);
            fChanged = fChanged or fChanged2;
        end
    else
        local isVisible = true;
        if self.nShowCount == 2 and BusyBeeCounts[item.fullname].count < BusyBeeCounts[item.fullname].quantity then
            isVisible = false;
        elseif self.nShowCount == 1 and BusyBeeCounts[item.fullname].count == 0 then
            isVisible = false;
        elseif not self.fShowAllLevels and item.lvlrange ~= 1 then
            isVisible = false;
        elseif self.fShowRepAward and item.faction == FactionNone then
            isVisible = false;
        end
        
        if fForceUpdate or isVisible ~= item.visible then
            fChanged = true;
            item.visible = isVisible;
            for i, node in ipairs(item.nodes) do
                node:FixVisibility();
            end
        end
    end
    
    return fChanged;
end

--------------------------------------------------------------------------------
function BusyBeeWindow:PrintJunkItems()

    local backpackSize = self.backpack:GetSize();
    local fJunkItems = false;
    
    -- List task items not used for any tasks
    for i = 1, backpackSize, 1 do
        local item = self.backpack:GetItem(i);
        if (item ~= nil and item:GetCategory() == TurbineTaskCategory 
            and BusyBeeCounts[item:GetName()] == nil) then
            fJunkItems = true;
            writeln(string.format("Item %s(%d) is not used for any tasks", 
                item:GetName(), item:GetQuantity()));
        end
    end
    
    -- List task items that do not award any rep
    for i = 1, backpackSize, 1 do
        local item = self.backpack:GetItem(i);
        if (item ~= nil and BusyBeeCounts[item:GetName()] ~= nil) then
            local fRepAward = false;
            for j, id in ipairs(BusyBeeCounts[item:GetName()].ids) do
                fRepAward = fRepAward or (BusyBeeTasks[id].faction ~= FactionNone);
            end
            if not fRepAward then
                fJunkItems = true;
                writeln(string.format("Item %s(%d) is only used on tasks with no rep", 
                    item:GetName(), item:GetQuantity()));
            end
        end
    end
    
    if not fJunkItems then
        writeln("No junk items found.");
    end
end

--------------------------------------------------------------------------------
function BusyBeeWindow:UpdateCount(itemName, delta)

    local backpackSize = self.backpack:GetSize();
    local fVisibilityChanged = false;
    
    -- Recalculate backpack contents
    local counts = { };
    for i = 1, backpackSize, 1 do
        local item = self.backpack:GetItem(i);
        if item ~= nil and BusyBeeCounts[item:GetName()] ~= nil then
            if counts[item:GetName()] == nil then
                if itemName == item:GetName() and delta then
                    counts[item:GetName()] = item:GetQuantity() - delta;
                else
                    counts[item:GetName()] = item:GetQuantity();
                end
            else
                counts[item:GetName()] = counts[item:GetName()] + item:GetQuantity();
            end
        end
    end
    
    for key, value in pairs(BusyBeeCounts) do
        if itemName == nil or itemName == key then
            local count = 0;
            if counts[key] ~= nil then
                count = counts[key];
            end
            
            if BusyBeeCounts[key].count ~= count then

                -- Output items to turn in
--              if BusyBeeCounts[key].count < BusyBeeCounts[key].quantity and count >= BusyBeeCounts[key].quantity then
--                  for i, id in ipairs(BusyBeeCounts[key].ids) do
--                      if BusyBeeTasks[id].lvlrange == 1 then
--                          if BusyBeeTasks[id].faction ~= FactionNone then
--                              Turbine.Shell.WriteLine(string.format("[BusyBee] %s(%d) can be turned in at %s for %s.",
--                                  key, BusyBeeCounts[key].quantity, BusyBeeTasks[id].location, BusyBeeTasks[id].faction));
--                          else
--                              Turbine.Shell.WriteLine(string.format("[BusyBee] %s(%d) can be turned in at %s.",
--                                  key, BusyBeeCounts[key].quantity, BusyBeeTasks[id].location));
--                          end
--                      end
--                  end
--              end
                BusyBeeCounts[key].count = count;
                
                for i, node in ipairs(BusyBeeCounts[key].nodes) do
                    node:UpdateCount();
                    node:FixItemCtrl(self.backpack);
                end
                
                local fVisibilityChanged2 = self:UpdateVisibility(BusyBeeCounts[key]);
                fVisibilityChanged = fVisibilityChanged or fVisibilityChanged2;
                
            end
        end
    end
    
    if fVisibilityChanged then
        self:UpdateItemLabel();
        self:PerformLayout();
    end
end

--------------------------------------------------------------------------------
function BusyBeeWindow:UpdateItemLabel()
    local nVisible = 0;
    for key, value in pairs(BusyBeeCounts) do
        local fVisible = 0;
        for i, id in ipairs(value.ids) do
            if BusyBeeTasks[id].visible then
                fVisible = 1;
                break;
            end
        end
        nVisible = nVisible + fVisible;
    end
    if nVisible == 0 then
        self.itemLabelText = "No busy bee items";
    elseif nVisible == 1 then
        self.itemLabelText = nVisible .. " unique busy bee item";
    else
        self.itemLabelText = nVisible .. " unique busy bee items";
    end
end

--------------------------------------------------------------------------------
function BusyBeeWindow:UpdateAllTasks()
    for i, item in pairs(BusyBeeTasks) do
        local isVisible = true;
        if self.nShowCount == 2 and BusyBeeCounts[item.fullname].count < BusyBeeCounts[item.fullname].quantity then
            isVisible = false;
        elseif self.nShowCount == 1 and BusyBeeCounts[item.fullname].count == 0 then
            isVisible = false;
        elseif not self.fShowAllLevels and item.lvlrange ~= 1 then
            isVisible = false;
        elseif self.fShowRepAward and item.faction == FactionNone then
            isVisible = false;
        end
        
        if isVisible ~= item.visible then
            item.visible = isVisible;
            for i, node in ipairs(item.nodes) do
                node:FixVisibility();
            end
        end
    end
    
    self:UpdateItemLabel();
end

--------------------------------------------------------------------------------
function BusyBeeWindow:PerformLayout()
    self:Layout({ })
end

--------------------------------------------------------------------------------
function BusyBeeWindow:Layout(args)
    local width, height = self:GetSize();
    
    -- Determine filter text
    local filterCountText = "Cnt > N";
    if self.nShowCount == 0 then
        filterCountText = "All Cnt";
    elseif self.nShowCount == 1 then
        filterCountText = "Cnt > 0";
    end
    
    local filterLevelText = "My Lvl";
    if self.fShowAllLevels then
        filterLevelText = "All Lvl";
    end
    
    local filterRepText = "All Rep";
    if self.fShowRepAward then
        filterRepText = "Rep > 0";
    end
    
    local buttonLeft = marginX;
    if self.isLocked or self.fShowButtons then
        self.LockButton:SetPosition(buttonLeft, marginTop);
        self.LockButton:SetSize(buttonWidthLock, buttonHeight);
        buttonLeft = buttonLeft + buttonWidthLock;
    end
    
    -- Position the buttons
    if self.fShowButtons then
        self.ShowIconButton:SetPosition(buttonLeft, marginTop);
        self.ShowIconButton:SetSize(buttonWidth0, buttonHeight);
        buttonLeft = buttonLeft + buttonWidth0;
        self.ModeButton:SetPosition(buttonLeft, marginTop);
        self.ModeButton:SetSize(buttonWidth0, buttonHeight);
        buttonLeft = buttonLeft + buttonWidth0 + button01margin;
        self.ItemCountButton:SetPosition(buttonLeft, marginTop);
        self.ItemCountButton:SetSize(buttonWidth1, buttonHeight);
        buttonLeft = buttonLeft + buttonWidth1;
        self.AllLevelsButton:SetPosition(buttonLeft, marginTop);
        self.AllLevelsButton:SetSize(buttonWidth1, buttonHeight);
        buttonLeft = buttonLeft + buttonWidth1;
        self.RepAwardButton:SetPosition(buttonLeft, marginTop);
        self.RepAwardButton:SetSize(buttonWidth1, buttonHeight);
        buttonLeft = buttonLeft + buttonWidth1;
        
        if (buttonLeft < width - marginX - 2 * buttonWidth2) then
            buttonLeft = width - marginX - 2 * buttonWidth2;
        end
        
        self.ExpandButton:SetPosition(buttonLeft, marginTop);
        self.ExpandButton:SetSize(buttonWidth2, buttonHeight);
        buttonLeft = buttonLeft + buttonWidth2;
        self.CollapseButton:SetPosition(buttonLeft, marginTop);
        self.CollapseButton:SetSize(buttonWidth2, buttonHeight);
        buttonLeft = buttonLeft + buttonWidth2;
        
        -- Set button text
        self.ItemCountButton:SetText(filterCountText);
        self.AllLevelsButton:SetText(filterLevelText);
        self.RepAwardButton:SetText(filterRepText);
--         self.ShowIconButton:SetText(showIconText);
        
    else
        self.itemLabel:SetPosition(buttonLeft, marginTop);
        self.itemLabel:SetSize(600, buttonHeight);
        if self.showFullItemLabel then
            self.itemLabel:SetText(self.itemLabelText .. 
                string.lower(string.format(" (%s, %s, %s)",
                 filterCountText, filterLevelText, filterRepText)));
        else
            self.itemLabel:SetText(self.itemLabelText);
        end
    end
    
    -- Show or hide the buttons
    self.LockButton:SetVisible(self.isLocked or self.fShowButtons);
    self.ModeButton:SetVisible(self.fShowButtons);
    self.ItemCountButton:SetVisible(self.fShowButtons);
    self.AllLevelsButton:SetVisible(self.fShowButtons);
    self.RepAwardButton:SetVisible(self.fShowButtons);
    self.ShowIconButton:SetVisible(self.fShowButtons);
    self.ExpandButton:SetVisible(self.fShowButtons);
    self.CollapseButton:SetVisible(self.fShowButtons);
    self.itemLabel:SetVisible(not self.fShowButtons);
    self.resizeHandle:SetVisible(self.fShowButtons);
    
    -- Position the tree views
    local listTop = marginTop + buttonHeight;
    local listWidth = width - 2 * marginX;
    local listHeight = height - listTop - marginBottom;
    for i, tree in ipairs(self.trees) do
        tree:SetPosition(marginX, listTop);
        tree:SetSize(listWidth, listHeight);
    end
    
end

--------------------------------------------------------------------------------
function BusyBeeWindow:LoadSettings()
    --FIX for locale in saving routine (German version) using Vindarpatch
	--inserted by zonk, note can be removed for next version
	self.settings = BoskoPlugins.BusyBee.PatchDataLoad(Turbine.DataScope.Character, "BusyBeeSettings");
	--FIX end
    if (type(self.settings) ~= "table"  or self.settings.version ~= BusyBeeSettingsVersion) then
        self.settings = { };
        self.settings.version = BusyBeeSettingsVersion;
        self.settings.windowTop = 0;
        self.settings.windowLeft = (Turbine.UI.Display.GetWidth() - windowOriginalWidth) / 2;
        self.settings.windowWidth = windowOriginalWidth;
        self.settings.windowHeight = windowOriginalHeight;
        self.settings.passiveOpacity = windowOpacityPassive;
        self.settings.treeStates = { 0, 0, 0 };
        self.settings.visibleTree = 1;
        self.settings.isLocked = false;
        self.settings.nShowCount = 0;
        self.settings.fShowAllLevels = false;
        self.settings.fShowRepAward = false;
        self.settings.fShowIcons = false;
        Turbine.Shell.WriteLine("[BusyBee] Busy Bee Tasks initialized.");
    else
        windowOpacityPassive = self.settings.passiveOpacity;
        Turbine.Shell.WriteLine("[BusyBee] Busy Bee Tasks loaded.");
    end
    
    if self.settings.windowLeft + self.settings.windowWidth > Turbine.UI.Display.GetWidth() then
        self.settings.windowLeft = Turbine.UI.Display.GetWidth() - self.settings.windowWidth;
    end
    if self.settings.windowTop + self.settings.windowHeight > Turbine.UI.Display.GetHeight() then
        self.settings.windowTop = Turbine.UI.Display.GetHeight() - self.settings.windowHeight;
    end
end

--------------------------------------------------------------------------------
function BusyBeeWindow:SaveSettings()
    local width, height = self:GetSize();
    local left, top = self:GetPosition();
    
    local visibleTree = 1;
    treeStates = { };
    for i, tree in ipairs(self.trees) do
        if tree:IsVisible() then
            visibleTree = i;
        end
        treeStates[i] = tree:GetState();
    end

    if (self.settings.windowTop ~= top or
        self.settings.windowLeft ~= left or
        self.settings.windowWidth ~= width or
        self.settings.windowHeight ~= height or
        self.settings.passiveOpacity ~= windowOpacityPassive or
        self.settings.treeStates ~= treeStates or
        self.settings.visibleTree ~= visibleTree or
        self.settings.isLocked ~= self.isLocked or
        self.settings.nShowCount ~= self.nShowCount or
        self.settings.fShowAllLevels ~= self.fShowAllLevels or
        self.settings.fShowRepAward ~= self.fShowRepAward or
        self.settings.fShowIcons ~= self.fShowIcons) then
        
        self.settings.windowTop = top;
        self.settings.windowLeft = left;
        self.settings.windowWidth = width;
        self.settings.windowHeight = height;
        self.settings.passiveOpacity = windowOpacityPassive;
        self.settings.treeStates = treeStates;
        self.settings.visibleTree = visibleTree;
        self.settings.isLocked = self.isLocked;
        self.settings.nShowCount = self.nShowCount;
        self.settings.fShowAllLevels = self.fShowAllLevels;
        self.settings.fShowRepAward = self.fShowRepAward;
        self.settings.fShowIcons = self.fShowIcons;
        
        --FIX for locale in saving routine (German version) using Vindarpatch
		--inserted by zonk, note can be removed for next version
		BoskoPlugins.BusyBee.PatchDataSave(Turbine.DataScope.Character, "BusyBeeSettings", self.settings);
		--FIX end
--         Turbine.Shell.WriteLine("[BusyBee] Busy Bee Tasks saved.");
    end
end
