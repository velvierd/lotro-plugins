import "Turbine.UI";


--[[
	-- define EffectItem
--]]

EffectItem = class( Turbine.UI.Control );

function EffectItem:Constructor( tSettings, tSettingsExt )
	Turbine.UI.Control.Constructor( self );

	self.settings = tSettings;
	self.settingsExt = tSettingsExt;

	self.p_remaining = self:GetColor( self.settingsExt.colors[Colors.Primary].remaining );
	self.p_elapsed = self:GetColor( self.settingsExt.colors[Colors.Primary].elapsed );
	
	self.s_remaining = self:GetColor( self.settingsExt.colors[Colors.Secondary].remaining );
	self.s_elapsed = self:GetColor( self.settingsExt.colors[Colors.Secondary].elapsed );

	if ( table.getn( self.settings.match ) == 0 ) then
		self.name = "";
	else
		self.name = self.settings.match[1];
	end

	self.id = 0;

	self.matched = false;
	
	self:SetBackColor( Turbine.UI.Color( .5, 0, 0, 0 ) );

	self.SizeChanged = function( sender, args )
		self:Refresh();
	end

	self.MouseClick = function( sender, args )
		if ( args.Button == Turbine.UI.MouseButton.Right ) then
			self:ShowContextMenu( sender, args );
		end
	end

	self.IconFrame = Turbine.UI.Control();
	self.IconFrame:SetParent( self );
	self.IconFrame:SetBackColor( Turbine.UI.Color( .5, .25, .25, .25 ) );
	self.IconFrame:SetMouseVisible( false );
	self.IconFrame:SetZOrder( 10 );

	self.Icon = Turbine.UI.Lotro.EffectDisplay();
	self.Icon:SetParent( self );
	self.Icon:SetMouseVisible( false );
	self.Icon:SetVisible( false );
	self.Icon:SetZOrder( 15 );

	self.NameFrame = Turbine.UI.Control();
	self.NameFrame:SetParent( self );
	self.NameFrame:SetMouseVisible( false );
	self.NameFrame:SetZOrder( 20 );

	self.Name = Turbine.UI.Label();
	self.Name:SetParent( self.NameFrame );
	self.Name:SetMultiline( true );
	self.Name:SetForeColor( Turbine.UI.Color.White );
	self.Name:SetOutlineColor( Turbine.UI.Color.Black );
	self.Name:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.Name:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.Name:SetMouseVisible( false );
	self.Name:SetZOrder( 60 );

	self.Timer = Turbine.UI.Label();
	self.Timer:SetParent( self.NameFrame );
	self.Timer:SetMultiline( false );
	self.Timer:SetForeColor( Turbine.UI.Color.White );
	self.Timer:SetOutlineColor( Turbine.UI.Color.Black );
	self.Timer:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.Timer:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );
	self.Timer:SetMouseVisible( false );
	self.Timer:SetZOrder( 60 );

	self.Input = Turbine.UI.TextBox();
	self.Input:SetParent( self.NameFrame );
	self.Input:SetMultiline( false );
	self.Input:SetForeColor( Turbine.UI.Color.White );
	self.Input:SetOutlineColor( Turbine.UI.Color.Black );
	self.Input:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.Input:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.Input:SetText( "" );
	self.Input:SetZOrder( 70 );

	self.OkButton = Turbine.UI.Button();
	self.OkButton:SetParent( self.NameFrame );
	self.OkButton:SetSize( 12, 12 );
	self.OkButton:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.OkButton:SetBackground( "PTweety/BuffMonitor/Resources/icon_ok.tga" );
	self.OkButton:SetZOrder( 70 );

	self.CancelButton = Turbine.UI.Button();
	self.CancelButton:SetParent( self.NameFrame );
	self.CancelButton:SetSize( 12, 12 );
	self.CancelButton:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.CancelButton:SetBackground( "PTweety/BuffMonitor/Resources/icon_cancel.tga" );
	self.CancelButton:SetZOrder( 70 );

	self:Refresh();

	-- register to get new effects
	EffectManager:AddCallback( self );
end

