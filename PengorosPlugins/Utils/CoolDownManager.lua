import "Turbine.Gameplay";
import "PengorosPlugins.Utils";

CoolDownManager = {};

-- listeners
CoolDownManager.listeners = {};

-- create the pots
CoolDownManager.activePots = {};
CoolDownManager.pots = 
{
    Pot(L["Morale"], CoolDownCategory.Morale, 120, {L["Concentrated Essence of Athelas"], L["Distilled Athelas Essence"], L["Distilled Athelas Extract"], L["Elixir of Twice Purified Athelas"], L["Enhanced Essence of Athelas"], L["Greater Athelas Essence"], L["Greater Athelas Extract"], L["Infused Athelas Essence"], L["Infused Athelas Extract"], L["Lesser Athelas Essence"], L["Lesser Athelas Extract"], L["Potent Athelas Essence"], L["Pure Athelas Essence"], L["Pure Athelas Extract"], L["Refined Athelas Essence"], L["Refined Athelas Extract"], L["Simple Athelas Essence"], L["Simple Athelas Extract"], L["Steeped Athelas Essence"], L["Westfold Athelas Essence"], L["Rohirric Athelas Essence"], L["Eastemnet Athelas Essence"], L["Riddermark Athelas Essence"]}),
    Pot(L["Power"], CoolDownCategory.Power, 120, {L["Distilled Celebrant Ointment"], L["Distilled Celebrant Salve"], L["Elixir of Twice Purified Celebrant"], L["Greater Celebrant Ointment"], L["Greater Celebrant Salve"], L["Infused Celebrant Ointment"], L["Infused Celebrant Salve"], L["Lesser Celebrant Ointment"], L["Lesser Celebrant Salve"], L["Potent Celebrant Salve"], L["Pure Celebrant Ointment"], L["Pure Celebrant Salve"], L["Refined Celebrant Ointment"], L["Refined Celebrant Salve"], L["Simple Celebrant Ointment"], L["Simple Celebrant Salve"], L["Steeped Celebrant Salve"], L["Westfold Celebrant Salve"], L["Rohirric Celebrant Salve"], L["Eastemnet Celebrant Salve"], L["Riddermark Celebrant Salve"]}),
    Pot(L["Disease"], CoolDownCategory.Disease, 30, {L["Brewed Flask of Lhinestad"], L["Brewed Salve of Lhinestad"], L["Distilled Lhinestad Draught"], L["Distilled Lhinestad Salve"], L["Flask of Lhinestad"], L["Greater Lhinestad Draught"], L["Greater Lhinestad Salve"], L["Infused Lhinestad Draught"], L["Infused Lhinestad Salve"], L["Lesser Lhinestad Draught"], L["Lesser Lhinestad Salve"], L["Pure Flask of Lhinestad"], L["Pure Salve of Lhinestad"], L["Refined Lhinestad Draught"], L["Refined Lhinestad Salve"], L["Salve of Lhinestad"], L["Simple Lhinestad Draught"], L["Simple Lhinestad Salve"], L["Steeped Lhinestad Draught"], L["Steeped Lhinestad Salve"], L["Dunland Lhinestad Draught"], L["Dunland Lhinestad Salve"], L["Eastemnet Lhinestad Draught"], L["Eastemnet Lhinestad Salve"]}),
    Pot(L["Fear"], CoolDownCategory.Fear, 30, {L["Brewed Flask of Conhuith"], L["Brewed Salve of Conhuith"], L["Distilled Conhuith Draught"], L["Distilled Conhuith Salve"], L["Flask of Conhuith"], L["Greater Conhuith Draught"], L["Greater Conhuith Salve"], L["Infused Conhuith Draught"], L["Infused Conhuith Salve"], L["Lesser Conhuith Draught"], L["Lesser Conhuith Salve"], L["Pure Flask of Conhuith"], L["Pure Salve of Conhuith"], L["Refined Conhuith Draught"], L["Refined Conhuith Salve"], L["Salve of Conhuith"], L["Simple Conhuith Draught"], L["Simple Conhuith Salve"], L["Steeped Conhuith Draught"], L["Steeped Conhuith Salve"], L["Dunland Conhuith Draught"], L["Dunland Conhuith Salve"], L["Eastemnet Conhuith Draught"], L["Eastemnet Conhuith Salve"]}),
    Pot(L["Poison"], CoolDownCategory.Poison, 30, {L["Brewed Milkthistle Draught"], L["Brewed Milkthistle Salve"], L["Distilled Milkthistle Draught"], L["Distilled Milkthistle Salve"], L["Greater Milkthistle Draught"], L["Greater Milkthistle Salve"], L["Infused Milkthistle Draught"], L["Infused Milkthistle Salve"], L["Lesser Milkthistle Draught"], L["Lesser Milkthistle Salve"], L["Milkthistle Draught"], L["Milkthistle Salve"], L["Pure Milkthistle Draught"], L["Pure Milkthistle Salve"], L["Refined Milkthistle Draught"], L["Refined Milkthistle Salve"], L["Simple Milkthistle Draught"], L["Simple Milkthistle Salve"], L["Steeped Milkthistle Draught"], L["Steeped Milkthistle Salve"], L["Dunland Milkthistle Draught"], L["Dunland Milkthistle Salve"], L["Eastemnet Milkthistle Draught"], L["Eastemnet Milkthistle Salve"]}),
    Pot(L["Wound"], CoolDownCategory.Wound, 30, {L["Brewed Healing Draught"], L["Brewed Healing Salve"], L["Distilled Healing Draught"], L["Distilled Healing Salve"], L["Greater Healing Draught"], L["Greater Healing Salve"], L["Healing Draught"], L["Healing Salve"], L["Infused Healing Draught"], L["Infused Healing Salve"], L["Lesser Healing Draught"], L["Lesser Healing Salve"], L["Pure Healing Draught"], L["Pure Healing Salve"], L["Refined Healing Draught"], L["Refined Healing Salve"], L["Simple Healing Draught"], L["Simple Healing Salve"], L["Steeped Healing Draught"], L["Steeped Healing Salve"], L["Dunland Healing Draught"], L["Dunland Healing Salve"], L["Eastemnet Healing Draught"], L["Eastemnet Healing Salve"]}),
    Pot(L["Morale (Store)"], CoolDownCategory.Morale, 20, {L["Morale Potion (Tier 1)"], L["Morale Potion (Tier 2)"], L["Morale Potion (Tier 3)"], L["Morale Potion (Tier 4)"], L["Morale Potion (Tier 5)"], L["Morale Potion (Tier 6)"], L["Morale Potion (Tier 7)"], L["Morale Potion (Tier 7a)"], L["Morale Potion (Tier 8)"]}),
    Pot(L["Power (Store)"], CoolDownCategory.Power, 20, {L["Power Potion (Tier 1)"], L["Power Potion (Tier 2)"], L["Power Potion (Tier 3)"], L["Power Potion (Tier 4)"], L["Power Potion (Tier 5)"], L["Power Potion (Tier 6)"], L["Power Potion (Tier 7)"], L["Power Potion (Tier 7a)"], L["Power Potion (Tier 8)"]}),
    Pot(L["Disease (Store)"], CoolDownCategory.Disease, 30, {L["Disease Remedy (Lvl 10)"], L["Disease Remedy (Lvl 20)"], L["Disease Remedy (Lvl 30)"], L["Disease Remedy (Lvl 40)"], L["Disease Remedy (Lvl 50)"], L["Disease Remedy (Lvl 60)"]}),
    Pot(L["Fear (Store)"], CoolDownCategory.Fear, 30, {L["Fear Remedy (Lvl 10)"], L["Fear Remedy (Lvl 20)"], L["Fear Remedy (Lvl 30)"], L["Fear Remedy (Lvl 40)"], L["Fear Remedy (Lvl 50)"], L["Fear Remedy (Lvl 60)"]}),
    Pot(L["Poison (Store)"], CoolDownCategory.Poison, 30, {L["Poison Remedy (Lvl 10)"], L["Poison Remedy (Lvl 20)"], L["Poison Remedy (Lvl 30)"], L["Poison Remedy (Lvl 40)"], L["Poison Remedy (Lvl 50)"], L["Poison Remedy (Lvl 60)"]}),
    Pot(L["Wound (Store)"], CoolDownCategory.Wound, 30, {L["Wound Remedy (Lvl 10)"], L["Wound Remedy (Lvl 20)"], L["Wound Remedy (Lvl 30)"], L["Wound Remedy (Lvl 40)"], L["Wound Remedy (Lvl 50)"], L["Wound Remedy (Lvl 60)"]}),
    --Pot(L["Morale (Store)"], CoolDownCategory.Morale, 20, {L["Lesser Draught of Morale"], L["Minor Draught of Morale"], L["Moderate Draught of Morale"], L["Draught of Morale"], L["Greater Draught of Morale"], L["Major Draught of Morale"], L["Superior Draught of Morale"]}),
    --Pot(L["Power (Store)"], CoolDownCategory.Power, 20, {L["Lesser Draught of Power"], L["Minor Draught of Power"], L["Moderate Draught of Power"], L["Draught of Power"], L["Greater Draught of Power"], L["Major Draught of Power"], L["Superior Draught of Power"]}),
    --Pot(L["Disease (Store)"], CoolDownCategory.Disease, 30, {L["Lesser Disease Remedy"], L["Minor Disease Remedy"], L["Moderate Disease Remedy"], L["Disease Remedy"], L["Greater Disease Remedy"], L["Major Disease Remedy"], L["Superior Disease Remedy"]}),
    --Pot(L["Fear (Store)"], CoolDownCategory.Fear, 30, {L["Lesser Fear Remedy"], L["Minor Fear Remedy"], L["Moderate Fear Remedy"], L["Fear Remedy"], L["Greater Fear Remedy"], L["Major Fear Remedy"], L["Superior Fear Remedy"]}),
    --Pot(L["Poison (Store)"], CoolDownCategory.Poison, 30, {L["Lesser Poison Remedy"], L["Minor Poison Remedy"], L["Moderate Poison Remedy"], L["Poison Remedy"], L["Greater Poison Remedy"], L["Major Poison Remedy"], L["Superior Poison Remedy"]}),
    --Pot(L["Wound (Store)"], CoolDownCategory.Wound, 30, {L["Lesser Wound Remedy"], L["Minor Wound Remedy"], L["Moderate Wound Remedy"], L["Wound Remedy"], L["Greater Wound Remedy"], L["Major Wound Remedy"], L["Superior Wound Remedy"]}),
};

