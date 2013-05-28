import "Turbine.UI";

TabbedPane = class(Turbine.UI.Control);

function TabbedPane:Constructor()
    Turbine.UI.Control.Constructor(self);

    self.tabs = {};
    self.selected = nil;
    self:SetMouseVisible(false);
    
    -- border
    self.border = Turbine.UI.Control();
    self.border:SetParent(self);
    self.border:SetZOrder(-1);
    self.border:SetPosition(1, 24);
    self.border:SetMouseVisible(false);
    self.border:SetBackColor(blueBorderColor);
end

function TabbedPane:AddTab(name, content)
    local tab = Tab(name, content);
    local index = #self.tabs + 1;
    tab.Click = function(sender, args)
        self:SelectTab(index);
    end
    table.insert(self.tabs, tab);
    
    tab:SetParent(self);
    content:SetParent(self);
    content:SetVisible(false);
    return tab;
end

function TabbedPane:SelectTab(index)
    if (self.selected == self.tabs[index]) then
        return
    end
    
    if (self.selected ~= nil) then
        self.selected:SetSelected(false);
        self.selected:GetContent():SetVisible(false);
    end
    
    self.selected = self.tabs[index];
    self.selected:SetSelected(true);
    self.selected:GetContent():SetVisible(true);
    self:FireEvent();
    self:Layout();
end

function TabbedPane:GetTab(index)
    return self.tabs[index];
end

function TabbedPane:GetSelectedTab()
    return self.selected;
end

function TabbedPane:FireEvent()
    PengorosPlugins.Utils.ExecuteListener(self, "SelectedTabChanged", {selection=self.selected});
end

function TabbedPane:SizeChanged(args)
    self:Layout();
end

function TabbedPane:Layout()
    local width, height = self:GetSize();
    
    self.border:SetSize(width - 5, height - 29);
    
    local tabWidth = 0;
    for i = 1, table.getn(self.tabs) do
        local tab = self.tabs[i];
        tab:SetPosition(tabWidth, 2);
        tabWidth = tabWidth + tab:GetWidth();
    end
    
    if (self.selected ~= nil) then
        local content = self.selected:GetContent();
        content:SetPosition(2, 25);
        content:SetSize(width - 7, height - 31);
    end
end
