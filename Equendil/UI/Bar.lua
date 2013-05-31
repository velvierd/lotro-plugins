import "Turbine.UI";
import "Equendil.Utils.Maths";
import "Equendil.UI.WindowManager";

-- "Bars" automatically layout controls added to them horizontally or vertically, and resize accordingly
-- An overlapping control can be added on top of another control at a given position.

Bar = class( Turbine.UI.Window );

-- Turbine slots are spaced 35 pixels apart and seem to be that size, however, they are not visually centered in a 35x35 box. 
local baseSlotSize = 35;
local DefaultSpacing = 0;

Anchor = { None = 0, Beg = 1, End = 2};

function Bar:Constructor()
	Turbine.UI.Window.Constructor( self );

	self.dimension = 12;
	self.orientation = Turbine.UI.Orientation.Horizontal;
	self.spacing = DefaultSpacing;
	self.scale = 1.0;
	self.anchor = Anchor.Beg;

	self.slots = {};
	self.overlapControl = nil;
	self.overlapIndex = 0;
	
	self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) ); -- I seem to get ghost images from controls if i don't set the background ...
	self:SetOpacity( 1.0 );
	WindowManager:ManageWindow( self, false ); -- Manage window for HUD toggle, no closing it on escape
	
	self:_DoLayout();
end

-- various straightfoward accessors
function Bar:SetScale( s )	self.scale = s;	self:_DoLayout(); end
function Bar:GetScale( s ) return self.scale; end
function Bar:SetSpacing( n ) self.spacing = n; self:_DoLayout(); end
function Bar:GetSpacing() return self.spacing; end
function Bar:SetOrientation( o ) self.orientation = o; self:_DoLayout(); end
function Bar:GetOrientation( o ) return self.orientation; end
function Bar:SetAnchor( anchor ) self.anchor = anchor; end
function Bar:GetAnchor() return self.anchor; end
function Bar:GetDimension()	return self.dimension; end
function Bar:GetControl( pos ) return self.slots[pos]; end

local function _ClearControl( control )
	if control == nil then return end;
	-- Possible problem setting parent to nil and making the slot invisible if reaffected again 
	control:SetParent( nil );
	control:SetVisible( false );
end

function Bar:Clear()
	for k, control in pairs( self.slots ) do
		_ClearControl( control );
		self.slots[k] = nil;
	end
end

-- Set <control> in the bar at position <pos>
function Bar:SetControl( pos, control )
	self.slots[pos] = control;
	self.slots[pos]:SetParent( self );
	self.slots[pos]:SetVisible( true );
	
	self:_DoSlotLayout( self.slots[pos], pos );
end

-- Set a control that will overlap another at position <pos>
function Bar:SetOverlapControl( pos, control )
	self.overlapControl = control;
	self.overlapIndex = pos;

	if control ~= nil then
		control:SetParent( self );
		control:SetVisible( true );
	end
	
	self:_DoSlotLayout( self.overlapControl, self.overlapIndex );
end

-- Remove a control from the bar at position <pos>
function Bar:RemoveControl( pos )
	if self.slots[pos] == nil then return end
	
	_ClearControl( self.slots[pos] );
	self_DoLayout();
end

-- swaps values depending on the orientation of the bar
function Bar:_Orientate( a, b )
	if self.orientation == Turbine.UI.Orientation.Horizontal then
		return a, b;
	end
	return b, a;
end

function Bar:_VirtualLength( dimension )
	return ( ( dimension * ( baseSlotSize + self.spacing ) ) - self.spacing );
end

-- computes the physical length of the bar
function Bar:_PhysicalLength( dimension )
	return self:_VirtualLength( dimension ) * self.scale;
end

-- Set the number of elements in the bar
function Bar:SetDimension( d )
	if d == self.dimension then return end

	-- reset some slots if the bar was stretched
	for i = d + 1, self.dimension, 1 do 
		if self.slots[i] ~= nil then 
			_ClearControl( self.slots[i] );
			self.slots[i] = nil;
		end
	end

	-- reposition the bar if needed	
	if self.anchor == Anchor.End then 
		if self.orientation == Turbine.UI.Orientation.Horizontal then
			self:SetLeft( self:GetLeft() + self:_PhysicalLength( self.dimension ) - self:_PhysicalLength( d ) );
		else
			self:SetTop( self:GetTop() + self:_PhysicalLength( self.dimension ) - self:_PhysicalLength( d ) );
		end
	end

	self.dimension = d;
	
	self:_DoLayout();
end

function Bar:SetAnchorPosition( left, top )
	if self.anchor == Anchor.End then
		if self.orientation == Turbine.UI.Orientation.Horizontal then
			self:SetPosition( left - self:_PhysicalLength( self.dimension - 1 ), top );
		else
			self:SetPosition( left, top - self:_PhysicalLength( self.dimension - 1 ) );
		end
	else
		self:SetPosition( left, top );
	end
end

function Bar:GetAnchorPosition()
	if self.anchor == Anchor.End then
		if self.orientation == Turbine.UI.Orientation.Horizontal then
			return self:GetLeft() + self:_PhysicalLength( self.dimension - 1 ), self:GetTop();
		else
			return self:GetLeft(), self:GetTop() + self:_PhysicalLength( self.dimension - 1 );
		end
	else
		return self:GetPosition();
	end
end

-- position & resisze individual slots
function Bar:_DoSlotLayout( slot, pos )
	if slot == nil then return end
	
	local a = ( ( pos - 1 ) * ( baseSlotSize + self.spacing ) );
	local b = 0;
	slot:SetPosition( self:_Orientate( a, b ) );

	slot:SetSize( baseSlotSize, baseSlotSize );
end

-- Recompute the position and size of the bar and its controls
-- scale is handled by setting up everything as if in 1:1 scale with no StretchMode, then resizing the whole window in StretchMode 1
function Bar:_DoLayout()
	self:SetStretchMode( 0 );

	local a = self:_VirtualLength( self.dimension );
	local b = baseSlotSize;
	self:SetSize( self:_Orientate( a, b ) );

	-- reposition if outside the display
	local left = Equendil.Utils.Maths.constrain( 0, self:GetLeft(), Turbine.UI.Display:GetWidth() - self:GetWidth() );
	local top = Equendil.Utils.Maths.constrain( 0, self:GetTop(), Turbine.UI.Display:GetHeight() - self:GetHeight() );
	self:SetPosition( left, top );
	
	-- Compute & set the positions of every slot
	for i = 1, self.dimension, 1 do 
		self:_DoSlotLayout( self.slots[i], i );
	end

	-- compute & set the position of the overlapping control
	self:_DoSlotLayout( self.overlapControl, self.overlapIndex );
	
	-- scale the window
	local width = self:GetWidth(); -- calling overloaded values, so we don't adjust for scale *again*
	local height = self:GetHeight(); -- calling overloaded values, so we don't adjust for scale *again*
	self:SetStretchMode( 1 );
	self:SetSize( width, height );
end

-- Stetch mode 1 causes GetSize() etc on Turbine.UI.Window to return unstretched values, so we overload them and return correct values
function Bar:GetSize()
	return self:GetWidth(), self:GetHeight();
end

function Bar:GetWidth()
	return Turbine.UI.Window.GetWidth( self ) * self.scale;
end

function Bar:GetHeight()
	return Turbine.UI.Window.GetHeight( self ) * self.scale;
end
