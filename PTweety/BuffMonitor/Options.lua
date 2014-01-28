import "Turbine.Gameplay";
import "Turbine.UI";
import "PTweety.BuffMonitor";
import "PTweety.BuffMonitor.UI";


-- OptionsPane
local OptionsPane = class( Turbine.UI.Control );

OptionsPane.FlashElapsed = 1;
OptionsPane.FlashRemaining = 2;
OptionsPane.PrimaryElapsed = 3;
OptionsPane.PrimaryRemaining = 4;
OptionsPane.SecondaryElapsed = 5;
OptionsPane.SecondaryRemaining = 6;

function OptionsPane:Constructor()
	Turbine.UI.Control.Constructor( self );

	self.current = nil;
	
	local width = 400;

	self.tab = Turbine.UI.TreeView();
	self.tab:SetParent( self );
	self.tab:SetPosition( 0, 0 );
	self.tab:SetIndentationWidth( 0 );
	self.tabNodes = self.tab:GetNodes();

	local newSection = function( parent, height )
		local container = Turbine.UI.TreeNode();
		container:SetSize( 400, height );
		container.SelectedChanged = function( sender, args )
			local nodeNum = self.tabNodes:IndexOf( sender );
			if ( nodeNum > 1 and nodeNum < self.tabNodes:GetCount() and sender:IsSelected() ) then
				self.tab:CollapseAll();
				sender:Expand();
			end
		end
		parent:Add( container );
		return container;
	end

	local newLine = function ( parent, height )
		local container = Turbine.UI.TreeNode();
		container:SetSize( 400, height );
		parent:GetChildNodes():Add( container );
		return container;
	end

	-- General options
	local section = newSection( self.tabNodes, 95 );
	self.windowTitle = PTweety.BuffMonitor.UI.PanelDivider();
	self.windowTitle:SetParent( section );
	self.windowTitle:SetSize( 400, 30 );
	self.windowTitle:SetText( 'Effect Windows' );

	--local line = newLine( section, 30 );
	self.windowLabel = PTweety.BuffMonitor.UI.Label();
	self.windowLabel:SetParent(section);
	self.windowLabel:SetSize( 176, 20 );
	self.windowLabel:SetPosition( 10, 35 );
	self.windowLabel:SetText( 'Window' );
	
	self.windowCombo = PTweety.BuffMonitor.UI.ComboBox();
	self.windowCombo:SetParent(section);
	self.windowCombo:SetSize( 204, 20 );
	self.windowCombo:SetPosition( 186, 35 );
	self.windowCombo.SelectedIndexChanged = function( sender, args )
		if ( self.current ~= nil ) then
			self:SaveWindowOptions( self.current );
		end
		if ( args ~= nil and args.selection ~= nil ) then
			self:SetWindowOptions( args.selection );
			self.current = args.selection;
		end
	end

	--line = newLine( section, 30 );
	self.newButton  = Turbine.UI.Lotro.Button();
	self.newButton:SetParent( section );
	self.newButton:SetPosition( 183, 65 );
	self.newButton:SetSize( 100, 22 );
	self.newButton:SetText( 'New' );
	self.newButton.Click = function( sender, args )
		self:AddNewWindow();
	end

	self.removeButton  = Turbine.UI.Lotro.Button();
	self.removeButton:SetParent( section );
	self.removeButton:SetPosition( 292, 65 );
	self.removeButton:SetSize( 100, 22 );
	self.removeButton:SetText( 'Remove');
	self.removeButton.Click = function( sender, args )
		self:RemoveCurrentWindow();
	end

	-- general
	section = newSection( self.tabNodes, 35 );
	self.generalTitle = PTweety.BuffMonitor.UI.PanelDivider();
	self.generalTitle:SetParent( section );
	self.generalTitle:SetSize( 400, 30 );
	self.generalTitle:SetText( 'General' );

	local line = newLine( section, 30 );
	self.nameLabel = PTweety.BuffMonitor.UI.Label();
	self.nameLabel:SetParent(line);
	self.nameLabel:SetSize( 176, 20 );
	self.nameLabel:SetPosition( 10, 0 );
	self.nameLabel:SetText( 'Name' );
	
	self.nameText = Turbine.UI.Lotro.TextBox();
	self.nameText:SetParent(line);
	self.nameText:SetSize( 206, 20 );
	self.nameText:SetPosition( 185, 0 );
	self.nameText:SetFont(Turbine.UI.Lotro.Font.Verdana14);
	self.nameText:SetMultiline(false);
	self.nameText:SetWantsUpdates(true);
	self.nameText.Update = function(sender, args)
		self.windowCombo:UpdateSelectionText( self.nameText:GetText() );
	end

	line = newLine(section, 20);
	self.showWindowCB = PTweety.BuffMonitor.UI.CheckBox();
	self.showWindowCB:SetParent(line);
	self.showWindowCB:SetText( 'Enabled' );
	self.showWindowCB:SetSize(390, 20);

	line = newLine(section, 40);
    self.visibleTypeLabel = PTweety.BuffMonitor.UI.Label();
    self.visibleTypeLabel:SetParent(line);
    self.visibleTypeLabel:SetSize(176, 20);
    self.visibleTypeLabel:SetPosition(10, 10);
    self.visibleTypeLabel:SetText( 'Show Window' );

    self.visibleTypeCombo = PTweety.BuffMonitor.UI.ComboBox();
    self.visibleTypeCombo:SetParent(line);
    self.visibleTypeCombo:SetSize( 204, 20 );
    self.visibleTypeCombo:SetPosition( 186, 10 );
    self.visibleTypeCombo:AddItem( 'Always', WindowVisibility.Always);
    self.visibleTypeCombo:AddItem( 'Only In Combat', WindowVisibility.InCombat);
    self.visibleTypeCombo:AddItem( 'Only Out Of Combat', WindowVisibility.OutOfCombat);

	line = newLine(section, 20);
	self.showMountedCB = PTweety.BuffMonitor.UI.CheckBox();
	self.showMountedCB:SetParent(line);
	self.showMountedCB:SetText( 'If Mounted' );
	self.showMountedCB:SetSize(390, 20);

	line = newLine(section, 20);
	self.showByFootCB = PTweety.BuffMonitor.UI.CheckBox();
	self.showByFootCB:SetParent(line);
	self.showByFootCB:SetText( 'If By Foot' );
	self.showByFootCB:SetSize(390, 20);

	-- ui elements
	section = newSection(self.tabNodes, 35);
	self.uiTitle = PTweety.BuffMonitor.UI.PanelDivider();
	self.uiTitle:SetParent(section);
	self.uiTitle:SetText( 'UI Elements' );
	self.uiTitle:SetSize(400, 30);

	line = newLine(section, 20);
	self.showEffectIconCB = PTweety.BuffMonitor.UI.CheckBox();
	self.showEffectIconCB:SetParent(line);
	self.showEffectIconCB:SetText( 'Show Effect Icon' );
	self.showEffectIconCB:SetSize(390, 20);

	line = newLine(section, 20);
	self.showEffectNameCB = PTweety.BuffMonitor.UI.CheckBox();
	self.showEffectNameCB:SetParent(line);
	self.showEffectNameCB:SetText( 'Show Effect Name' );
	self.showEffectNameCB:SetSize(390, 20);

	line = newLine(section, 20);
	self.showEffectTimerCB = PTweety.BuffMonitor.UI.CheckBox();
	self.showEffectTimerCB:SetParent(line);
	self.showEffectTimerCB:SetText( 'Show Effect Timer' );
	self.showEffectTimerCB:SetSize(390, 20);

	line = newLine(section, 20);
	self.showEffectElapsedCB = PTweety.BuffMonitor.UI.CheckBox();
	self.showEffectElapsedCB:SetParent(line);
	self.showEffectElapsedCB:SetText( 'Show Effect Elapsed Bar' );
	self.showEffectElapsedCB:SetSize(390, 20);

	line = newLine(section, 20);
	self.showEffectRemainingCB = PTweety.BuffMonitor.UI.CheckBox();
	self.showEffectRemainingCB:SetParent(line);
	self.showEffectRemainingCB:SetText( 'Show Effect Remaining Bar' );
	self.showEffectRemainingCB:SetSize(390, 20);

    line = newLine(section, 60);
    self.widthSlider = PTweety.BuffMonitor.UI.Slider();
    self.widthSlider:SetParent(line);
    self.widthSlider:SetText( 'Width' );
    self.widthSlider:SetPosition(49, 10);
    self.widthSlider:SetSize(340, 40);
    self.widthSlider:SetStep(1);
    self.widthSlider:SetMin(100);
    self.widthSlider:SetMax(400);

    line = newLine(section, 50);
    self.heightSlider = PTweety.BuffMonitor.UI.Slider();
    self.heightSlider:SetParent(line);
    self.heightSlider:SetText( 'Height' );
    self.heightSlider:SetPosition(49, 0);
    self.heightSlider:SetSize(340, 40);
    self.heightSlider:SetStep(1);
    self.heightSlider:SetMin(20);
    self.heightSlider:SetMax(50);

	-- colors
	section = newSection(self.tabNodes, 35);
	self.colorTitle = PTweety.BuffMonitor.UI.PanelDivider();
	self.colorTitle:SetParent(section);
	self.colorTitle:SetText( 'Colors' );
	self.colorTitle:SetSize(400, 30);

	line = newLine(section, 30);
	self.background = Turbine.UI.Control();
	self.background:SetParent(line);
	self.background:SetPosition(60, 0);
	self.background:SetSize(90, 20);
	self.background:SetZOrder(10);
	self.background:SetBackColor(Turbine.UI.Color(.5,0,0,0));

	self.color = Turbine.UI.Control();
	self.color:SetParent(line);
	self.color:SetPosition(60, 0);
	self.color:SetSize(90, 20);
	self.color:SetZOrder(20);
	self.color:SetBackColor(Turbine.UI.Color(1,.8,.8,0));

	self.colorCombo = PTweety.BuffMonitor.UI.ComboBox();
	self.colorCombo:SetParent(line);
	self.colorCombo:SetSize( 204, 20 );
	self.colorCombo:SetPosition( 186, 0 );
	--self.colorCombo:AddItem( 'Flash Elapsed', OptionsPane.FlashElapsed );
	--self.colorCombo:AddItem( 'Flash Remaining', OptionsPane.FlashRemaining );
	self.colorCombo:AddItem( 'Primary Elapsed', OptionsPane.PrimaryElapsed );
	self.colorCombo:AddItem( 'Primary Remaining', OptionsPane.PrimaryRemaining );
	self.colorCombo:AddItem( 'Secondary Elapsed', OptionsPane.SecondaryElapsed );
	self.colorCombo:AddItem( 'Secondary Remaining', OptionsPane.SecondaryRemaining );
	self.colorCombo.SelectedIndexChanged = function(sender, args)
		self:ChangeColor(self.colors[args.selection]);
	end

	line = newLine(section, 50);
	self.redSlider = PTweety.BuffMonitor.UI.Slider();
	self.redSlider:SetParent(line);
	self.redSlider:SetText( 'Red' );
	self.redSlider:SetPosition(49, 0);
	self.redSlider:SetSize(340, 40);
	self.redSlider:SetStep(1);
	self.redSlider:SetMin(0);
	self.redSlider:SetMax(255);
	self.redSlider.ValueChanged = function(sender, args)
		local color = self.colors[self.colorCombo:GetSelection()];
		color.r = args.value;
		self.color:SetBackColor(Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255));
	end

	line = newLine(section, 50);
	self.greenSlider = PTweety.BuffMonitor.UI.Slider();
	self.greenSlider:SetParent(line);
	self.greenSlider:SetText(' Green' );
	self.greenSlider:SetPosition(49, 0);
	self.greenSlider:SetSize(340, 40);
	self.greenSlider:SetStep(1);
	self.greenSlider:SetMin(0);
	self.greenSlider:SetMax(255);
	self.greenSlider.ValueChanged = function(sender, args)
		local color = self.colors[self.colorCombo:GetSelection()];
		color.g = args.value;
		self.color:SetBackColor(Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255));
	end

	line = newLine(section, 50);
	self.blueSlider = PTweety.BuffMonitor.UI.Slider();
	self.blueSlider:SetParent(line);
	self.blueSlider:SetText( 'Blue' );
	self.blueSlider:SetPosition(49, 0);
	self.blueSlider:SetSize(340, 40);
	self.blueSlider:SetStep(1);
	self.blueSlider:SetMin(0);
	self.blueSlider:SetMax(255);
	self.blueSlider.ValueChanged = function(sender, args)
		local color = self.colors[self.colorCombo:GetSelection()];
		color.b = args.value;
		self.color:SetBackColor(Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255));
	end

	line = newLine(section, 50);
	self.alphaSlider = PTweety.BuffMonitor.UI.Slider();
	self.alphaSlider:SetParent(line);
	self.alphaSlider:SetText( 'Alpha' );
	self.alphaSlider:SetPosition(49, 0);
	self.alphaSlider:SetSize(340, 40);
	self.alphaSlider:SetStep(1);
	self.alphaSlider:SetMin(0);
	self.alphaSlider:SetMax(255);
	self.alphaSlider.ValueChanged = function(sender, args)
		local color = self.colors[self.colorCombo:GetSelection()];
		color.a = args.value;
		self.color:SetBackColor(Turbine.UI.Color(color.a / 255, color.r / 255, color.g / 255, color.b / 255));
	end

	-- revert, defaults, accept buttons
	section = newSection(self.tabNodes, 40);
	self.colorTitle = Turbine.UI.Control();
	self.colorTitle:SetParent(section);
	self.colorTitle:SetSize(400, 30);

	line = section;
	self.revertButton = Turbine.UI.Lotro.Button();
	self.revertButton:SetParent( line );
	self.revertButton:SetPosition( 74, 10 );
	self.revertButton:SetSize( 100, line:GetHeight() - 8 );
	self.revertButton:SetText( 'Revert' );
	self.revertButton.Click = function( sender, args )
		self:SetOptions();
	end

	self.defaultButton = Turbine.UI.Lotro.Button();
	self.defaultButton:SetParent( line );
	self.defaultButton:SetPosition( 183, 10 );
	self.defaultButton:SetSize( 100, line:GetHeight() - 8 );
	self.defaultButton:SetText( 'Defaults' );
	self.defaultButton.Click = function( sender, args )
		Settings.instance:SetDefaults();
		PTweety.BuffMonitor.ResetWindows();
		Settings.Save();
		self:SetOptions();
	end

	self.acceptButton = Turbine.UI.Lotro.Button();
	self.acceptButton:SetParent( line );
	self.acceptButton:SetPosition( 292, 10 );
	self.acceptButton:SetSize( 100, line:GetHeight() - 8 );
	self.acceptButton:SetText( 'Accept' );
	self.acceptButton.Click = function( sender, args )
		self:SaveOptions();
		PTweety.BuffMonitor.ResetWindows();
		Settings.Save();
	end

	-- open the general section by default
	self.tab:SetSelectedNode( self.tabNodes:Get(2) );

	self.SizeChanged = function( sender, args )
		local width, height = self:GetSize();
		self.tab:SetSize( width, height );
		self:Layout();
	end

	self:Layout();
