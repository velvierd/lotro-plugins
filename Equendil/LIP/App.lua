import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

import "Equendil.UI.Resources";
import "Equendil.UI.TabbedPanel";
import "Equendil.UI.WindowManager";
import "Equendil.UI.CommonControls";
import "Equendil.UI.Resizer";
import "Equendil.LIP.Resources";
import "Equendil.LIP.Legacy";
import "Equendil.LIP.LegacySelector";
import "Equendil.LIP.LegacyConfigurator";
import "Equendil.LIP.LegendaryItem";
import "Equendil.LIP.LegendaryItemControl";
import "Equendil.LIP.LegendaryItemFooterControl";
import "Equendil.LIP.LegacySummary";
import "Equendil.LIP.ExpChart";
import "Equendil.LIP.ClassSelector";
import "Equendil.LIP.ItemSelector";

local StorageKey = "EQ_LIP";

ClassesInfo = {
	{
		name = L["Minstrel"], 
		icon = Equendil.UI.Icon.ClassBig.Minstrel,
		legendaryItems = Equendil.LIP.LegaciesMinstrel,
		iconLegKeys = { "Sword", "SongBook", "LightBridle", "MediumBridle", "HeavyBridle" }
	}, {
		name = L["Burglar"],
		icon = Equendil.UI.Icon.ClassBig.Burglar,
		legendaryItems = Equendil.LIP.LegaciesBurglar,
		iconLegKeys = { "Dagger", "Tools", "LightBridle", "MediumBridle", "HeavyBridle" }
	}, {
		name = L["Lore-Master"],
		icon = Equendil.UI.Icon.ClassBig.Loremaster,
		legendaryItems = Equendil.LIP.LegaciesLoremaster,
		iconLegKeys = { "Staff", "Book", "LightBridle", "MediumBridle", "HeavyBridle" }
	}, {
		name = L["Hunter"],
		icon = Equendil.UI.Icon.ClassBig.Hunter,
		legendaryItems = Equendil.LIP.LegaciesHunter,
		iconLegKeys = { "Bow", "Sword", "LightBridle", "MediumBridle", "HeavyBridle" }
	}, {
		name = L["Guardian"],
		icon = Equendil.UI.Icon.ClassBig.Guardian,
		legendaryItems = Equendil.LIP.LegaciesGuardian,
		iconLegKeys = { "Sword", "GreatSword", "Belt", "LightBridle", "MediumBridle", "HeavyBridle" }
	}, {
		name = L["Champion"],
		icon = Equendil.UI.Icon.ClassBig.Champion,
		legendaryItems = Equendil.LIP.LegaciesChampion,
		iconLegKeys = { "Sword", "GreatSword", "Rune", "LightBridle", "MediumBridle", "HeavyBridle" }
	}, {
		name = L["Captain"], 
		icon = Equendil.UI.Icon.ClassBig.Captain,
		legendaryItems = Equendil.LIP.LegaciesCaptain,
		iconLegKeys = { "Halberd", "Sword", "Emblem", "LightBridle", "MediumBridle", "HeavyBridle" }
	}, {
		name = L["Warden"],
		icon = Equendil.UI.Icon.ClassBig.Warden,
		legendaryItems = Equendil.LIP.LegaciesWarden,
		iconLegKeys = { "Spear", "Javelin", "LightBridle", "MediumBridle", "HeavyBridle" }
	}, {
		name = L["Rune-keeper"],
		icon = Equendil.UI.Icon.ClassBig.Runekeeper,
		legendaryItems = Equendil.LIP.LegaciesRunekeeper,
		iconLegKeys = { "Stone", "Satchel", "LightBridle", "MediumBridle", "HeavyBridle" }
	}
}

