import "Turbine.UI";

ListBox = class(Turbine.UI.Control);

function ListBox:Constructor()
    Turbine.UI.Control.Constructor(self);
    
    -- state
    self.selection = -1;
    
    -- scrollbar
    self.scrollBar = Turbine.UI.Lotro.ScrollBar();
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.scrollBar:SetParent(self);

    -- border
    self.border = Turbine.UI.Control();
    self.border:SetParent(self);
    self.border:SetBackColor(controlDisabledColor);

    -- listbox
    self.listBox = Turbine.UI.ListBox();
    self.listBox:SetParent(self);
    self.listBox:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.listBox:SetVerticalScrollBar(self.scrollBar);
    self.listBox:SetMaxItemsPerLine(1);
    self.listBox:SetBackColor(dialogBackgroundColor);
end

function ListBox:SetSelection(value)
    for i = 1, self.listBox:GetItemCount() do
        local item = self.listBox:GetItem(i);
        if (item.value == value) then
            self:ItemSelected(i);
            self:FireEvent();
            break;
        end
    end
end

function ListBox:GetSelection()
    if (self.selection == -1) then
        return nil;
    else
        local item = self.listBox:GetItem(self.selection);
        return item.value;
    end
end

function ListBox:UpdateSelection(text, value)
    if (self.selection ~= -1) then
        local item = self.listBox:GetItem(self.selection);
        item:SetText(text);
        item.value = value;
    end
end

function ListBox:CanMoveSelectionUp()
	return self.selection ~= -1 and self.selection > 1;
end

function ListBox:CanMoveSelectionDown()
	return self.selection ~= -1 and self.selection < self.listBox:GetItemCount();
end

function ListBox:MoveSelectionUp()
	if (self:CanMoveSelectionUp()) then
		local item = self.listBox:GetItem(self.selection);
		self.listBox:RemoveItem(item);
		self.selection = self.selection - 1;
		self.listBox:InsertItem(self.selection, item);
		self:FireEvent();
	end
end

function ListBox:MoveSelectionDown()
	if (self:CanMoveSelectionDown()) then
		local item = self.listBox:GetItem(self.selection);
		self.listBox:RemoveItem(item);
		self.selection = self.selection + 1;
		self.listBox:InsertItem(self.selection, item);
		self:FireEvent();
	end
end

function ListBox:FireEvent()
    PengorosPlugins.Utils.ExecuteListener(self, "SelectedIndexChanged", {selection=self:GetSelection()});
end

function ListBox:FireEvent2()
    PengorosPlugins.Utils.ExecuteListener(self, "SelectionDoubleClick", {selection=self:GetSelection()});
end

function ListBox:ItemSelected(index)
    if (self.selection ~= -1) then
        local old = self.listBox:GetItem(self.selection);
        old:SetBackColor(dialogBackgroundColor);
    end
    
    local item = self.listBox:GetItem(index);
    self.selection = index;
    item:SetBackColor(highlightColor);
end

function ListBox:AddItem(text, value)
    local listItem = PengorosPlugins.UI.Label();
    listItem:SetSize(self.listBox:GetWidth(), 20);
    listItem:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    listItem:SetForeColor(control2LightColor);
    listItem:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    listItem:SetText(text);
    listItem.value = value;
    
    listItem.MouseEnter = function(sender, args)
        if (not sender:IsEnabled()) then
            return;
        end
        sender:SetBackColor(highlightColor);
    end
    listItem.MouseLeave = function(sender, args)
        if (not sender:IsEnabled()) then
            return;
        end
        if (self.listBox:IndexOfItem(sender) == self.selection) then
            sender:SetBackColor(highlightColor);
        else
            sender:SetBackColor(dialogBackgroundColor);
        end
    end
    listItem.MouseClick = function(sender, args)
        if (not sender:IsEnabled()) then
            return;
        end
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self:ItemSelected(self.listBox:GetSelectedIndex());
            self:FireEvent();
        end
    end
    listItem.MouseDoubleClick = function(sender, args)
        if (not sender:IsEnabled()) then
            return;
        end
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self:FireEvent2();
        end
    end
    
    self.listBox:AddItem(listItem);
end

function ListBox:RemoveItem(value)
    for i = 1, self.listBox:GetItemCount() do
        local item = self.listBox:GetItem(i);
        if (item.value == value) then
            item:SetVisible(false);
            self.listBox:RemoveItemAt(i);
            
            -- if the removed item is the selection update it
            if (self.selection == i) then
                self.selection = -1;
                self:FireEvent();
            end
            break;
        end
    end
end

function ListBox:ClearItems()
    self.listBox:ClearItems(); -- does this work now?
    self.selection = -1;
    self:FireEvent();
end

function ListBox:GetItemCount()
    return self.listBox:GetItemCount();
end

function ListBox:GetItem(index)
    local item = self.listBox:GetItem(index);
    return item.value;
end

function ListBox:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height);
    self:Layout();
end

function ListBox:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    self.scrollBar:SetEnabled(enabled);
    self.listBox:SetEnabled(enabled);

    local color = enabled and control2LightColor or controlDisabledColor;
    for i = 1, self.listBox:GetItemCount() do
        local item = self.listBox:GetItem(i);
        item:SetEnabled(enabled);
        item:SetBackColor(dialogBackgroundColor);
        item:SetForeColor(color);
    end
    
    -- update the selection background if necessary
    if (enabled and self.selection ~= -1) then
        local selection = self.listBox:GetItem(self.selection);
        selection:SetBackColor(highlightColor);
    end
end

function ListBox:Layout()
    local width, height = self:GetSize();
    
    self.scrollBar:SetPosition(width - 10, 0);
    self.scrollBar:SetSize(10, height);
    self.border:SetPosition(0, 0);
    self.border:SetSize(width - 13, height);
    self.listBox:SetPosition(1, 1);
    self.listBox:SetSize(width - 15, height - 2);
end

