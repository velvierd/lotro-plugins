import "Turbine.UI";
import "Equendil.UI.Bar";
import "Equendil.UI.DragBox";
import "Equendil.Utils.Event";
import "Equendil.UI.QuickSlot";
import "Equendil.UI.WindowManager";

-- enums
Mode = { None = 0, Normal = 1, Collapsible = 2, Selection = 3, MouseOver = 4 };-- Modes
Direction = { None = 0, Up = 1, Right = 2, Down = 3, Left = 4 }; -- Direction

QuickBar = class( Turbine.Object );
function QuickBar:Constructor()
	Turbine.Object( self );

	self.Changed = Equendil.Utils.Event(); -- Event

	self.size = 0;
	self.slots = {};
	self.isCollapsed = false;
	self.mode = Mode.Normal;
	self.direction = Direction.Right; 
	self.forcedExpansion = false;
	self.locked = false;
	self.forcedLock = false;
	
	-- make a new physical bar
	self.bar = Equendil.UI.Bar();
	self.bar:SetPosition( 0, Turbine.UI.Display:GetHeight() / 2 ); -- TODO be smart about finding a starting location
	self.bar:SetScale( 1.0 );
	self.bar:SetVisible( true );
	self.bar:SetText( "" );
	
	-- attach a drag bar to it for repositioning (CTRL+\)
	self.dragBox = Equendil.UI.DragBox( self.bar );
	Equendil.UI.WindowManager:ManageDragBar( self.dragBox ); -- let the Window Manager handle our drag bar
	-- self.dragBox.Repositioned = function() 
		-- we do not want to call the Changed() event immediately, as we might be in a 'fake' expanded status, and the position would be wrong
	-- end

	-- add a callback to set the scale of the bar through mouse wheeling
	self.dragBox.Scroll = function( direction ) 
		if direction > 0 then
			self:SetScale( math.min( self:GetScale() + 0.10, 1 ) );
		else
			self:SetScale( math.max( self:GetScale() - 0.10, 0.5 ) );
		end
	end
	
	-- create a slot for use in collapsible/selection bars
	self.mainSlot = self:_NewSlot();
	-- self.mainSlot:SetBackColor( Turbine.UI.Color( 0.7, 0.7, 0.7, 1 ) );
	-- self.mainSlot:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.mainSlot:SetUseOnRightClick( false ); -- we only ever want the main slot to be activable with the left mouse button, whatever the mode

	-- setup a control that will overlap the main slot to intercept left mouse clicks when we don't want that slot to be used (collapsible mode)...
	self.overlapControl = Turbine.UI.Control();
	self.overlapControl:SetSize( 0, 0 );
	self.overlapControl:SetMouseVisible( false );
	self.overlapControl:SetAllowDrop( true );
	self.overlapControl:SetBackground( "Equendil/UI/images/toggleslotoverlay.tga" );
	self.overlapControl:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );

	-- self.overlapControl:SetBackColor( Turbine.UI.Color( 0.15, 1, 0, 0 ) );
	-- self.overlapControl:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.overlapControl.MouseClick = function(sender, args) self:_OverlapClick( args ) end
	self.overlapControl.DragDrop = function(sender, args) self:_DragDropMain( args ) end

	-- set up callbacks for collapsible bars on mouse over	
	self.overlapControl.DragEnter = function( sender, args )
		if self.mode == Mode.MouseOver then
			self:Expand();
		end
	end

	self.bar.MouseEnter = function( sender, args ) 
		if self.mode == Mode.MouseOver then 
			self:Expand();
		end
	end
	
	self.bar.MouseLeave = function( sender, args )
		if self.mode == Mode.MouseOver then 
			self:Collapse();
		end
	end
end

-- seems to be tricky to get the garbage collector to pick up the trash, so we define a Dispose() method to be called to get rid of resources
function QuickBar:Dispose()
	for _, slot in ipairs( self.slots ) do
		slot.ShortcutChanged = nil;
		slot.Clicked = nil;
	end
	self.slots = nil;
	self.dragBox:Dispose();
	self.dragBox = nil;
	self.bar:SetVisible(false);
	self.bar = nil;
	self.mainSlot = nil;
	self.overlapControl = nil;
	self.Changed = nil;
end

-- some straight forward accessors 
function QuickBar:GetName()	return self.bar:GetText(); end
function QuickBar:GetDirection() return self.direction; end
function QuickBar:GetSize()	return self.size; end
function QuickBar:GetMode()	return self.mode; end