ClassIndices = {
	[Turbine.Gameplay.Class.Minstrel] = 1,
	[Turbine.Gameplay.Class.Burglar] = 2,
	[Turbine.Gameplay.Class.LoreMaster] = 3,
	[Turbine.Gameplay.Class.Hunter] = 4,
	[Turbine.Gameplay.Class.Guardian] = 5,
	[Turbine.Gameplay.Class.Champion] = 6,
	[Turbine.Gameplay.Class.Captain] = 7,
	[Turbine.Gameplay.Class.Warden] = 8,
	[Turbine.Gameplay.Class.RuneKeeper] = 9
};

local OrigWidth = 776; ---634;

App = class( Turbine.UI.Lotro.Window );	
function App:Constructor()
	Turbine.UI.Lotro.Window.Constructor( self );
	self.selecting = false;

	-- what tab of what class we are displaying
	self.classIndex = 1;
	self.tabIndex = 1;
	
	-- init table of legendary items (n classes * 8 items )
	self.legendaryItems = {};
	for i = 1, #ClassesInfo do
		self.legendaryItems[i] = {};
	end
	
	-- legendary item <-> index association table (index being the index of a legendary item in item templates in legacy.lua, as well as icon tables in ClassesInfo )
	self.legendaryItemIndex = {};

	-- saved data for undo or whatever
	self.persistentData = nil; 

	self.showAtStart = true;
	
	-- setup the main window
	self:SetSize( OrigWidth, 570 );
	self:SetPosition( -- center it
		( Turbine.UI.Display:GetWidth() - self:GetWidth() ) / 2, 
		( Turbine.UI.Display:GetHeight() - self:GetHeight() ) /2 
	);
	self:SetText( L["Legendary Item Planner"] );
	Equendil.UI.WindowManager:ManageWindow( self ); -- add ourselves to the Window Manager for HUD toggling

	-- resizer control
	self.resizer = Equendil.UI.Resizer();
	self.resizer:AttachWindow( self, OrigWidth, 500, Turbine.UI.Display.GetWidth(), Turbine.UI.Display.GetHeight() );
	
	-- class selector
	self.classSelector = Equendil.LIP.ClassSelector( Equendil.LIP.ClassesInfo );
	self.classSelector:SetParent( self );
	self.classSelector:SetPosition( 15, 35 );
	
	-- Tabulated panel
	self.tabbedPanel = Equendil.UI.TabbedPanel();
	self.tabbedPanel:SetParent( self );
	self.tabbedPanel:SetPosition( 7, 103 );

	for i = 1, 10 do
		self.tabbedPanel:SetTabName( i, tostring(i) );
	end
	-- extract the panel control in which we'll add more controls
	self.panel = self.tabbedPanel:GetPanel();
	
	-- some decoration
	self.labelLegacies = Turbine.UI.Label();
	self.labelLegacies:SetParent( self.panel );
	self.labelLegacies:SetSize( 100, 25 );
	self.labelLegacies:SetPosition( 25, 80 );
	self.labelLegacies:SetFont( Turbine.UI.Lotro.Font.TrajanPro20 );
	self.labelLegacies:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelLegacies:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.labelLegacies:SetForeColor( Equendil.UI.Color.TurbineLightYellow );	
	self.labelLegacies:SetText( L["Legacies"] );

	self.backgroundItem1 = Turbine.UI.Control();
	self.backgroundItem1:SetParent( self.panel );
	self.backgroundItem1:SetSize( 68, 63 );
	self.backgroundItem1:SetPosition( 0, 10 );
	self.backgroundItem1:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.backgroundItem1:SetBackground( 0x41112827 );
	
	self.backgroundItem2 = Turbine.UI.Control();
	self.backgroundItem2:SetParent( self.panel );
	self.backgroundItem2:SetSize( 355, 63 );
	self.backgroundItem2:SetPosition( 68, 10 );
	self.backgroundItem2:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.backgroundItem2:SetBackground( 0x41112825 );

	self.backgroundItem3 = Turbine.UI.Control();
	self.backgroundItem3:SetParent( self.panel );
	self.backgroundItem3:SetSize( 333, 63 );
	self.backgroundItem3:SetPosition( 423, 10 );
	self.backgroundItem3:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.backgroundItem3:SetBackground( 0x41112823 );
	
	-- legacies action buttons
	self.buttonPickLegacies = Turbine.UI.Lotro.Button();
	self.buttonPickLegacies:SetParent( self.panel );
	self.buttonPickLegacies:SetSize( 120, 20 );
	self.buttonPickLegacies:SetPosition( 140, 82 );
	self.buttonPickLegacies:SetText( L["Choose..."] );
	self.buttonPickLegacies.Click = function( sender, args ) self:_ToggleSelectionMode() end;

	self.buttonMaxTiers = Turbine.UI.Lotro.Button();
	self.buttonMaxTiers:SetParent( self.panel );
	self.buttonMaxTiers:SetSize( 120, 20 );
	self.buttonMaxTiers:SetPosition( 270, 82 );
	self.buttonMaxTiers:SetText( L["Max Tiers"] );
	self.buttonMaxTiers.Click = function( sender, args ) self.legacyConfigurator:SetMaxTiers(); end
	
	-- views/controls handling legendary items & legacies	
	self.controlItem = Equendil.LIP.LegendaryItemControl(); -- control to set item level, level to use, age ...
	self.controlItem:SetParent( self.panel );
	self.controlItem:SetPosition( 0, 10 );
	self.controlItem.CloseRequest = function() self:_Delete( self.classIndex, self.tabIndex ) end;
	self.controlItem.ExpHover:Add( 
		function( legendaryItem ) 
			self.expChart:Set( legendaryItem );
			self.expChart:SetVisible( legendaryItem ~= nil );
		end
	);
	
	self.controlItemFooter = Equendil.LIP.LegendaryItemFooterControl(); -- control showing points spent/remaining
	self.controlItemFooter:SetParent( self.panel );
	self.controlItemFooter:SetPosition( 15, 365 );
	
	self.legacySelector = Equendil.LIP.LegacySelector(); -- legacy list for selection
	self.legacySelector:SetParent( self.panel );
	self.legacySelector:SetPosition( 20, 102 );

	self.legacyConfigurator = Equendil.LIP.LegacyConfigurator(); -- legacy list for configuration
	self.legacyConfigurator:SetParent( self.panel );
	self.legacyConfigurator:SetPosition( 20, 102 );
	self.legacyConfigurator.LegacyHover:Add( 
		function( legacy ) 
			self.legacySummary:Set( legacy );
			self.legacySummary:SetVisible( legacy ~= nil );
		end 
	);

	self.itemSelector = Equendil.LIP.ItemSelector(); -- item selection control
	self.itemSelector:SetParent( self.panel );
	self.itemSelector:SetPosition( 70, 20 );

	self.legacySummary = Equendil.LIP.LegacySummary(); -- list of values / rank for a given legacy at its set tier
	self.legacySummary:SetParent( self.panel );
	self.legacySummary:SetPosition( 380, 102 );
	self.legacySummary:SetVisible( false );

	self.expChart = Equendil.LIP.ExpChart();
	self.expChart:SetParent( self.panel );
	self.expChart:SetPosition( 380, 102 );
	self.expChart:SetVisible( false );
	
	-- main actions
	self.backgroundActions = Turbine.UI.Control();
	self.backgroundActions:SetParent( self );
	self.backgroundActions:SetSize( OrigWidth, 20 );
	self.backgroundActions:SetPosition( 0, 540 );
	self.backgroundActions:SetMouseVisible( false );
	
	self.buttonSave = Turbine.UI.Lotro.Button();
	self.buttonSave:SetParent( self.backgroundActions );
	self.buttonSave:SetSize( 120, 20 );
	self.buttonSave:SetPosition( 300, 0 );
	self.buttonSave:SetText( L["Save"] );
	self.buttonSave.Click = function( sender, args ) self:SaveCurrent() end;
	
	self.buttonSaveAll = Turbine.UI.Lotro.Button();
	self.buttonSaveAll:SetParent( self.backgroundActions );
	self.buttonSaveAll:SetSize( 120, 20 );
	self.buttonSaveAll:SetPosition( 420, 0 );
	self.buttonSaveAll:SetText( L["Save All"] );
	self.buttonSaveAll.Click = function( sender, args ) self:SaveAll() end;
	
	self.buttonReload = Turbine.UI.Lotro.Button();
	self.buttonReload:SetParent( self.backgroundActions );
	self.buttonReload:SetSize( 120, 20 );
	self.buttonReload:SetPosition( 540, 0 );
	self.buttonReload:SetText( L["Restore"] );
	self.buttonReload.Click = function( sender, args ) self:SetData( self.persistentData ) end;

	self.checkShowAtStart = Turbine.UI.Lotro.CheckBox();
	self.checkShowAtStart:SetParent( self.backgroundActions );
	self.checkShowAtStart:SetSize( 20, 20 );
	self.checkShowAtStart:SetPosition( 40, 0 );
	self.checkShowAtStart:SetChecked( self.showAtStart );
	
	self.labelShowAtStart = Equendil.UI.CommonControl.LabelFieldHeading( L["Show when started"] );
	self.labelShowAtStart:SetParent( self.backgroundActions );
	self.labelShowAtStart:SetSize( 190, 20 );
	self.labelShowAtStart:SetPosition( 60, 0 );

	self.classSelector:Select( self.classIndex );
	local callback = function( index ) 
		self.classIndex = index;
		self.tabIndex = 1;
		self.tabbedPanel:SelectTab( self.tabIndex );
		self:UpdateTabHeaders();
		self:ShowItem( self.classIndex, self.tabIndex );
	end
	self.classSelector.ClassSelected:Add( callback );
	
	self.tabbedPanel.Tabbed = function( tabIndex )
		self.tabIndex = tabIndex;
		self:ShowItem( self.classIndex, tabIndex );
	end
	
	self.classSelector:Select( self:_GetCurrentPlayerClassIndex() );
	self:LoadAll();

	if self.showAtStart then
		self:SetVisible( true );
	end
	
	self.checkShowAtStart.CheckedChanged = function( sender, args ) 
		self.showAtStart = self.checkShowAtStart:IsChecked();
		self:SaveSettings();
	end
	
	self.PositionChanged = function( sender, args ) self:SaveSettings(); end
	self.resizer.Resized = function() self:SaveSettings(); end