-- list of the backpack items
CoolDownManager.items = {};

-- hack control to get update events, remove when we can get updates without being a control
CoolDownManager.update = Turbine.UI.Control();
CoolDownManager.update:SetVisible(false);
CoolDownManager.update:SetWantsUpdates(false);
CoolDownManager.update.Update = function(sender, args)
    CoolDownManager.ProcessUpdate();
end

-- process the backpack
CoolDownManager.backpack = Turbine.Gameplay.LocalPlayer.GetInstance():GetBackpack();
PengorosPlugins.Utils.AddListener(CoolDownManager.backpack, "ItemAdded", function(sender, args)
    CoolDownManager.AddItem(args.Index);
end);
PengorosPlugins.Utils.AddListener(CoolDownManager.backpack, "ItemRemoved", function(sender, args)
    CoolDownManager.RemoveItem(args.Index);
end);
PengorosPlugins.Utils.AddListener(CoolDownManager.backpack, "ItemMoved", function(sender, args)
    CoolDownManager.SwapItems(args.OldIndex, args.NewIndex);
end);

function CoolDownManager.AddItem(index)
    local item = CoolDownManager.backpack:GetItem(index);
    CoolDownManager.items[index] = item;
    if (item == nil) then
        return;
    end

    local name = item:GetName();
    local i;
    for i = 1, table.getn(CoolDownManager.pots) do
        local pot = CoolDownManager.pots[i];
        if (pot:IsMatch(name)) then
            local quantity = item:GetQuantity();
            item.cdlistener = function(sender, args)
                local newQuantity = sender:GetQuantity();
                if ((quantity - 1) == newQuantity) then
                    pot:Start();
                    pot.imageId = sender:GetIconImageID();
                    pot.backgroundImageId = sender:GetBackgroundImageID();
                    CoolDownManager.AddPot(pot);
                end
                quantity = newQuantity;
            end
            PengorosPlugins.Utils.AddListener(item, "QuantityChanged", item.cdlistener);
            break;
        end
    end
