
import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Extensions";
import "Turbine.UI.Lotro";

TheOneBagWindow = class( Turbine.UI.Extensions.Window );

function TheOneBagWindow:Constructor()
	Turbine.UI.Extensions.Window.Constructor( self );

	-- Padding used to position the bag initially from the bottom
	-- right of the screen.
	local edgePadding = 50;

	self:SetSize( 300, 300 );
	self:SetBackColor( Turbine.UI.Color() );
	self:SetPosition( Turbine.UI.Display.GetWidth() - self:GetWidth() - edgePadding, Turbine.UI.Display.GetHeight() - self:GetHeight() - edgePadding * 1.5 );
	self:SetText( "The One Bag" );
	self:SetOpacity( 0.4 );

	self:SetFadeSpeed( 0.4 );

	self.MouseEnter = function( sender, args )
		sender:SetOpacity( 1 );
	end

	self.MouseLeave = function( sender, args )
		sender:SetOpacity( 0.4 );
	end

	self:SetWantsKeyEvents( true );

	self.KeyDown = function( sender, args )
		if ( args.Action == Turbine.UI.Lotro.Action.Escape ) then
			sender:SetVisible( false ) 
		end

		if ( args.Action == Turbine.UI.Lotro.Action.ToggleBags or
		     args.Action == Turbine.UI.Lotro.Action.ToggleBag1 or
			 args.Action == Turbine.UI.Lotro.Action.ToggleBag2 or
			 args.Action == Turbine.UI.Lotro.Action.ToggleBag3 or
			 args.Action == Turbine.UI.Lotro.Action.ToggleBag4 or
			 args.Action == Turbine.UI.Lotro.Action.ToggleBag5 )
		then
			sender:SetVisible( not sender:IsVisible() ) 
		end
	end

	local player = Turbine.Gameplay.LocalPlayer.GetInstance();
	self.backpack = player:GetBackpack();

	local theOneBag = self;
	local mainWindow = self;

	self.itemListBoxScrollBar = Turbine.UI.Lotro.ScrollBar();
	self.itemListBoxScrollBar:SetOrientation( Turbine.UI.Orientation.Vertical );
	self.itemListBoxScrollBar:SetParent( self );

	self.itemListBox = Turbine.UI.ListBox();
	self.itemListBox:SetParent( self );
	self.itemListBox:SetOrientation( Turbine.UI.Orientation.Horizontal );
	self.itemListBox:SetVerticalScrollBar( self.itemListBoxScrollBar );
	self.itemListBox:SetAllowDrop( true );

	self.itemListBox.DragDrop = function( sender, args )
		local shortcut = args.DragDropInfo:GetShortcut();

		if ( shortcut ~= nil ) then
			local item = self.itemListBox:GetItemAt( args.X, args.Y );
			local index = self.itemListBox:IndexOfItem( item );
			
			self.backpack:PerformShortcutDrop( shortcut, index, Turbine.UI.Control.IsShiftKeyDown() );
		end
	end

	self.resizeHandle = Turbine.UI.Control();
	self.resizeHandle:SetParent( self );
	self.resizeHandle:SetZOrder( 100 );
	self.resizeHandle:SetSize( 20, 20 );
	self.resizeHandle:SetPosition( self:GetWidth() - self.resizeHandle:GetWidth(), self:GetHeight() - self.resizeHandle:GetHeight() );

	self.resizeHandle.MouseDown = function( sender, args )
		sender.dragStartX = args.X;
		sender.dragStartY = args.Y;
		sender.dragging = true;
	end

	self.resizeHandle.MouseMove = function( sender, args )
		local width, height = mainWindow:GetSize();

		if ( sender.dragging ) then
			mainWindow:SetSize( width + ( args.X - sender.dragStartX ), height + ( args.Y - sender.dragStartY ) );
			sender:SetPosition( mainWindow:GetWidth() - sender:GetWidth(), mainWindow:GetHeight() - sender:GetHeight() )
			theOneBag:PerformLayout()
		end
	end

	self.resizeHandle.MouseUp = function( sender, args )
		sender.dragging = false;
	end

	-- Initialize the container that holds the elements referencing
	-- the player's inventory.
	self.items = { };

	self.backpack.SizeChanged = function( sender, args )
		theOneBag:Refresh();
	end

	self.backpack.ItemAdded = function( sender, args )
		theOneBag.items[args.Index]:SetItem( theOneBag.backpack:GetItem( args.Index ) );
	end

	self.backpack.ItemRemoved = function( sender, args )
		theOneBag.items[args.Index]:SetItem( theOneBag.backpack:GetItem( args.Index ) );
	end

	self.backpack.ItemMoved = function( sender, args )
		theOneBag.items[args.OldIndex]:SetItem( theOneBag.backpack:GetItem( args.OldIndex ) );
		theOneBag.items[args.NewIndex]:SetItem( theOneBag.backpack:GetItem( args.NewIndex ) );
	end

	self:Refresh();
end

function TheOneBagWindow:Refresh()
	local backpackSize = self.backpack:GetSize();

	for i = 1, backpackSize, 1 do
		if ( self.items[i] ) then
			self.items[i]:SetParent( nil );
		end
		
		self.items[i] = Turbine.UI.Lotro.ItemControl( self.backpack:GetItem( i ) );
		self.itemListBox:AddItem( self.items[i] );
	end

	self:PerformLayout();
end

function TheOneBagWindow:PerformLayout()
	self:Layout( { } )
end

function TheOneBagWindow:Layout( args )
	local width, height = self:GetSize();
	
	local itemWidth = 40;
	
	if ( self.items[1] ~= nil ) then
		itemWidth = self.items[1]:GetWidth()
	end

	local listWidth = width - 40;
	local listHeight = height - 50;
	local itemsPerRow = listWidth / itemWidth;

	self.itemListBox:SetPosition( 15, 35 );
	self.itemListBox:SetSize( listWidth, listHeight );
	self.itemListBox:SetMaxItemsPerLine( itemsPerRow );
	
	self.itemListBoxScrollBar:SetPosition( width - 25, 35 );
	self.itemListBoxScrollBar:SetSize( 10, listHeight );
end