end

function App:SetSize( width, height )
	Turbine.UI.Window.SetSize( self, width, height );
	self:_DoLayout();
end

function App:SetWidth( width )
	Turbine.UI.Window.SetWidth( self, width );
	self:_DoLayout();
end

function App:SetHeight( height )
	Turbine.UI.Window.SetHeight( self, height );
	self:_DoLayout();
end

function App:_DoLayout()
	if self.backgroundActions == nil then return end -- not initialized yet

	local width, height = self:GetSize();

	
	self.backgroundActions:SetPosition( 0, height - 30 );
	self.tabbedPanel:SetSize( width - 13, height - 138 );
	local panelWidth = self.panel:GetWidth();
	local panelHeight = self.panel:GetHeight();
	self.controlItemFooter:SetPosition( 15, panelHeight - 31 );
	self.legacyConfigurator:SetSize( panelWidth - 271, panelHeight - 140 );
	self.legacySelector:SetSize( panelWidth - 271, panelHeight - 140 );
	self.legacySummary:SetPosition( panelWidth - 244, 102 );
	self.expChart:SetPosition( panelWidth - 244, 102 );
end

function App:_GetCurrentPlayerClassIndex()
	local player = Turbine.Gameplay.LocalPlayer.GetInstance();
	local classIndex = ClassIndices[player:GetClass()] or 1;
	return classIndex;
