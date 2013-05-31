import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Equendil.UI.DecoratedContainer";
import "Equendil.UI.Resources";
import "Equendil.UI.DropDownMenu";
import "Equendil.UI.TextBox";
import "Equendil.UI.WindowManager";
import "Equendil.QuickBars.QuickBar";
-- UI to setup bars
-- Info strings
local Info = {};Info[Equendil.QuickBars.Mode.Normal] = "Обычная панель (как стандартные в ВКО).";
Info[Equendil.QuickBars.Mode.Collapsible] = "Сворачиваемая панель имеет дополнительный слот (подсвеченый). Нажать на него чтобы свернуть/развернуть панель. Любой предмет или навык помещенный в подсвеченный слот будет использован как иконка для панели.";
Info[Equendil.QuickBars.Mode.Selection] = "Селективная панель имеет дополнительный слот (подсвеченый) который 'запоминает' последний использованный скилл/предмет на панели. Правый клик чтоб развернуть панель. Левый клик для активации.";
Info[Equendil.QuickBars.Mode.MouseOver] = "Сворачиваемая панель, разворачивается при наведении курсора мыши. Первая ячейка служит иконкой для панели";
-- items used in the listbox
BarItem = class( Turbine.UI.Control );
function BarItem:Constructor( bar )	Turbine.UI.Control.Constructor( self );		

self.bar = bar;

		self.label = Turbine.UI.Label();
		self.label:SetParent( self );
		self.label:SetSelectable( true );
		self.label:SetPosition( 0, 0 );
		self.label:SetFont( Turbine.UI.Lotro.Font.TrajanPro13 );
		self.label:SetFontStyle( Turbine.UI.FontStyle.Outline );
		self.label:SetForeColor( Equendil.UI.Color.TurbineYellow );
		self.label:SetSize( 170, 20 );	
		self.label:SetText( bar:GetName() );
		self.label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
		self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
		self:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self:SetSize( 170, 20 );
-- register & callback on the bar & refresh the name when called
self.bar.Changed:Add( function() self.label:SetText( self.bar:GetName() ) end );
end

function BarItem:SetSelected( value )
	if value then	
		self:SetBackColor( Turbine.UI.Color( 0.2, 0.9, 0.9, 1 ) );
	else		
	    self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	end
end
-- the setup window itself
SetupWindow = class( Turbine.UI.Lotro.Window );
function SetupWindow:Constructor( mng )	Turbine.UI.Lotro.Window.Constructor( self );		
self.barManager = mng;	
self.repositioning = false;	
self.selectedIndex = -1;	
self.selectedBar = nil;		

-- register callbacks to keep track of bars	
self.barManager.BarAdded = function( bar ) self:_BarAdded( bar ) end	
self.barManager.BarRemoved = function( bar ) self:_BarRemoved( bar ) end		

-- setup the window proper	
self:SetSize( 575, 340 );	
self:SetPosition( ( Turbine.UI.Display.GetWidth() - self:GetWidth() ) / 2, ( Turbine.UI.Display.GetHeight() - self:GetHeight() ) /2 ); 

-- center the window on the display	
self:SetText( "Настройки Baruk" );	
Equendil.UI.WindowManager:ManageWindow( self ); -- add ourselves to the Window Manager for HUD toggling		

-- and add elements ...		
self.background = Turbine.UI.Control();	
self.background:SetParent( self );	
self.background:SetSize( 565, 301 );	
self.background:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );	
self.background:SetBackground( 0x41102EBF );	
self.background:SetPosition( 5, 28 );	
self.background:SetMouseVisible( false );		

-- setup the bar list (container, scrollbar, listbox & "new", "remove" buttons )	
self.leftContainer = Turbine.UI.Control();	
self.leftContainer:SetParent( self );	
self.leftContainer:SetPosition( 20, 40 );	
self.leftContainer:SetSize( 200, 280 );			
self.barListBox = Equendil.UI.DecoratedContainer( Equendil.UI.Decoration.RoundSilverBlue );	
self.barListBox:SetParent( self.leftContainer );	
self.barListBox:SetPosition( 0, 0 );	
self.barListBox:SetSize( 200, 250 );		
self.scrollbar = Turbine.UI.Lotro.ScrollBar();	
self.scrollbar:SetOrientation( Turbine.UI.Orientation.Vertical );	
self.scrollbar:SetParent( self.barListBox.center );	
self.scrollbar:SetPosition( 180, 10 );	
self.scrollbar:SetSize( 10, 230 );		
self.barList = Turbine.UI.ListBox();    
self.barList:SetParent( self.barListBox.center );    
self.barList:SetBackColor( Turbine.UI.Color( 0.1, 1, 1, 1 ) );    
self.barList:SetPosition( 10, 10 );    self.barList:SetSize( 170, 230 );	
self.barList:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );	
self.barList:SetVerticalScrollBar( self.scrollbar );	