end

function OptionsPane:Destroy()
	self:SetVisible( false );
	self:SetParent( nil );

	self.tab:SetVisible( false );
	self.tab:SetParent( nil );
	self.tab = nil;
end

function OptionsPane:Layout()
end

function OptionsPane:AddNewWindow()
	local window = Settings.GetEffectWindowDefaults();
	self.windowCombo:AddItem( window.name, window );
	self.windowCombo:SetSelection( window );
end

function OptionsPane:RemoveCurrentWindow()
	self.windowCombo:RemoveItem( self.current );
	if ( self.windowCombo:GetItemCount() == 0 ) then
		self:AddNewWindow();
	end
end

function OptionsPane:ChangeColor( color )
	self.color:SetBackColor(Turbine.UI.Color(color["a"] / 255, color["r"] / 255, color["g"] / 255, color["b"] / 255));
	self.redSlider:SetValue(color["r"]);
	self.greenSlider:SetValue(color["g"]);
	self.blueSlider:SetValue(color["b"]);
	self.alphaSlider:SetValue(color["a"]);
end

function OptionsPane:SetOptions( value )
	local current;
	if ( self.current ~= nil ) then
		current = self.windowCombo:GetSelectedIndex();
	end
	if ( value ~= nil ) then
		current = value;
	end

	-- reset
	self.current = nil;
	self.windowCombo:ClearItems();
	
	-- windows
	local i;
	local size = table.getn( Settings.instance.windows );
	for i = 1, size do
		local window = PTweety.BuffMonitor.Utils.DeepCopy( Settings.instance.windows[i] );
		self.windowCombo:AddItem( window.name, window );
	end

	if ( size > 0 ) then
		if ( current ~= nil and current <= size ) then
			self.windowCombo:SetSelection( self.windowCombo:GetItem(current) );
		else
			self.windowCombo:SetSelection( self.windowCombo:GetItem(1) );
		end
	end