end

-- true if selecting, false if not
function App:_SetSelectionMode( flag ) 
	local buttonText = { [true] = L["Done..."], [false] = L["Select..."] };
	self.buttonPickLegacies:SetText( buttonText[flag] );
	if flag then 
		self.legacySelector:SetSize( self.panel:GetWidth() - 271, self.panel:GetHeight() - 140 );
	end
	self.legacySelector:SetVisible( flag );
	self.legacyConfigurator:SetVisible( not flag );
	self.selecting = flag;
end

function App:_ToggleSelectionMode()
	if self.selecting then
		self.legacyConfigurator:UpdateLegacies();
	end

	self:_SetSelectionMode( not self.selecting );
end

function App:NewLegendaryItem( itemData )
	local item = Equendil.LIP.LegendaryItem( itemData );
	item:SetLevelToUse( 85 ); 
	item:SetLevel( 70 );
	item:SetAge( 3 );

	return item;
end

function App:UpdateCurrent()
	self:ShowItem( self.classIndex, self.tabIndex );
	self:UpdateTabHeader( self.tabIndex );
end

function App:ShowItem( classIndex, tabIndex )
	self.classIndex = classIndex;
	self.tabIndex = tabIndex;

	self:_SetSelectionMode( false );
	self.legacySelector:Clear();
	
	local legendaryItem = self.legendaryItems[classIndex][tabIndex]; -- might be nil
	
	-- show/hide the various controls depending if we have a legendary item here
	self.controlItem:SetVisible( legendaryItem ~= nil );
	self.controlItemFooter:SetVisible( legendaryItem ~= nil );
	self.buttonSave:SetVisible( legendaryItem ~= nil );
	self.buttonPickLegacies:SetVisible( legendaryItem ~= nil );
	self.buttonMaxTiers:SetVisible( legendaryItem ~= nil );
	self.itemSelector:SetVisible( legendaryItem == nil );
	
	-- setup the point display and configurator display, they can handle nil values
	self.controlItemFooter:SetItem( legendaryItem );
	self.legacyConfigurator:SetLegendaryItem( legendaryItem );
	
	if legendaryItem ~= nil then
		-- if we have a legendary item to display, populate the list of legacies for selection
		local legacies = legendaryItem:GetLegacies();
		for k, v in pairs( legacies) do 
			if not v:IsDefault() then
				self.legacySelector:AddLegacy( v );
			end
		end

		-- set up the main item control 
		local iconKey = ClassesInfo[classIndex].iconLegKeys[self.legendaryItemIndex[legendaryItem]];
		self.controlItem:SetItem( legendaryItem, iconKey );
		
		self.itemSelector.Selected = nil; -- remove callback from the item selection control
	else
		-- we don't have a legendary item in this tab, setup the item selector, clear the main item control
		self.controlItem:SetItem( nil ); -- 
		self.itemSelector:Set( self.classIndex );
		self.itemSelector.Selected = function( itemIndex )
			local class = ClassesInfo[self.classIndex];
			local newItem = self:NewLegendaryItem( class.legendaryItems[itemIndex] );
			self.legendaryItemIndex[newItem] = itemIndex;
			self.legendaryItems[self.classIndex][self.tabIndex] = newItem;
			self:UpdateCurrent();
		end
	end