-- "NEW" & "REMOVE" buttons	
self.buttonNewBar = Turbine.UI.Lotro.Button();	
self.buttonNewBar:SetParent( self.leftContainer );	
self.buttonNewBar:SetPosition( 15, 255 );	
self.buttonNewBar:SetSize( 80, 20 );	
self.buttonNewBar:SetText( "Новая" );	
self.buttonRemoveBar = Turbine.UI.Lotro.Button();	
self.buttonRemoveBar:SetParent( self.leftContainer );	
self.buttonRemoveBar:SetPosition( 105, 255 );	
self.buttonRemoveBar:SetSize( 80, 20 );	
self.buttonRemoveBar:SetText( "Удалить" );	

-- right container	
self.rightContainer = Equendil.UI.DecoratedContainer( Equendil.UI.Decoration.RoundSilverBlue );	
self.rightContainer:SetParent( self );	
self.rightContainer:SetPosition( 230, 40 );	
self.rightContainer:SetSize( 320, 280 );	

local function newLabel( name )
		local label = Turbine.UI.Label();
		label:SetParent( self.rightContainer );
		label:SetSize( 80, 20 );
		label:SetFont( Turbine.UI.Lotro.Font.TrajanPro13 );
		label:SetFontStyle( Turbine.UI.FontStyle.Outline );
		label:SetForeColor( Equendil.UI.Color.TurbineLightYellow );
		label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );
		label:SetText( name );
		return label;	
end		

-- Name	
self.labelName = newLabel( "Название");	
self.labelName:SetPosition( 15, 20 );		
self.textName = Equendil.UI.TextBox();	
self.textName:SetFont( Turbine.UI.Lotro.Font.Verdana12 );	
self.textName:SetParent( self.rightContainer );	
self.textName:SetPosition( 100, 20 );	
self.textName:SetSize( 150, 20 );	
self.textName:SetMultiline( false );		

-- Size	

self.labelSize = newLabel( "Размер" );	
self.labelSize:SetPosition( 15, 50 );		
self.buttonSizePlus = Turbine.UI.Button();	
self.buttonSizePlus:SetParent( self.rightContainer );	
self.buttonSizePlus:SetPosition( 100, 50 );
self.buttonSizePlus:SetSize( 25, 25 );	
self.buttonSizePlus:SetBackground( 0x41000279 ); -- TODO: move ID to resrouces	
self.buttonSizePlus:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		
self.textSize = Turbine.UI.Label();	
self.textSize:SetFont( Turbine.UI.Lotro.Font.Verdana12 );	
self.textSize:SetParent( self.rightContainer );	
self.textSize:SetPosition( 130, 50 );	
self.textSize:SetSize( 30, 25 );	
self.textSize:SetForeColor( Equendil.UI.Color.TurbineLightYellow );	
self.textSize:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );	
	
self.buttonSizeMinus = Turbine.UI.Button();	
self.buttonSizeMinus:SetParent( self.rightContainer );	
self.buttonSizeMinus:SetPosition( 165, 50 );	
self.buttonSizeMinus:SetSize( 25, 25 );	
self.buttonSizeMinus:SetBackground( 0x41000275 ); -- TODO: move ID to resrouces	
self.buttonSizeMinus:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );

-- Mode	
self.labelMode = newLabel( "Тип панели" );	
self.labelMode:SetPosition( 15, 80 );	
local opts = {};
	opts[Equendil.QuickBars.Mode.Normal] = "Нормальная";
		opts[Equendil.QuickBars.Mode.Collapsible] = "Сворачиваемая";
		opts[Equendil.QuickBars.Mode.Selection] = "Селективная";
		opts[Equendil.QuickBars.Mode.MouseOver] = "Виджет";
self.dropDownMode = Equendil.UI.DropDownMenu( opts, Equendil.QuickBars.Mode.Normal );	
self.dropDownMode:SetParent( self.rightContainer );	
self.dropDownMode:SetPosition( 100, 80 );	
self.dropDownMode:SetSize( 150, 20 );		

-- Direction	
self.labelDirection = newLabel( "Направление" );	
self.labelDirection:SetPosition( 15, 110 );		
local optDirections = {};	
optDirections[ Equendil.QuickBars.Direction.Right] = "Вправо";	
optDirections[ Equendil.QuickBars.Direction.Down] = "Вниз";	
optDirections[ Equendil.QuickBars.Direction.Left] = "Влево";	
optDirections[ Equendil.QuickBars.Direction.Up] = "Вверх";	
self.dropDownDirection = Equendil.UI.DropDownMenu( optDirections, Equendil.QuickBars.Direction.Right );	
self.dropDownDirection:SetParent( self.rightContainer );	
self.dropDownDirection:SetPosition( 100, 110 );	
self.dropDownDirection:SetSize( 150, 20 );		