function EffectItem:Destroy()
	self:SetVisible( false )
	self:EffectNoMatchAtAll();
	
	local function destroy ( object )
		object:SetVisible( false );
		object:SetParent( nil );
		object = nil;
	end

	local cEffects = EffectManager:GetEffects();
	for i = 1, cEffects:GetCount() do
		local cEffect = cEffects:Get( i )
		if ( cEffect.Bars ~= nil and cEffect.Bars[self] ~= nil ) then
			destroy( cEffect.Bars[self].e );
			destroy( cEffect.Bars[self].r );
			cEffect.Bars[self] = nil;
		end
		if ( cEffect.Timer ~= nil and cEffect.Timer[self] ~= nil ) then
			cEffect.Timer[self]:SetEnabled( false );
			cEffect.Timer[self] = nil;
		end
	end
	
	destroy( self.Icon );
	destroy( self.IconFrame );
	destroy( self.CancelButton );
	destroy( self.OkButton );
	destroy( self.Input );
	destroy( self.Timer );
	destroy( self.Name );
	destroy( self.NameFrame );

	-- unregister from EffectManager
	EffectManager:RemoveCallback( self );
	
	self.SizeChanged = nil;
	self.MouseClick = nil;
end


-- handle events from EffectManager
function EffectItem:EffectMatched( cEffect )
	local bFound = false;
	for i=1, table.getn( self.settings.match ) do
		if ( string.match( cEffect:GetName(), self.settings.match[i] ) ~= nil ) then
			bFound = true;
			break;
		end
	end
	return bFound;
end

function EffectItem:EffectAdded( cEffect )
	if ( self:EffectMatched( cEffect ) ) then
		self.Icon:SetEffect( cEffect );
		self.name = cEffect:GetName();
		self.id = cEffect:GetID();
		if ( cEffect.Bars == nil or cEffect.Bars[self] == nil or cEffect.Timer == nil or cEffect.Timer[self] == nil ) then
			self:AddEffectTimer( cEffect );
		end
		self.matched = true;
		self:Refresh();
	end
end

function EffectItem:EffectRemoved( cEffect )
	if ( cEffect.Bars ~= nil and cEffect.Bars[self] ~= nil ) then
			cEffect.Bars[self].e:SetVisible( false );
			cEffect.Bars[self].r:SetVisible( false );
			cEffect.Bars[self] = nil;
	end
	if ( cEffect.Timer ~= nil and cEffect.Timer[self] ~= nil ) then
		cEffect.Timer[self]:SetEnabled( false );
		cEffect.Timer[self] = nil;
	end
	if ( self:EffectMatched( cEffect ) ) then
		local bFound = false;
		local cEffects = EffectManager:GetEffects();
		for i = 1, cEffects:GetCount() do
			if ( self:EffectMatched( cEffects:Get( i ) ) ) then
				self:EffectAdded( cEffects:Get( i ) );
				bFound = true;
				break;
			end
		end
		if ( not bFound ) then
			self:EffectNoMatchAtAll();
		end
	end
end

function EffectItem:EffectNoMatchAtAll()
	if ( table.getn( self.settings.match ) == 0 ) then
		self.name = "";
	else
		self.name = self.settings.match[1];
	end
	self.id = 0;
	self.matched = false;
	self:Refresh();
end

function EffectItem:RefreshEffects()
	-- find all active effects
	if ( EffectManager:IsEnabled() ) then
		-- pretend to have no match at all
		self:EffectNoMatchAtAll();

		local cEffects = EffectManager:GetEffects();
		for i = 1, cEffects:GetCount() do
			self:EffectAdded( cEffects:Get( i ) );
		end
	end
end