end

function App:UpdateTabHeader( index )
	local item = self.legendaryItems[self.classIndex][index];
	if item ~= nil then
		local itemIndex = self.legendaryItemIndex[item];
		self.tabbedPanel:SetBackdrop( index, Equendil.LIP.Icon.LITabHeaderBig[ClassesInfo[self.classIndex].iconLegKeys[itemIndex]] );
	else
		self.tabbedPanel:SetBackdrop( index, nil );
	end
end

function App:UpdateTabHeaders()
	for i = 1, 10 do 
		self:UpdateTabHeader(i);
	end
end

function App:_Delete( classIndex, slotIndex )
	local item = self.legendaryItems[classIndex][slotIndex];
	if item ~= nil then
		self.legendaryItemIndex[item] = nil;
		self.legendaryItems[classIndex][slotIndex] = nil;
		if classIndex == self.classIndex and slotIndex == self.tabIndex then
			self:UpdateCurrent();
		end
	end
end

function App:ClearAll()
	for i = 1, #ClassesInfo do
		for j = 1, 10 do 
			self:_Delete( i, j );
		end
	end
end

function App:SetData( data )
	if data == nil then return end;
	self:ClearAll();
	for i = 1, #ClassesInfo do
		for j = 1, 10 do 
			if data[i][j] ~= nil then
				local newItem = self:NewLegendaryItem( ClassesInfo[i].legendaryItems[data[i][j].index] );
				self.legendaryItemIndex[newItem] = data[i][j].index;
				self.legendaryItems[i][j] = newItem;
				newItem:SetData( data[i][j].data );
			end
		end
	end
	self:UpdateTabHeaders();
	self:UpdateCurrent();
