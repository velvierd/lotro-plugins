import "Turbine";
import "Turbine.UI";


--[[
	-- define BuffMonitorWindow
--]]

BuffMonitorWindow = class( Turbine.UI.Window );

function BuffMonitorWindow:Constructor( tSettings )
	Turbine.UI.Window.Constructor( self );

	self.settings = tSettings;
	
	self:SetPosition( self.settings.left, self.settings.top );
	self:SetSize( self.settings.width, self.settings.height );
	--self:SetVisible( self.settings.visible );

	-- attach a dragbar to the main window
	self.DragBar = PTweety.BuffMonitor.UI.DragBar( self, "BuffMonitor" );
	self.DragBar:SetRotator( true );
	self.DragBar:SetRotatorOffset( 3, 20 );
	self.DragBar:Refresh();

	self.KeyDown = function( sender, args )
		if ( args.Action == 0x100000B3 ) then
			sender:SetVisible( false ) 
		end
		if ( args.Action == Turbine.UI.Lotro.Action.Escape ) then
			sender:SetVisible( false ) 
		end
	end

	self.PositionChanged = function( sender, args )
		self.settings.left, self.settings.top = self:GetPosition();
		self.DragBar:Refresh();
		Settings.Save();
	end

	self.SizeChanged = function( sender, args )
		self.settings.width, self.settings.height	= self:GetSize();
		self:SetPosition( PTweety.BuffMonitor.Utils.ValidatePosition( self.settings.left, self.settings.top, self.settings.width, self.settings.height ) );
		self.EffectGroupListBox:SetSize( self.settings.width, self.settings.height );
		self.DragBar:Refresh();
		self:Refresh();
		Settings.Save();
	end

	self.VisibleChanged = function( sender, args )
		self.settings.visible = self:IsVisible();
		Settings.Save();
	end

	self.MouseEnter = function( sender, args )
		if ( self.DragBar:IsDraggable() ) then
			self:SetMouseVisible( false );
			self.DragBar:CreateHoverBox();
		end
	end

	self.MouseLeave = function( sender, args )
		if ( not self.DragBar:IsBeingDragged() ) then
			self.DragBar:DestroyHoverBox();
			self:SetMouseVisible( true );
		end
	end

	-- EffectGroupListBox
	self.EffectGroupListBox = Turbine.UI.ListBox();
	self.EffectGroupListBox:SetParent( self );
	self.EffectGroupListBox:SetVerticalScrollBar( self.EffectGroupListBoxScrollBar );
	self.EffectGroupListBox:SetOrientation( Turbine.UI.Orientation.Horizontal );

	self.EffectGroupListBox.SetMaxItemsPerLine = function( )
		if ( self.settings.orientation == Turbine.UI.Orientation.Horizontal ) then
			Turbine.UI.ListBox.SetMaxItemsPerLine( self.EffectGroupListBox, #self.settings.groups or 1 );
		else
			Turbine.UI.ListBox.SetMaxItemsPerLine( self.EffectGroupListBox, 1 );
		end
	end

	self.EffectGroupListBox.SizeChanged = function( sender, args )
		self.EffectGroupListBox:SetMaxItemsPerLine();
	end

	for i = 1, #self.settings.groups do
		local cEffectGroupHandle = PTweety.BuffMonitor.EffectGroupHandle( self, self.settings.groups[i], i );

		cEffectGroupHandle:SetParent( self.EffectGroupListBox );
		cEffectGroupHandle:SetSize(); -- has fixed size

		self.EffectGroupListBox:AddItem( cEffectGroupHandle );
	end
	
	self:Refresh();
end

function BuffMonitorWindow:Destroy()
	for i=1, self.EffectGroupListBox:GetItemCount() do
		self.EffectGroupListBox:GetItem( i ):Destroy();
	end
	self.EffectGroupListBox = nil;

	self.KeyDown = nil;
	self.PositionChanged = nil;
	self.SizeChanged = nil;
	self.VisibleChanged = nil;
	self.MouseEnter = nil;
	self.MouseLeave = nil;
end


--[[
	-- handle events from DragBar
--]]

function BuffMonitorWindow:Rotate()
	if ( self.settings.orientation == Turbine.UI.Orientation.Horizontal ) then
		self.settings.orientation = Turbine.UI.Orientation.Vertical;
	else
		self.settings.orientation = Turbine.UI.Orientation.Horizontal;
	end

	self:Refresh();
end


--[[
	-- handle EffectGroupHandles
--]]

function BuffMonitorWindow:AddEffectGroupHandle()
	-- add default EffectItem
	table.insert( self.settings.groups, { window = PTweety.BuffMonitor.Utils.DeepCopy( Settings.defaults.EffectGroupWindow ) } );
	local cEffectGroupHandle = PTweety.BuffMonitor.EffectGroupHandle( self, self.settings.groups[#self.settings.groups], #self.settings.groups );

	cEffectGroupHandle:SetParent( self.EffectGroupListBox );
	cEffectGroupHandle:SetSize(); -- has fixed size

	self.EffectGroupListBox:AddItem( cEffectGroupHandle );

	self:Refresh();
	Settings.Save();
end

function BuffMonitorWindow:RemoveEffectGroupHandle( sender )
	table.foreach( self.settings.groups, function( k, v ) if ( v == sender.settings ) then table.remove( self.settings.groups, k ) end end );
	self.EffectGroupListBox:RemoveItem( sender );
	sender:Destroy();

	-- need to have at least one EffectGroupHandle in the list
	if ( #self.settings.groups == 0 ) then
		self:AddEffectGroupHandle();
	end

	self:Refresh();
	Settings.Save();
end

--[[
	-- BuffMonitorWindow functions
--]]

function BuffMonitorWindow:Refresh()
	if ( self.settings.orientation == Turbine.UI.Orientation.Horizontal ) then
		self:SetSize( Settings.defaults.BuffMonitorWindow.groups[1].width * ( #self.settings.groups or 1 ), Settings.defaults.BuffMonitorWindow.groups[1].height );
	else
		self:SetSize( Settings.defaults.BuffMonitorWindow.groups[1].width, Settings.defaults.BuffMonitorWindow.groups[1].height * ( #self.settings.groups or 1 ) );
	end
end