-- scale	
self.labelScale = newLabel( "Размер" );	
self.labelScale:SetPosition( 15, 140 );		
self.sliderScale = Turbine.UI.Lotro.ScrollBar();	
self.sliderScale:SetParent( self.rightContainer );	
self.sliderScale:SetSize( 150, 10 );	
self.sliderScale:SetPosition( 100, 145 );	
self.sliderScale:SetOrientation( Turbine.UI.Orientation.Horizontal );	
self.sliderScale:SetMinimum( 0 );	
self.sliderScale:SetMaximum( 200 );	
self.sliderScale:SetSmallChange( 1 );	
self.sliderScale:SetLargeChange( 10 );	
self.sliderScale:SetValue( 100 );		
self.labelScale = Turbine.UI.Label();	
self.labelScale:SetParent( self.rightContainer );	
self.labelScale:SetPosition( 260, 140 );	
self.labelScale:SetSize( 40, 20 );	
self.labelScale:SetFont( Turbine.UI.Lotro.Font.Verdana12 );	
self.labelScale:SetText( "Н/Д" );		

-- lock	
self.labelLock = newLabel( "Блокировать" );	
self.labelLock:SetPosition( 10, 170 );		
self.checkLock = Turbine.UI.Lotro.CheckBox();	
self.checkLock:SetParent( self.rightContainer );	
self.checkLock:SetSize( 20, 20 );	
self.checkLock:SetPosition( 100, 170 );		

-- info text	
self.labelInfo1 = Turbine.UI.Label();	
self.labelInfo1:SetParent( self.rightContainer );	
self.labelInfo1:SetPosition( 20, 200 );	
self.labelInfo1:SetSize( 280, 60 );	
self.labelInfo1:SetBackColor( Turbine.UI.Color( 0.1, 1, 1, 1 ) );	
self.labelInfo1:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );	
self.labelInfo1:SetFont( Turbine.UI.Lotro.Font.Verdana12 );	
-- self.labelInfo1:SetFontStyle( Turbine.UI.FontStyle.Outline );	
self.labelInfo1:SetForeColor( Turbine.UI.Color( 1, 0.9, 0.9, 0.9 ) );	
self.labelInfo1:SetTextAlignment( Turbine.UI.ContentAlignment.TopLeft );	

self.labelInfo1:SetText( "Направление" );	

-- setup callbacks	
self.barList.SelectedIndexChanged = function( sender, args ) self:_SelectedIndexChanged(); end	
self.buttonNewBar.Click = function( sender, args ) self:_NewBar(); end	
self.buttonRemoveBar.Click = function( sender, args ) self:_RemoveBar(); end	
self.textName.TextChanged = function() self:_NameChanged(); end	
-- self.buttonSubmitName.Click = function( sender, args ) self:_NameChanged(); end	
self.buttonSizePlus.Click = function( sender, args ) self:_DecrementSize(); end	
self.buttonSizeMinus.Click = function( sender, args ) self:_IncrementSize(); end	
self.dropDownMode.Selection = function( key ) self:_SetMode( key ); end		
self.dropDownDirection.Selection = function( key ) self:_SetDirection( key ); end	
self.sliderScale.ValueChanged = function( sender, args ) self:_ScaleChanged(); end		

self.actionLock = function( sender, args ) self:_Lock(); end		

self:_RefreshSelection();
end
local function ScaleToSliderValue( scale )	
local sliderValue	
if scale < 1 then
		sliderValue = ( ( scale * 100 ) - 50 ) * 2;	
else		
        sliderValue = scale * 100;	
end		
return sliderValue;
end
local function SliderValueToScale( sliderValue )	
local scale;	
if sliderValue < 100 then		
scale = (sliderValue / 2 + 50) / 100;	
else		scale = sliderValue / 100;	
end	
return scale;
end
function SetupWindow:_ScaleChanged()	
if self.selectedBar == nil then return end	
local value = SliderValueToScale( self.sliderScale:GetValue() );	
self.labelScale:SetText( tostring( value * 100 ) .. "%" );	
self.selectedBar:SetScale( value );
end

-- Create a new barfunction 
SetupWindow:_NewBar()	self.barManager:NewBar();
end

-- Remove an existing barfunction 
SetupWindow:_RemoveBar()	
if self.selectedIndex == -1 then return end	
local item = self.barList:GetItem( self.selectedIndex );	
self.barManager:RemoveBar( item.bar );
end

-- lock a barfunction 
SetupWindow:_Lock()	
if self.selectedBar == nil then return end		
local locked = self.checkLock:IsChecked();	
self.selectedBar:Lock( locked );
end

-- Change the name of the selected barfunction 
SetupWindow:_NameChanged()	
if self.selectedIndex == -1 then		return;	end		
local item = self.barList:GetItem( self.selectedIndex );	
item.bar:SetName( self.textName:GetText() );
end

