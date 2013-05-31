import "Turbine.UI"
import "Equendil.UI.DecoratedContainer"

local ButtonHeight = 20;

local function HighlightLabel( label )
	label:SetForeColor( Turbine.UI.Color( 1, 1, 0.9, 0.4 ) );
	label:SetOutlineColor( Turbine.UI.Color( 1, 1, 0.8, 0.6 ) );
end

local function UnHighlightLabel( label )
	label:SetForeColor( Turbine.UI.Color( 1, 0.9, 0.9, 0.7 ) );
	label:SetOutlineColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
end

local function SetupLabel( label )
	label:SetSelectable( false );
	label:SetFont( Turbine.UI.Lotro.Font.TrajanPro14 );
	label:SetFontStyle( Turbine.UI.FontStyle.Outline );
	label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	UnHighlightLabel( label );
end

DropDownItem = class( Turbine.UI.Button );
function DropDownItem:Constructor( name, id )
	Turbine.UI.Button.Constructor( self );

	self.id = id;
	
	self.Selected = Equendil.Utils.Event();
	
	SetupLabel( self );
	self:SetHeight( ButtonHeight );
	self:SetText( name );
	
	self.MouseEnter = function( sender, args ) HighlightLabel( self );end
	self.MouseLeave = function( sender, args ) UnHighlightLabel( self ) end
	self.MouseUp = function( sender, args ) self.Selected() end
end


DropDownMenu = class( Turbine.UI.Control );
function DropDownMenu:Constructor( items )
	Turbine.UI.Control.Constructor( self );

	self.Selection = Equendil.Utils.Event();
	self.items = items;
	self.key = defaultKey;
	self.readOnly = false;
	
	-- setup the listbox (container, actual listbox, scrollbar )
	self.listBoxWindow = Turbine.UI.Window();
	self.listBoxWindow:SetParent( nil );
	self.listBoxWindow:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.listBoxWindow:SetVisible( false );
	self.listBoxWindow:SetZOrder( 100000 ); -- abritrary large value to bring it to front
	
	self.listBoxContainer = Equendil.UI.DecoratedContainer( Equendil.UI.Decoration.SimpleGreyOutline );
	self.listBoxContainer:SetParent( self.listBoxWindow );
	self.listBoxContainer:SetPosition( 0, 0 );
	self.listBoxContainer:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	
	self.listBox = Turbine.UI.ListBox();
	self.listBox:SetParent( self.listBoxContainer );
	self.listBox:SetPosition( 0, 5 );

	self.scrollbar = Turbine.UI.Lotro.ScrollBar();
	self.scrollbar:SetParent( self.listBoxContainer );
	self.scrollbar:SetOrientation( Turbine.UI.Orientation.Vertical );

	self.listBox:SetVerticalScrollBar( self.scrollbar );	

	local itemCount = 0;
	local index = 1;
	for key, name in pairs( items ) do 
		itemCount = itemCount + 1;
		local dropDownItem = DropDownItem( name, key );
		dropDownItem.Selected = function()
			self.key = key;
			self.buttonLabel:SetText( self.items[key] );
			self.Selection( self.key );
			self:_ShowMenu( false );
		end
		self.listBox:AddItem( dropDownItem );
	end
	self.listHeight = ( itemCount * ButtonHeight ) + 10;

	-- setup the button (container, label, icon )
	self.buttonContainer = Equendil.UI.DecoratedContainer( Equendil.UI.Decoration.SimpleGreyOutline );
	self.buttonContainer:SetParent( self );
	
	self.buttonLabel = Turbine.UI.Label();
	SetupLabel( self.buttonLabel );
	self.buttonLabel:SetParent( self.buttonContainer.center );
	self.buttonLabel:SetText( self.items[ self.key ] );
	self.buttonLabel:SetMouseVisible( false );
	
	self.buttonIcon = Turbine.UI.Button();
	self.buttonIcon:SetParent( self.buttonContainer.center );
	self.buttonIcon:SetSize( 16, 16 );
	self.buttonIcon:SetBackground( Equendil.UI.Icon.ArrowDownTiny[1] );
	self.buttonIcon:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	
	self.MouseDown = function( sender, args ) self:_MouseDown() end
	self.MouseEnter = function( sender, args ) 	
		if not self.readOnly then 
			HighlightLabel( self.buttonLabel ) 
			self.buttonIcon:SetBackground( Equendil.UI.Icon.ArrowDownTiny[2] );
		end 
	end
	self.MouseLeave = function( sender, args ) 
		if not self.readOnly then 
			UnHighlightLabel( self.buttonLabel );
			self.buttonIcon:SetBackground( Equendil.UI.Icon.ArrowDownTiny[1] );
		end 
	end
	self.MouseClick = function( sender, args ) 
		if not self.readOnly then 
			self:_ShowMenu( not self.listBoxWindow:IsVisible() );
		end 
	end
	
	self.FocusLost = function( sender, args ) self:_ShowMenu( false ) end
	
	self:DoLayout();
	self.SizeChanged = function( sender, args ) self:DoLayout() end
end

function DropDownMenu:SetCurrentKey( key )
	self.key = key;
	if key == nil or self.items[key] == nil then
		self.buttonLabel:SetText( "Н/Д" );
	else
		self.buttonLabel:SetText( self.items[key] );
	end
end

function DropDownMenu:GetCurrentKey()
	return self.key;
end

function DropDownMenu:DoLayout()
	local width = self:GetWidth();
	local height = self:GetHeight();
	
	self.buttonContainer:SetSize( width, ButtonHeight );
	self.buttonLabel:SetSize( width, ButtonHeight );
	self.buttonIcon:SetPosition( width - 16, height - 16 );
	
	self.listBoxWindow:SetSize( width, self.listHeight );
	self.listBoxContainer:SetSize( width, self.listHeight );
	self.listBox:SetSize( width, self.listHeight - 10 );
	self.scrollbar:SetPosition( width - 15, 5 );
	self.scrollbar:SetSize( 10, self.listHeight - 10 );
	
	for i = 1, self.listBox:GetItemCount(), 1 do 
		local item = self.listBox:GetItem( i );
		item:SetWidth( width );
	end
end

--Show/hide the menu
function DropDownMenu:_ShowMenu( flag )
	if flag then
		self.listBoxWindow:SetPosition( self:PointToScreen( 0, ButtonHeight ) );
		self:Focus();
		-- self.listBoxWindow:Activate();
	end
	self.listBoxWindow:SetVisible( flag );
end

function DropDownMenu:SetReadOnly( flag )
	self.readOnly = flag;
end

function DropDownMenu:_MouseDown()
	--TODO (grey out text as per turbine's own dropdown menus)
end