end

function CoolDownManager.RemoveItem(index)
    local item = CoolDownManager.items[index];
    CoolDownManager.items[index] = nil;
    if (item ~= nil and item.cdlistener ~= nil) then
        PengorosPlugins.Utils.RemoveListener(item, "QuantityChanged", item.cdlistener);
        item.cdlistener = nil;
    end
end

function CoolDownManager.SwapItems(oldIndex, newIndex)
    local old = CoolDownManager.backpack:GetItem(oldIndex);
    local new = CoolDownManager.backpack:GetItem(newIndex);
    CoolDownManager.items[oldIndex] = old;
    CoolDownManager.items[newIndex] = new;
end

function CoolDownManager.ProcessUpdate()
    local gameTime = Turbine.Engine.GetGameTime();
    local remove = {};
    local i;
    for i = 1, table.getn(CoolDownManager.activePots) do
        local elapsedTime = gameTime - CoolDownManager.activePots[i].startTime;
        if (elapsedTime > CoolDownManager.activePots[i].duration) then
            table.insert(remove, CoolDownManager.activePots[i]);
        end
    end
    
    for i = 1, table.getn(remove) do
        CoolDownManager.RemovePot(remove[i]);
    end
end

function CoolDownManager.AddListener(listener)
    -- make sure it isn't in the list already
    CoolDownManager.RemoveListener(listener);
    table.insert(CoolDownManager.listeners, listener);
