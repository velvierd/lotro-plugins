-- Resizer class. Provides a resizing button to be attached to a window.

-- TODO: Visual feedback on mouseover.

--  resource defintions
local CornerIconNormal = 0x4111038C; -- 45x45
local CornerIconRed = 0x4111038D; -- 45x45
local BottomBarNormal = 0x4111038A; -- 100x10
local BottomBarRed = 0x4111038B; -- 100x10

-- Resizer button class
Resizer = class( Turbine.UI.Control );
function Resizer:Constructor()
	Turbine.UI.Control.Constructor( self );

	self.Resized = Equendil.Utils.Event();
	
	self.dragging = false;
end

-- Attach the button to a window and sets the min and max sizes of it
function Resizer:AttachWindow( target, minWidth, minHeight, maxWidth, maxHeight )
	self.target = target;
	self:SetParent( target );
	
	self.minWidth = minWidth;
	self.minHeight = minHeight;
	self.maxWidth = maxWidth;
	self.maxHeight = maxHeight;
	
	if self.minWidth == self.maxWidth then
		-- only height can be changed -> bottom drag bar
		self:SetSize( 100, 10 );
		self:SetBackground( BottomBarNormal );
	else
		-- both height & width can be changed -> corner icon
		self:SetSize( 45, 45 );
		self:SetBackground( CornerIconNormal );
	end
	
	self:SetBlendMode( Turbine.UI.BlendMode.Overlay );

	self:_DoLayout();
	target.SizeChanged = function() self:_DoLayout() end;
	
	self.MouseDown = function( sender, args ) 	self:_BeginDrag( args ) end
	self.MouseMove = function( sender, args ) 	self:_Drag( args ) end
	self.MouseUp = function( sender, args )		self:_EndDrag() end
end

-- Layout the button within its target window
function Resizer:_DoLayout()
	if self.minWidth == self.maxWidth then
		self:SetPosition( ( self.target:GetWidth() - 100 ) / 2, self.target:GetHeight() - 10 );
	else
		self:SetPosition( self.target:GetWidth() - 45, self.target:GetHeight() - 45 );
	end
end

-- Initiate drag mechanism
function Resizer:_BeginDrag( pos )
	self.dragging = true;
	self.dragOrigX, self.dragOrigY = pos.X, pos.Y; -- save the original position of the mouse pointer 
end

-- Terminate drag mechanism
function Resizer:_EndDrag( args )
	self.dragging = false;
	self.Resized(); -- fire event
end

-- Resize target window on drag
function Resizer:_Drag( pos )
	if not self.dragging then return end

	-- compute new position
	local newWidth = self.target:GetWidth() + pos.X - self.dragOrigX;
	local newHeight = self.target:GetHeight() + pos.Y - self.dragOrigY;

	-- Constrain the window size within its min/max bounds
	newWidth = Equendil.Utils.Maths.constrain( self.minWidth, newWidth, self.maxWidth ); 
	newHeight = Equendil.Utils.Maths.constrain( self.minHeight, newHeight, self.maxHeight );

	-- move windows around accordingly
	self.target:SetSize( newWidth, newHeight );
	self:_DoLayout();
end