end

function OptionsPane:SaveOptions()
	-- save the current window settings
	if ( self.current ~= nil ) then
		self:SaveWindowOptions( self.current );
	end
	
	-- collect all the windows into an array
	local windows = {};
	local i;
	for i = 1, self.windowCombo:GetItemCount() do
		windows[i] = self.windowCombo:GetItem(i);
	end
	
	-- overwrite the existing windows
	Settings.instance.windows = windows;
end

function OptionsPane:SetWindowOptions( settings )
	-- general
	self.nameText:SetText( settings.name );
	self.showWindowCB:SetChecked(settings.visible);
    self.visibleTypeCombo:SetSelection(settings.visibleType);
	self.showMountedCB:SetChecked(settings.visibleMounted);
	self.showByFootCB:SetChecked(settings.visibleByFoot);

	-- ui elements
	self.showEffectIconCB:SetChecked(settings.showEffect.icon);
	self.showEffectNameCB:SetChecked(settings.showEffect.name);
	self.showEffectTimerCB:SetChecked(settings.showEffect.timer);
	self.showEffectElapsedCB:SetChecked(settings.showEffect.elapsed);
	self.showEffectRemainingCB:SetChecked(settings.showEffect.remaining);
    self.widthSlider:SetValue(settings.itemWidth);
    self.heightSlider:SetValue(settings.itemHeight);

	-- colors
	self.colors = {};
	self.colors[OptionsPane.FlashElapsed] = settings.colors[Colors.Flash].elapsed;
	self.colors[OptionsPane.FlashRemaining] = settings.colors[Colors.Flash].remaining;
	self.colors[OptionsPane.PrimaryElapsed] = settings.colors[Colors.Primary].elapsed;
	self.colors[OptionsPane.PrimaryRemaining] = settings.colors[Colors.Primary].remaining;
	self.colors[OptionsPane.SecondaryElapsed] = settings.colors[Colors.Secondary].elapsed;
	self.colors[OptionsPane.SecondaryRemaining] = settings.colors[Colors.Secondary].remaining;
	self.colorCombo:SetSelection(OptionsPane.PrimaryElapsed);
	self:ChangeColor(self.colors[OptionsPane.PrimaryElapsed]);