-- Decrement the size of the selected barfunction 
SetupWindow:_DecrementSize()	
if self.selectedBar == nil then return end		
local size = self.selectedBar:GetSize();	
if size > 1 then		self.selectedBar:SetSize( size - 1 );	end
end

-- Increment the size of the selected barfunction 
SetupWindow:_IncrementSize()	
if self.selectedBar == nil then return end		
self.selectedBar:SetSize( self.selectedBar:GetSize() + 1 );
end

-- set the mode of the selected barfunction 
SetupWindow:_SetMode( mode )	
if self.selectedBar == nil then return end		
self.selectedBar:SetMode( mode );	
self.labelInfo1:SetText( Info[self.selectedBar:GetMode()] );
end

-- set the direction of the selected barfunction 

SetupWindow:_SetDirection( direction )	
if self.selectedBar == nil then return end		
self.selectedBar:SetDirection( direction );
end

-- the selection has changed in the list box, update the display accordinglyfunction 
SetupWindow:_SelectedIndexChanged()	
if self.selectedIndex ~= -1 
  then		
    local item = self.barList:GetItem( self.selectedIndex );		
    item:SetSelected( false );	
    end	
self:_Deselect();	
self.selectedIndex = self.barList:GetSelectedIndex();	
if self.selectedIndex ~= -1 
  then		
    local item = self.barList:GetItem( self.selectedIndex );		
    item:SetSelected( true );		
    self:_Select( item.bar );	end
end

-- make a bar the current selectionfunction 
SetupWindow:_Select( bar )	
self.selectedBar = bar;	
self.selectedBar.Changed:Add( function() self:_BarChanged( bar ) end ); 

-- register a callback to know when the bar has changed	
self:_RefreshSelection();end

-- Deselect the current barfunction 
SetupWindow:_Deselect( )	
if self.selectedBar ~= nil then		self.selectedBar.Changed:Remove( self ); -- we don't want updates from that bar anymore		
self.selectedBar = nil;			
self:_RefreshSelection();	end
end

-- update the display depending on what we have selectedfunction 
SetupWindow:_RefreshSelection()	self.textName:SetEnabled( self.selectedBar ~= nil );	
self.textSize:SetEnabled( self.selectedBar ~= nil );	
self.dropDownMode:SetEnabled( self.selectedBar ~= nil );	
self.dropDownDirection:SetEnabled( self.selectedBar ~= nil );	
self.sliderScale:SetEnabled( self.selectedBar ~= nil );	
self.checkLock:SetEnabled( self.selectedBar ~= nil );		
if self.selectedBar ~= nil 
  then		
  self.textName:SetText( self.selectedBar:GetName() );		
  self.textSize:SetText( self.selectedBar:GetSize() );		
  self.dropDownMode:SetCurrentKey( self.selectedBar:GetMode() );		
  self.dropDownDirection:SetCurrentKey( self.selectedBar:GetDirection() );		
  self.labelInfo1:SetText( Info[self.selectedBar:GetMode()] );		
  self.labelScale:SetText( tostring( self.selectedBar:GetScale() * 100 ) .. "%" );		
  self.sliderScale:SetValue( ScaleToSliderValue( self.selectedBar:GetScale() ) );		
  self.checkLock.CheckedChanged = nil; -- removing callback temporarily so we don't get a notification from the next statement		
  self.checkLock:SetChecked( self.selectedBar:IsLocked() );		
  self.checkLock.CheckedChanged = self.actionLock;			
  else		
  self.textName:SetText( "Н/Д" );		
  self.textSize:SetText( "Н/Д" );		
  self.dropDownMode:SetCurrentKey( nil );		
  self.dropDownDirection:SetCurrentKey( nil );		
  self.labelScale:SetText( "Н/Д" );		
  self.labelInfo1:SetText( "Выберите панель из списка или создайте новую" );		
  self.checkLock.CheckedChanged = nil;		
  self.checkLock:SetChecked( false );	end
  end

-- process changes from the bars & manager
function SetupWindow:_BarChanged( bar )	
if bar == self.selectedBar 
then		
self:_RefreshSelection();	end
end

function SetupWindow:_BarAdded( bar )	
self.barList:AddItem( BarItem( bar ) );
end
function SetupWindow:_BarRemoved( bar )
	-- find the index of the bar in the listbox	
	local index = -1;	
	for i = 1, self.barList:GetItemCount(), 1 do		
	if self.barList:GetItem( i ).bar == bar then			
	index = i;		end	
	end		
-- and remove it	
if index ~= -1 then		self.barList:RemoveItemAt( index );	end		
-- if it was our current selection, deselect	
if self.selectedIndex == index then		
self.selectedIndex = -1;		
self:_Deselect();	end
end