function EffectItem:AddEffectTimer( cEffect )

	self.Timer:SetText( "" );

	local function formatTime( value )
		local text = "";
		if (value >= 60) then
			text = ("%d:%02d"):format(value / 60, value % 60);
		else
			text = ("%d"):format(value);
		end
		return text;
	end

	-- configure bars
	if ( cEffect.Bars == nil ) then cEffect.Bars = {}; end

	if ( cEffect.Bars[self] == nil ) then
		cEffect.Bars[self] = { e = Turbine.UI.Control(), r = Turbine.UI.Control() };
		cEffect.Bars[self].e:SetParent( self.NameFrame );
		cEffect.Bars[self].e:SetMouseVisible( false );
		cEffect.Bars[self].e:SetVisible( self.settingsExt.showEffect.elapsed );
		cEffect.Bars[self].r:SetParent( self.NameFrame );
		cEffect.Bars[self].r:SetMouseVisible( false );
		cEffect.Bars[self].r:SetVisible( self.settingsExt.showEffect.remaining );
	end

	-- configure timer
	if ( cEffect.Timer == nil ) then cEffect.Timer = {}; end

	if ( cEffect.Timer[self] == nil ) then
		cEffect.Timer[self] = PTweety.BuffMonitor.Utils.Timer( 10 ); -- 1/100 second
	end

	cEffect.Timer[self].OnTick = function( sender, args )
		local gameTime = Turbine.Engine.GetGameTime();
		local elapsedTime = gameTime - cEffect:GetStartTime();
		if ( cEffect:GetDuration() < 86400 ) then -- not a permanent effect
			local percentage = math.min( 1, elapsedTime / cEffect:GetDuration() );
			if ( cEffect.Bars ~= nil and cEffect.Bars[self] ~= nil ) then
				local width, height	= self:GetSize();
				local offset = 0;
				if ( self.settingsExt.showEffect.icon ) then offset = height; end
				if ( cEffect:GetID() == self.id ) then
					cEffect.Bars[self].e:SetBackColor( self.p_elapsed );
					cEffect.Bars[self].e:SetZOrder( 40 );
					cEffect.Bars[self].r:SetBackColor( self.p_remaining );
					cEffect.Bars[self].r:SetZOrder( 40 );
					self.Timer:SetText( formatTime( math.max( cEffect:GetDuration() - elapsedTime, 0 ) ) );
				else
					cEffect.Bars[self].e:SetBackColor( self.s_elapsed );
					cEffect.Bars[self].e:SetZOrder( 30 );
					cEffect.Bars[self].r:SetBackColor( self.s_remaining );
					cEffect.Bars[self].r:SetZOrder( 30 );
				end
				cEffect.Bars[self].e:SetSize( percentage * ( width - offset ), height - 4 );
				cEffect.Bars[self].e:SetPosition( ( 1 - percentage ) * ( width - offset ) + offset, 2 );
				cEffect.Bars[self].r:SetSize( ( 1 - percentage ) * ( width - offset ), height - 4 );
				cEffect.Bars[self].r:SetPosition( offset, 2 );
			end
			if ( ( 1 - percentage ) == 0 ) then
				if ( cEffect.Bars ~= nil and cEffect.Bars[self] ~= nil ) then
					cEffect.Bars[self].e:SetVisible( false );
					cEffect.Bars[self].r:SetVisible( false );
					cEffect.Bars[self] = nil;
					self.Timer:SetText( "" );
				end
				cEffect.Bars = nil;
				cEffect.Timer[self]:SetEnabled( false );
				cEffect.Timer[self] = nil;
			end
		else
			if ( cEffect.Bars ~= nil and cEffect.Bars[self] ~= nil ) then
				local width, height	= self:GetSize();
				local offset = 0;
				if ( self.settingsExt.showEffect.icon ) then offset = height; end
				if ( cEffect:GetID() == self.id ) then
					cEffect.Bars[self].e:SetVisible( false );
					cEffect.Bars[self].r:SetBackColor( self.p_remaining );
					cEffect.Bars[self].r:SetZOrder( 40 );
					self.Timer:SetText( formatTime( math.max( elapsedTime, 0 ) ) );
				else
					cEffect.Bars[self].e:SetVisible( false );
					cEffect.Bars[self].r:SetBackColor( self.s_remaining );
					cEffect.Bars[self].r:SetZOrder( 30 );
				end
				cEffect.Bars[self].r:SetSize( width - offset - 2, height - 4 );
				cEffect.Bars[self].r:SetPosition( offset + 2, 2 );
			end
		end
	end

	-- start refresh timer
	cEffect.Timer[self]:SetEnabled( true );