end

function CoolDownManager.RemoveListener(listener)
    local i;
    for i = 1, table.getn(CoolDownManager.listeners) do
        if (CoolDownManager.listeners[i] == listener) then
            table.remove(CoolDownManager.listeners, i);
            break;
        end
    end
end

function CoolDownManager.GetPots()
    return CoolDownManager.activePots;
end

function CoolDownManager.AddPot(pot)
    table.insert(CoolDownManager.activePots, pot);
    local i;
    for i = 1, table.getn(CoolDownManager.listeners) do
        if (type(CoolDownManager.listeners[i].PotAdded) == "function") then
            CoolDownManager.listeners[i]:PotAdded(pot);
        end
    end
    CoolDownManager.update:SetWantsUpdates(true);
end

function CoolDownManager.RemovePot(pot)
    for i = 1, table.getn(CoolDownManager.activePots) do
        if (CoolDownManager.activePots[i] == pot) then
            table.remove(CoolDownManager.activePots, i);
            break;
        end
    end

    for i = 1, table.getn(CoolDownManager.listeners) do
        if (type(CoolDownManager.listeners[i].PotRemoved) == "function") then
            CoolDownManager.listeners[i]:PotRemoved(pot);
        end
    end
    CoolDownManager.update:SetWantsUpdates(table.getn(CoolDownManager.activePots) > 0);
end

-- setup the initial backpack state
for i = 1, CoolDownManager.backpack:GetSize() do
    CoolDownManager.AddItem(i);
end
