import "Turbine.Gameplay";
import "Turbine.UI";
import "PengorosPlugins.BuffBars";
import "PengorosPlugins.UI";

OptionsPanel = class(Turbine.UI.Control);
OptionsPanel.instance = nil;

function OptionsPanel:Constructor()
    Turbine.UI.Control.Constructor(self);
    OptionsPanel.instance = self;
    
    -- tabbed pane
    self.pane = PengorosPlugins.UI.TabbedPane();
    self.pane:SetParent(self);
    -- FIXME remove this when I can get the height of the current options area
    self.pane.SelectedTabChanged = function(sender, args)
    	-- calculate the new height
    	local list = args.selection:GetContent().panel;
    	local height = 0;
    	for i = 1, list:GetItemCount() do
    		height = height + list:GetItem(i):GetHeight();
    	end
    	self:SetHeight(height + 35 + 31);
    end
    
    -- create the tabs
    self.tabs = {OptionsGeneralPanel(), OptionsQuickslotPanel(), OptionsEffectPanel(), OptionsSliderPanel()};
    local buttons = {L["General"], L["Quickslot"], L["Effect Windows"], L["Effect Sliders"]};
    local sizes = {150, 150, 150, 150};
    for i = 1, table.getn(self.tabs) do
        -- create the tab
        local tab = Turbine.UI.Control();
        tab:SetBackColor(Turbine.UI.Color(0.925, 0, 0, 0));
        
        local scrollbar = Turbine.UI.Lotro.ScrollBar();
        scrollbar:SetOrientation(Turbine.UI.Orientation.Vertical);
        scrollbar:SetParent(tab);
    
        local panel = self.tabs[i];
        tab.panel = panel;
        panel:SetParent(tab);
        panel:SetVerticalScrollBar(scrollbar);
        
        tab.SizeChanged = function(sender, args)
        	local width, height = sender:GetSize();
        	scrollbar:SetSize(10, height);
        	panel:SetSize(width - 15, height);
        	scrollbar:SetPosition(width - 10, 0);
        	panel:SetPosition(0, 0);
        end
        
        self.pane:AddTab(buttons[i], tab):SetWidth(sizes[i]);
    end
    
    -- buttons
    self.revertButton = Turbine.UI.Lotro.Button();
    self.revertButton:SetParent(self);
    self.revertButton:SetSize(100, 20);
    self.revertButton:SetText(L["Revert"]);
    PengorosPlugins.UI.Tooltip(self.revertButton, L["Revert any changes made to the BuffBar options."]);
    self.revertButton.Click = function(sender, args)
        self:Revert();
        Turbine.Shell.WriteLine(L["BuffBars options reverted."]);
    end

    self.defaultButton = Turbine.UI.Lotro.Button();
    self.defaultButton:SetParent(self);
    self.defaultButton:SetSize(100, 20);
    self.defaultButton:SetText(L["Defaults"]);
    PengorosPlugins.UI.Tooltip(self.defaultButton, L["Reset the BuffBar options to their defaults.  This change is immediate and will affect both character and account level settings."]);
    self.defaultButton.Click = function(sender, args)
        self:Defaults();
        Turbine.Shell.WriteLine(L["BuffBars options reset to defaults."]);
    end

    self.acceptButton  = Turbine.UI.Lotro.Button();
    self.acceptButton:SetParent(self);
    self.acceptButton:SetSize(100, 20);
    self.acceptButton:SetText(L["Accept"]);
    PengorosPlugins.UI.Tooltip(self.acceptButton, L["Save and apply any changes made to the BuffBar options."]);
    self.acceptButton.Click = function(sender, args)
    	self:Accept();
        Turbine.Shell.WriteLine(L["BuffBars options saved."]);
    end
    
    -- set the default height
    self:SetHeight(535);

    -- load the options
    self:SetOptions();

    -- show the first tab
    self.pane:SelectTab(1);
end

function OptionsPanel:Revert()
	self:SetOptions();
end

function OptionsPanel:Defaults()
    Settings.Reset();
	PengorosPlugins.BuffBars.ResetState();
	Settings.Save();
	self:SetOptions();
end

function OptionsPanel:Accept()
	self:SaveOptions();
	PengorosPlugins.BuffBars.ResetState();
	Settings.Save();
end

function OptionsPanel:SizeChanged(args)
	self:Layout();
end

function OptionsPanel:Layout()
	local width, height = self:GetSize();
	self.pane:SetSize(width, height - 35);
	
	local x = math.max((width - 330) / 2, 0);
	local y = height - 35 + 6;
	self.revertButton:SetPosition(x, y);
	self.defaultButton:SetPosition(x + 115, y);
	self.acceptButton:SetPosition(x + 230, y);
end

function OptionsPanel:SetOptions()
    local i;
    for i = 1, table.getn(self.tabs) do
        self.tabs[i]:SetOptions();
    end
end

function OptionsPanel:SaveOptions()
    local i;
    for i = 1, table.getn(self.tabs) do
        self.tabs[i]:SaveOptions();
    end
end

function OptionsPanel:Destroy()
	for i = 1, table.getn(self.tabs) do
		if (type(self.tabs[i].Destroy) == "function") then
			self.tabs[i]:Destroy();
		end
	end
end


function OptionsPanel:Cleanup()
    self.pane:SetParent(nil);
    self.pane:SetVisible(false);
    self.revertButton:SetParent(nil);
    self.revertButton:SetVisible(false);
    self.defaultButton:SetParent(nil);
    self.defaultButton:SetVisible(false);
    self.acceptButton:SetParent(nil);
    self.acceptButton:SetVisible(false);
end