end


-- EffectItem functions
function EffectItem:GetColor( tColor )
	return Turbine.UI.Color( tColor.a / 255, tColor.r / 255, tColor.g / 255, tColor.b / 255 );
end

function EffectItem:GetMatched()
	return self.matched;
end

function EffectItem:SetSize( width, height )
	Turbine.UI.Control.SetSize( self, width, height );

	local font = Turbine.UI.Lotro.Font.Verdana10;

	if ( height >= 52 ) then
		font = Turbine.UI.Lotro.Font.Verdana22;
	elseif ( height >= 46 ) then
		font = Turbine.UI.Lotro.Font.Verdana20;
	elseif ( height >= 40 ) then
		font = Turbine.UI.Lotro.Font.Verdana18;
	elseif ( height >= 34 ) then
		font = Turbine.UI.Lotro.Font.Verdana16;
	elseif ( height >= 28 ) then
		font = Turbine.UI.Lotro.Font.Verdana14;
	elseif ( height >= 22 ) then
		font = Turbine.UI.Lotro.Font.Verdana12;
	end

	local timerWidth = math.max( 32, height * 1.2 + 2 );

	local offset = 0;
	if ( self.settingsExt.showEffect.icon ) then offset = height; end

	-- refresh IconFrame
	self.IconFrame:SetSize( height - 4, height - 4 );
	self.IconFrame:SetPosition( 2, 2 );

	self.Icon:SetSize( height, height );
	self.Icon:SetPosition( 0, 0 );
	self:RefreshEffects();

	-- refresh NameFrame
	self.NameFrame:SetSize( width, height );

	if ( self.settingsExt.showEffect.timer ) then
		self.Name:SetSize( width - offset - timerWidth - 2, height );
	else
		self.Name:SetSize( width - offset, height );
	end
	self.Name:SetPosition( offset, 0 );
	self.Name:SetFont( font );

	self.Timer:SetSize( timerWidth, height );
	self.Timer:SetPosition( width - timerWidth - 2, 0 );
	self.Timer:SetFont( font );

	-- refresh InputFrame
	self.Input:SetSize( width - height - self.OkButton:GetWidth(), height );
	self.Input:SetPosition( height, 0 );
	self.Input:SetFont( font );

	self.OkButton:SetPosition( width - self.OkButton:GetWidth(), 0 );

	self.CancelButton:SetPosition( width - self.CancelButton:GetWidth(), self.OkButton:GetHeight() );
	
	self:Refresh();
end

function EffectItem:Refresh()
	self.Name:SetText( self.name );

	if ( self.matched ) then
		self.Icon:SetVisible( self.settingsExt.showEffect.icon );
		self.Name:SetForeColor( Turbine.UI.Color.White );
		self.Timer:SetVisible( self.settingsExt.showEffect.timer );
	else
		self.Icon:SetVisible( false );
		self.Name:SetForeColor( Turbine.UI.Color.DimGray );
		self.Timer:SetVisible( false );
	end

	self.IconFrame:SetVisible( self.settingsExt.showEffect.icon );
	self.Name:SetVisible( self.settingsExt.showEffect.name );

	self.Input:SetVisible( false );
	self.OkButton:SetVisible( false );
	self.CancelButton:SetVisible( false );
end

