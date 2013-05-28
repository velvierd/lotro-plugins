
import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI.Extensions";

CombatQuickslotBar = class( Turbine.UI.Extensions.SimpleWindow );

function CombatQuickslotBar:Constructor()
	Turbine.UI.Extensions.SimpleWindow.Constructor( self );
	
	self.spacing = 5;
	self.quickslotCount = 0;
	self.quickslotSize = 36;
	self.quickslots = { };
	
	self.menuButton = Turbine.UI.Control()
	self.menuButton:SetParent( self );
	self.menuButton:SetBackground( "TurbinePlugins/CombatQuickslots/Resources/DownArrow.tga" );
	self.menuButton:SetSize( 14, 13 );
	
	self.menuButton.MouseDown = function( sender, args )
		local contextMenu = Turbine.UI.ContextMenu()
		
		local sizeMenu = Turbine.UI.MenuItem( "Size" );
		local sizeMenuItems = sizeMenu:GetItems();
		
		local i;
		
		for i = 1, 15, 1 do
			local sizeItem = Turbine.UI.MenuItem( tostring( i ) );
			
			if ( self.quickslotCount == i ) then
				sizeItem:SetChecked( true );
			end
			
			sizeItem.Click = function( sender, args )
				local newCount = tonumber( sender:GetText() );
				self:SetQuickslotCount( newCount );
				self.settings.QuickslotCount = newCount;
				self:SaveSettings();
			end
			
			sizeMenuItems:Add( sizeItem );
		end
		
		local contextMenuItems = contextMenu:GetItems();
		contextMenuItems:Add( sizeMenu );
		contextMenu:ShowMenu();
	end
	
	self.quickslotInfo = { };
	
	self:LoadSettings();
		
	self:SetVisible( true );
	self:SetOpacity( 1 );

	-- Hook up the visibility of the quickslot bar to only show when
	-- the player is in combat.
	self.player = Turbine.Gameplay.LocalPlayer.GetInstance();
	
	self.player.InCombatChanged = function( sender, args )
		self:SetVisible( self.player:IsInCombat() );
	end
end

function CombatQuickslotBar:LoadSettings()
	Turbine.PluginData.Load( Turbine.DataScope.Character, "CombatQuickslotBarSettings",
		function( settings )
			self.settings = settings;
			
			if ( type( self.settings ) ~= "table" ) then
				self.settings = { };
			end
			
			if ( not self.settings.QuickslotCount ) then
				self.settings.QuickslotCount = 5;
			end
			
			self:SetQuickslotCount( self.settings.QuickslotCount );
			self:LoadQuickslots();
		end
	);
end

function CombatQuickslotBar:SaveSettings()
	Turbine.PluginData.Save( Turbine.DataScope.Character, "CombatQuickslotBarSettings", self.settings );
end

function CombatQuickslotBar:SetQuickslotCount( value )
	local oldCount = self.quickslotCount;
	local newCount = value;
	local i;
	
	self.quickslotCount = value;

	-- Remove any quickslots no longer required.
	for i = newCount + 1, oldCount, 1 do
		self.quickslots[i]:SetVisible( false );
		self.quickslots[i]:SetParent( nil );
		self.quickslots[i] = nil;
	end
	
	-- Add any new quickslots that should be created.
	for i = oldCount + 1, newCount, 1 do
		self.quickslots[i] = Turbine.UI.Lotro.Quickslot();
		self.quickslots[i]:SetParent( self );
		self.quickslots[i]:SetSize( self.quickslotSize, self.quickslotSize );
		self.quickslots[i]:SetPosition( ( i - 1 ) * ( self.quickslotSize + self.spacing ), 0 );

		self.quickslots[i].ShortcutChanged = function( sender, args )
			local shortcut = sender:GetShortcut();

			self.quickslotInfo[i] = { };
			self.quickslotInfo[i].Type = shortcut:GetType();
			self.quickslotInfo[i].Data = shortcut:GetData();

			self:SaveQuickslots();
		end
	end

    -- Reload quickslot information.
	self:RefreshQuickslots();

	local displayWidth = Turbine.UI.Display:GetWidth();
	local displayHeight = Turbine.UI.Display:GetHeight();

	local width = self.quickslotCount * self.quickslotSize + ( self.quickslotCount - 1 ) * self.spacing;

	self:SetSize( width, self.quickslotSize + 22 );
	self:SetPosition( ( displayWidth - width ) / 2, displayHeight * 2 / 3 );

	self.menuButton:SetPosition( ( width - self.menuButton:GetWidth() ) / 2, self.quickslotSize + 2 );
end

function CombatQuickslotBar:LoadQuickslots()
	if ( self.loading ) then
		return;
	end

	-- Suspend saving while loading.
	self.loading = true;

	Turbine.PluginData.Load( Turbine.DataScope.Character, "CombatQuickslots",
		function( quickslotInfo )
			if ( type( quickslotInfo ) ~= "table" ) then
				self.quickslotInfo = { };
			else
				self.quickslotInfo = quickslotInfo;
			end
			
			self:RefreshQuickslots();
			
			self.loading = false;
		end
	);
end

function CombatQuickslotBar:SaveQuickslots()
	if ( self.loading ) then
		return;
	end

	Turbine.PluginData.Save( Turbine.DataScope.Character, "CombatQuickslots", self.quickslotInfo );
end

function CombatQuickslotBar:RefreshQuickslots()
	for i = 1, self.quickslotCount, 1 do	
		local shortcut = self.quickslotInfo[i]
		
		if ( shortcut ~= nil and self.quickslots[i] ~= nil ) then
			local shortcut = Turbine.UI.Lotro.Shortcut( shortcut.Type, shortcut.Data );
			self.quickslots[i]:SetShortcut( shortcut );
		else
			--self.quickslots[i]:SetShortcut( nil );
		end
	end
end