end

function OptionsPane:SaveWindowOptions( settings )
	-- general
	settings.name = self.nameText:GetText();
	settings.visible = self.showWindowCB:IsChecked();
    settings.visibleType = self.visibleTypeCombo:GetSelection();
	settings.visibleMounted = self.showMountedCB:IsChecked();
	settings.visibleByFoot = self.showByFootCB:IsChecked();

	-- ui elements
	settings.showEffect.icon = self.showEffectIconCB:IsChecked();
	settings.showEffect.name = self.showEffectNameCB:IsChecked();
	settings.showEffect.timer = self.showEffectTimerCB:IsChecked();
	settings.showEffect.elapsed = self.showEffectElapsedCB:IsChecked();
	settings.showEffect.remaining = self.showEffectRemainingCB:IsChecked();
    settings.itemWidth = self.widthSlider:GetValue();
    settings.itemHeight = self.heightSlider:GetValue();

	-- colors
	settings.colors[Colors.Flash].elapsed = self.colors[OptionsPane.FlashElapsed];
	settings.colors[Colors.Flash].remaining = self.colors[OptionsPane.FlashRemaining];
	settings.colors[Colors.Primary].elapsed = self.colors[OptionsPane.PrimaryElapsed];
	settings.colors[Colors.Primary].remaining = self.colors[OptionsPane.PrimaryRemaining];
	settings.colors[Colors.Secondary].elapsed = self.colors[OptionsPane.SecondaryElapsed];
	settings.colors[Colors.Secondary].remaining = self.colors[OptionsPane.SecondaryRemaining];
end


-- Options
Options = class();

function Options:Constructor()
	self.optionsPane = OptionsPane();
	self.optionsPane:SetSize( 400, 465 );
	self:SetOptions();
end

function Options:Destroy()
	self.optionsPane:Destroy();
	self.optionsPane = nil;
end

function Options:GetOptionsPanel()
	return self.optionsPane;
end

function Options:SetOptions( value )
	self.optionsPane:SetOptions( value );
end