function EffectItem:ShowContextMenu(sender, args)
	-- context menu
	local contextMenu = Turbine.UI.ContextMenu();
	local contextMenuItems = contextMenu:GetItems();

	-- sub menu match
	local subMenuEffect = Turbine.UI.MenuItem( "Effect" );
	local subMenuEffectItems = subMenuEffect:GetItems();

	local menuItemEffectAdd = Turbine.UI.MenuItem( "Add" );
	menuItemEffectAdd.Click = function( sender, args )
		self.Name:SetVisible( false );
		self.Timer:SetVisible( false );
		self.Input:SetText( "" );
		self.Input:SetVisible( true );
		self.Input:Focus();
		self.OkButton:SetVisible( true );
		self.CancelButton:SetVisible( true );
		self.OkButton.Click = function( sender, args )
			table.insert( self.settings.match, self.Input:GetText() );
			self:RefreshEffects();
			Settings.Save();
			ResetOptions();
		end
		self.CancelButton.Click = function( sender, args )
			self:Refresh();
		end
		self.Input.KeyDown = function( sender, args )
			if ( args.Action == 162 ) then -- return
				table.insert( self.settings.match, self.Input:GetText() );
				self:RefreshEffects();
				Settings.Save();
				ResetOptions();
			elseif ( args.Action == Turbine.UI.Lotro.Action.Escape ) then
				self:Refresh();
			end
		end
	end
	subMenuEffectItems:Add( menuItemEffectAdd );

	subMenuEffectEdit = Turbine.UI.MenuItem( "Edit" );
	subMenuEffectEditItems = subMenuEffectEdit:GetItems();
	for i=1, table.getn(self.settings.match) do
		local menuItemEffectEdit = Turbine.UI.MenuItem( ( "%02d: %s" ):format( i, self.settings.match[i] ) );
		menuItemEffectEdit.Click = function( sender, args )
			self.Name:SetVisible( false );
			self.Timer:SetVisible( false );
			self.Input:SetText( self.settings.match[i] );
			self.Input:SetVisible( true );
			self.Input:Focus();
			self.OkButton:SetVisible( true );
			self.CancelButton:SetVisible( true );
			self.OkButton.Click = function( sender, args )
				self.settings.match[i] = self.Input:GetText();
				self:RefreshEffects();
				Settings.Save();
				ResetOptions();
			end
			self.CancelButton.Click = function( sender, args )
				self:Refresh();
			end
			self.Input.KeyDown = function( sender, args )
				if ( args.Action == 162 ) then -- return
					self.settings.match[i] = self.Input:GetText();
					self:RefreshEffects();
					Settings.Save();
					ResetOptions();
				elseif ( args.Action == Turbine.UI.Lotro.Action.Escape ) then
					self:Refresh();
				end
			end
		end
		subMenuEffectEditItems:Add( menuItemEffectEdit );
	end
	if ( subMenuEffectEditItems:GetCount() > 0 ) then
		subMenuEffectItems:Add( subMenuEffectEdit );
	end

	subMenuEffectDelete = Turbine.UI.MenuItem( "Delete" );
	subMenuEffectDeleteItems = subMenuEffectDelete:GetItems();
	for i=1, table.getn(self.settings.match) do
		local menuItemEffectDelete = Turbine.UI.MenuItem( ( "%02d: %s" ):format( i, self.settings.match[i] ) );
		menuItemEffectDelete.Click = function( sender, args )
			table.remove( self.settings.match, i );
			self:RefreshEffects();
			Settings.Save();
			ResetOptions();
		end
		subMenuEffectDeleteItems:Add( menuItemEffectDelete );
	end
	if ( subMenuEffectDeleteItems:GetCount() > 0 ) then
		subMenuEffectItems:Add( subMenuEffectDelete );
	end
	contextMenuItems:Add( subMenuEffect );

	-- sub menu bar
	local subMenuBar = Turbine.UI.MenuItem( "Bar" );
	local subMenuBarItems = subMenuBar:GetItems();

	menuItemBarAdd = Turbine.UI.MenuItem( "Add" );
	menuItemBarAdd.Click = function( sender, args )
		if ( sender:IsEnabled() ) then
			self.Add();
		end
	end
	subMenuBarItems:Add( menuItemBarAdd );

	menuItemBarDelete = Turbine.UI.MenuItem( "Delete" );
	menuItemBarDelete.Click = function( sender, args )
		if ( sender:IsEnabled() ) then
			self.Delete();
		end
	end
	subMenuBarItems:Add( menuItemBarDelete );
	contextMenuItems:Add( subMenuBar );

	-- menu item options
	menuItemOptions = Turbine.UI.MenuItem( "Options" );
	menuItemOptions.Click = function( sender, args )
		if ( sender:IsEnabled() ) then
			self.Options();
		end
	end
	contextMenuItems:Add( menuItemOptions );

	contextMenu:ShowMenu();
end