function QuickBar:Toggle()
	self.isCollapsed = not self.isCollapsed;
	self:Update();
	self.Changed();
end

function QuickBar:Expand()
	self.isCollapsed = false;
	self:Update();
	self.Changed();
end

function QuickBar:Collapse()
	self.isCollapsed = true;
	self:Update();
	self.Changed();
end
	
function QuickBar:SetName( name )
	self.bar:SetText( name );
	self.Changed();
end

function QuickBar:ForceExpansion( flag )
	self.forcedExpansion = flag;
	self:Update();
end

function QuickBar:SetMode( mode )
	if mode ~= self.mode then
		self.mode = mode;
		self:Update();
		self.Changed();
	end
end

function QuickBar:SetScale( scale )
	if scale ~= self.bar:GetScale() then
		self.bar:SetScale( scale );
		self.Changed();
	end
end

function QuickBar:GetScale()
	return self.bar:GetScale();
end

-- lock bar so quickslots can't be cleared (dragged out or replaced)
function QuickBar:Lock( flag )
	if self.locked ~= flag then 
		self.locked = flag;
		self:_UpdateLocks();
		self.Changed();
	end
end

-- force bar to be unlocked regardless of its normal "lock" status
function QuickBar:ForceUnlock( flag )
	if self.forcedUnlock ~= flag then
		self.forcedUnlock = flag;
		self:_UpdateLocks();
	end
end

-- update lock of every slot
function QuickBar:_UpdateLocks()
	for _, slot in ipairs( self.slots ) do
		slot:Lock( self.locked and not self.forcedUnlock );
	end
	
	self.mainSlot:Lock( self.locked and not self.forcedUnlock );
end

-- return whether or not the bar is locked
function QuickBar:IsLocked()
	return self.locked;
end

-- set in which direction the bar points
function QuickBar:SetDirection( direction )
	self.direction = direction;

	-- translate direction for the underlying bar window
	local t = {
		[Direction.Right] = { orientation = Turbine.UI.Orientation.Horizontal, anchor = Equendil.UI.Anchor.Beg},
		[Direction.Left] = { orientation = Turbine.UI.Orientation.Horizontal, anchor = Equendil.UI.Anchor.End},
		[Direction.Down] = { orientation = Turbine.UI.Orientation.Vertical, anchor = Equendil.UI.Anchor.Beg},
		[Direction.Up] = { orientation = Turbine.UI.Orientation.Vertical, anchor = Equendil.UI.Anchor.End} };
	self.bar:SetOrientation( t[direction].orientation );
	self.bar:SetAnchor( t[direction].anchor );

	self:Update();
	self.Changed();
end

-- set the number of (normal) slots in the bar
function QuickBar:SetSize( size )
	if size == self.size then return end
	
	-- remove slots if smaller
	for i = size + 1, self.size, 1 do 
		self.slots[i].ShortcutChanged = nil;
		self.slots[i]:SetVisible( false );
		self.slots[i] = nil;
	end
	
	-- add new slots if bigger
	for i = self.size + 1, size do
		self.slots[i] = self:_NewSlot();
	end
	
	self.size = size;
	self:Update();
	self.Changed();
end

-- create & setup a new slot
function QuickBar:_NewSlot()
	local slot = Equendil.UI.QuickSlot();
	slot.ShortcutChanged = function( sender, args )	self.Changed(); end
	slot.Clicked = function( button ) self:_SlotClicked( slot, button ); end
	slot:Lock( self.locked and not self.forcedUnlock );
	return slot;
end

-- call back for when a slot is clicked
function QuickBar:_SlotClicked( slot, button )
	-- if the mainslot was clicked, check what mode we're in and toggle accordingly
	if slot == self.mainSlot then
		if self.mode == Mode.Collapsible or ( self.mode == Mode.Selection and button == Turbine.UI.MouseButton.Right ) then
			self:Toggle();
		end
		return;
	end
	
	-- ignore any click if we're not in selection mode
	if self.mode ~= Mode.Selection then return end;

	-- clone the shortcut clicked to the main slot if it's not empty, and collapse the bar
	local shortcut = slot:GetShortcut();
	if shortcut ~= nil and shortcut:GetType() ~= Turbine.UI.Lotro.ShortcutType.Undefined  then
		self.mainSlot:SetShortcut( shortcut );
		self:Collapse();
	end
end

