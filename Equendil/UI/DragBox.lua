import "Equendil.UI.Tooltip";
import "Equendil.UI.DecoratedContainer";

-- DragBox class. Similar to DragBar, but lies entirely within the target window, to allow positioning elements at the top of the screen,
-- or moving narrow windows such as floating buttons.

-- resources
local IconResizeNormal = "Equendil/UI/images/resize.tga"; -- 64x64
local IconResizeHighlighted = "Equendil/UI/images/resize_highlighted.tga" -- 64x64
local HighlightBox = { top = 0x4110CD4A, right = 0x4110CD4C, bottom = 0x4110CD4D, left = 0x4110CD4B }; -- highlight box

DragBox = class( Turbine.UI.Window );
function DragBox:Constructor( target )
	Turbine.UI.Window.Constructor( self );
	
	self.Repositioned = Equendil.Utils.Event();
	self.Scroll = Equendil.Utils.Event();
	
	-- init instance variables
	self.target = target; -- window to attach to
	self.dragging = false; -- dragging state

	-- setup the bar window and background
	self:SetVisible( false ); -- go invisible by default
	self:SetPosition( target:GetPosition()  );
	-- self:SetBackColorBlendMode( Turbine.UI.BlendMode.Normal );
	self:SetOpacity( 1.0 );
	self:SetZOrder( target:GetZOrder() + 1 );
	
	-- control used to highlight the target window
	self.highlightBox = Equendil.UI.DecoratedContainer( HighlightBox );
	self.highlightBox:SetParent( self );
	self.highlightBox:SetMouseVisible( false );

	-- resize icon
	self.iconResize = Turbine.UI.Button(); -- using a button so we can use this control to catch mouse wheel events
	self.iconResize:SetParent( self );
	self.iconResize:SetSize( 64, 64 );
	self.iconResize:SetStretchMode( 1 ); -- we'll stretch the icon to fit within the target window
	self.iconResize:SetMouseVisible( false );
	self.iconResize:SetBlendMode( Turbine.UI.BlendMode.Normal );
	
	self.tooltip = Equendil.UI.Tooltip();
	self.tooltip:SetHeight( 55 );
	
	self.dummy = Turbine.UI.Label(); -- dummy label to catch mouse wheel events (and the rest of them)
	self.dummy:SetParent( self );
	self.dummy:SetMouseVisible( true );
	
	-- setup callbacks
	self.dummy.MouseDown = function( sender, args ) 	self:_BeginDrag( args ) end
	self.dummy.MouseMove = function( sender, args ) 	self:_Drag( args ) end
	self.dummy.MouseUp = function( sender, args )		self:_EndDrag() end
	self.dummy.MouseEnter = function( sender, args ) 	self:_Highlight( true ) end
	self.dummy.MouseLeave = function( sender, args )	self:_Highlight( false ) end 
	self.dummy.MouseWheel = function( _, args ) self.Scroll( -args.Direction ) end
		
	self.target.SizeChanged = function( sender, args ) self:_DoLayout();	end
	self.target.PositionChanged = function( sender, args ) self:SetPosition( self.target:GetPosition() ); end
	
	self:_Highlight( false );
	self:_DoLayout();
end

-- Something in Turbine's API is preventing the window from being garbage collected
-- so, we add a Dispose method to "free" resources.
function DragBox:Dispose()
	self.dummy:SetParent( nil ); -- should be enough to get the drag box garbage collected ...
end

function DragBox:_Highlight( flag )
	self.highlightBox:SetVisible( flag );
	if flag then
		self:SetBackColor( Turbine.UI.Color( 0.4, 0, 0.2, 0.2 ) );
		self.iconResize:SetBackground( IconResizeHighlighted );
		self.tooltip:Show( self.target:GetText() .. "\nClick & drag to move.\nMouse wheel to change scale." );
	else
		self:SetBackColor( Turbine.UI.Color( 0.4, 0, 0, 0.1 ) );
		self.iconResize:SetBackground( IconResizeNormal );
		self.tooltip:Hide();
	end
end

function DragBox:_DoLayout()
	self:SetSize( self.target:GetSize() );
	self.dummy:SetSize( self:GetSize() );
	self.highlightBox:SetSize( self:GetSize() );
	
	-- resize the resize icon to fit the target window, but keep it square and centered
	local dim = math.min( self.target:GetSize() ) * 0.75;
	self.iconResize:SetSize( dim, dim );
	self.iconResize:SetTop( ( self.target:GetHeight() - dim ) / 2 );
	self.iconResize:SetLeft( ( self.target:GetWidth() - dim ) / 2 );
end

-- callback initiating drag action
function DragBox:_BeginDrag( pos )
	self.dragging = true;
	self.dragOrigX, self.dragOrigY = pos.X, pos.Y; -- save the original position of the mouse pointer 
end

-- callback handling drag movements & repositioning
function DragBox:_Drag( pos )
	if not self.dragging then return end

	-- compute new position
	local newX = self:GetLeft() + pos.X - self.dragOrigX;
	local newY = self:GetTop() + pos.Y - self.dragOrigY;

	-- make sure the window stays entirely within the drawing area
	newX = Equendil.Utils.Maths.constrain( 0, newX, Turbine.UI.Display:GetWidth() - self:GetWidth() ); 
	newY = Equendil.Utils.Maths.constrain( 0, newY, Turbine.UI.Display:GetHeight() - self:GetHeight() );
		
	-- move target windows around accordingly
	self.target:SetPosition( newX, newY );
end

-- callback ending drag action
function DragBox:_EndDrag()
	self.dragging = false;
	self.Repositioned(); -- notify position changed
end