end

function App:GetDataAt( class, tab )
	local data = nil;
	if self.legendaryItems[class][tab] ~= nil then
		data = {};
		data.index = self.legendaryItemIndex[self.legendaryItems[class][tab]];
		data.data = self.legendaryItems[class][tab]:GetData();
	end
	return data;
end

function App:GetData()
	local data = {};
	for i = 1, #ClassesInfo do
		data[i] = {};
		for j = 1, 10 do
			data[i][j] = self:GetDataAt( i, j );
		end
	end
	return data;
end

function App:SaveAll()
	self.persistentData = self:GetData();
	
	Equendil.Utils.PluginData.Save(Turbine.DataScope.Server, StorageKey, self.persistentData, function() end ); 
end

function App:SaveCurrent()
	if self.persistentData == nil then
		self.persistentData = {};
		for i = 1, #ClassesInfo do
			self.persistentData[i] = {};
		end
	end
	self.persistentData[self.classIndex][self.tabIndex] = self:GetDataAt( self.classIndex, self.tabIndex );
	function dataSaved() end -- data is saved, nothing more to do ....
	Equendil.Utils.PluginData.Save( Turbine.DataScope.Server, StorageKey, self.persistentData, function() end );
end

function App:SaveSettings()
	local data = {};
	data.showAtStart = self.showAtStart;
	data.windowPosition = {};
	data.windowPosition.left, data.windowPosition.top = self:GetPosition();
	data.windowSize = {};
	data.windowSize.width, data.windowSize.height = self:GetSize();
	Equendil.Utils.PluginData.Save( Turbine.DataScope.Account, StorageKey .. "_Settings", data, function() end );
end

function App:LoadAll( data )
	function dataLoaded( data )
		self:SetData( data );
		self.persistentData = data;
	end

	function settingsLoaded( data )
		if data ~= nil then
			self.showAtStart = data.showAtStart;
			self.checkShowAtStart:SetChecked( self.showAtStart );
			if data.windowSize ~= nil then
				self:SetSize( data.windowSize.width, data.windowSize.height );
			else
				self:_DoLayout();
			end
			local left = Equendil.Utils.Maths.constrain( 0, data.windowPosition.left, Turbine.UI.Display.GetWidth() - self:GetWidth() );
			local top = Equendil.Utils.Maths.constrain( 0, data.windowPosition.top, Turbine.UI.Display.GetHeight() - self:GetHeight() );
			self:SetPosition( left, top );
		else
			self:_DoLayout();
		end
	end
	
	Equendil.Utils.PluginData.Load( Turbine.DataScope.Server, StorageKey, dataLoaded );
	Equendil.Utils.PluginData.Load( Turbine.DataScope.Account, StorageKey .. "_Settings", settingsLoaded );
end