-- shortcut drag&dropped to the overlapping control
function QuickBar:_DragDropMain( args )
	-- we should be in collapsible mode, copy to the main slot as a mean to give it an "icon"
	local shortcut = args.DragDropInfo:GetShortcut();
	if shortcut ~= nil then
		self.mainSlot:SetShortcut( shortcut );
	else
		Turbine.Log:Information( "Nil" );
	end
end

-- Overlap control was clicked,
function QuickBar:_OverlapClick( args )
	-- if we're here, we should be in collapsible mode, toggle the bar
	self:Toggle();
end

-- Assign where every slot goes on the physical bar
function QuickBar:Update()
	-- if we're in collapsible or selection mode, the bar will have an additional slot ...
	local shift = 0;
	if self.mode == Mode.Collapsible or self.mode == Mode.Selection or self.mode == Mode.MouseOver then
		shift = 1;
	end

	-- setup a function that computes the actual position of a given slot on the physical bar, simply reverses the order if the bar is pointing up or left
	local position = nil;
	if self.direction == Direction.Right or self.direction == Direction.Down then
		position = function( index ) return index + shift end
	else
		position = function( index ) return self.size - index + 1 end
	end

	local mainSlotPos = 0;
	self.bar:Clear();
	if self.isCollapsed and not self.forcedExpansion then
		-- if the bar is collapsed, just setup the mainslot
		self.bar:SetDimension( 1 );
		self.bar:SetControl( 1, self.mainSlot );
		mainSlotPos = 1;
	else
		-- if not collapsed, set every slot in the right position, and add the mainslot depending on mode
		self.bar:SetDimension( self.size + shift );
		for i = 1, self.size do
			self.bar:SetControl( position(i), self.slots[i] );
		end
		if self.mode == Mode.Collapsible or self.mode == Mode.Selection or self.mode == Mode.MouseOver then
			mainSlotPos = position(0);
			self.bar:SetControl( mainSlotPos, self.mainSlot );
		end
	end
	
	-- if in collapsible mode, add the overlap control to intercept clicks on the main slot, if not, reset it
	if self.mode == Mode.Collapsible or self.mode == Mode.MouseOver then
		self.bar:SetOverlapControl( mainSlotPos, self.overlapControl );
		self.overlapControl:SetMouseVisible( true );
		self.mainSlot:SetMouseVisible( false );
	elseif self.mode == Mode.Selection  then
		self.bar:SetOverlapControl( mainSlotPos, self.overlapControl );
		self.overlapControl:SetMouseVisible( false );
		self.mainSlot:SetMouseVisible( true );
	else
		self.bar:SetOverlapControl( 0, nil );
		self.overlapControl:SetMouseVisible( false );
		self.overlapControl:SetSize( 0, 0 );
		self.mainSlot:SetMouseVisible( true );
	end
end

-- setup a bar with raw data
function QuickBar:Deserialize( data )
	self.isCollapsed = data.isCollapsed;
	self:SetName( data.name );
	self:SetSize( data.size );
	self:SetMode( data.mode );
	self:SetDirection( data.direction );
	self.bar:SetScale( data.scale );
	self.bar:SetAnchorPosition( data.position.left, data.position.top );
	
	local function setSlotData( slot, data )
		local shortcut = Turbine.UI.Lotro.Shortcut( data.type, data.data );
		slot:SetShortcut( shortcut );
	end
	
	setSlotData( self.mainSlot, data.mainShortcut );
	for k, v in pairs( data.shortcuts ) do
		setSlotData( self.slots[k], v );
	end
	self:Lock( data.isLocked or false );
	self:Update();
	self.Changed();
end

-- get raw data from the bar 
function QuickBar:Serialize()
	local left, top = self.bar:GetAnchorPosition();
	local t = {
		isCollapsed = self.isCollapsed,
		name = self:GetName(),
		size = self.size,
		mode = self.mode,
		direction = self.direction,
		position = { left = left, top = top};
		scale = self.bar:GetScale(),
		isLocked = self.locked,
	};

	function shortcutData( slot )
		if slot ~= nil then
			local shortcut = slot:GetShortcut();
			if shortcut ~= nil then
				local shortcutData = {};
				shortcutData.type = shortcut:GetType();
				shortcutData.data = shortcut:GetData();
				return shortcutData;
			end
		end
		return nil;
	end
	
	t.mainShortcut = shortcutData( self.mainSlot );
	
	t.shortcuts = {};
	for i = 1, self.size, 1 do
		t.shortcuts[i] = shortcutData( self.slots[i] );
	end
	
	return t;
end
