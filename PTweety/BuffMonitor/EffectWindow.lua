import "Turbine";
import "Turbine.UI";


--[[
	-- define EffectWindow
--]]

EffectWindow = class( Turbine.UI.Window );

-- invisible window hack
EffectWindow.InvisibleColor = Turbine.UI.Color(0, 0, 0, 0);

function EffectWindow:Constructor( tSettings, id )
	Turbine.UI.Window.Constructor( self );

	self.settings = tSettings;

	self:SetPosition( self.settings.left, self.settings.top );
	self:SetSize( 0, 0 );

	-- EffectList
	self.EffectList = PTweety.BuffMonitor.EffectList( self.settings, id );
	self.EffectList:SetParent( self );

	self.EffectList.ItemAdded = function( sender, args )
		self:Refresh();
	end

	self.EffectList.ItemRemoved = function( sender, args )
		self:Refresh();
	end

	self.DragBar = PTweety.BuffMonitor.UI.DragBar( self, self.settings.name );
	self.DragBar:SetRotator( true );
	self.DragBar:SetRotatorOffset( 3, 20 );
	self.DragBar:Refresh();

	self.ResizeHandle = PTweety.BuffMonitor.UI.ResizeHandle( self );
	self.ResizeHandle:Refresh();

	self.KeyDown = function( sender, args )
		if ( args.Action == 0x100000B3 ) then
			sender:SetVisible( false );
		end
		if ( args.Action == Turbine.UI.Lotro.Action.Escape ) then
			sender:SetVisible( false );
		end
		--self:UpdateVisibility();
	end

	self.PositionChanged = function( sender, args )
		self.settings.left, self.settings.top = self:GetPosition();
		self.DragBar:Refresh();
		self.ResizeHandle:Refresh();
		Settings.Save();
		ResetOptions();
	end

	self.SizeChanged = function( sender, args )
		local width, height	= self:GetSize();

		if ( self.settings.orientation == Turbine.UI.Orientation.Horizontal ) then
			self.settings.itemWidth = math.floor( width / #self.settings.effects );
			self.settings.itemHeight = height;
			self.ResizeHandle:SetMinimumSize( 100 * #self.settings.effects, 20 );
			self.ResizeHandle:SetMaximumSize( 400 * #self.settings.effects, 50 );
		else
			self.settings.itemWidth = width;
			self.settings.itemHeight = math.floor( height / #self.settings.effects );
			self.ResizeHandle:SetMinimumSize( 100, 20 * #self.settings.effects );
			self.ResizeHandle:SetMaximumSize( 400, 50 * #self.settings.effects );
		end

		self.DragBar:Refresh();
		self.ResizeHandle:Refresh();
		self:Refresh();
		Settings.Save();
		ResetOptions();
	end

	self.VisibleChanged = function( sender, args )
		--self.settings.visible = self:IsVisible();
		self.DragBar:Refresh();
		self.ResizeHandle:Refresh();
		--Settings.Save();
	end

	self.MouseEnter = function( sender, args )
		if ( self.DragBar:IsDraggable() ) then
			self:SetMouseVisible( false );
		end
	end

	self.MouseLeave = function( sender, args )
		if ( not self.DragBar:IsBeingDragged() ) then
			self:SetMouseVisible( true );
		end
	end

	-- register to get player events
	PlayerManager:AddCallback( self );

	self:Refresh();
	self:UpdateVisibility();
end

function EffectWindow:Destroy()
	self:SetVisible( false );

	self.DragBar:SetVisible( false );
	self.DragBar = nil;
	self.ResizeHandle:SetVisible( false );
	self.ResizeHandle = nil;

	self.KeyDown = nil;
	self.PositionChanged = nil;
	self.SizeChanged = nil;
	self.VisibleChanged = nil;
	self.MouseEnter = nil;
	self.MouseLeave = nil;

	self.EffectList:Destroy();
	self.EffectList = nil;
end

function EffectWindow:InCombatChanged( value )
	self:UpdateVisibility();
end

function EffectWindow:MountChanged( value )
	self:UpdateVisibility();
end

function EffectWindow:UpdateVisibility()
	if ( self.settings.visibleType == WindowVisibility.InCombat ) then
		visible = PlayerManager:IsInCombat();
	elseif ( self.settings.visibleType == WindowVisibility.OutOfCombat ) then
		visible = not PlayerManager:IsInCombat();
	else -- self.settings.visibleType == WindowVisibility.Always
		visible = true;
	end
	if ( not self.settings.visibleMounted and PlayerManager:IsMounted() ) then
		visible = false;
	end
	if ( not self.settings.visibleByFoot and not PlayerManager:IsMounted() ) then
		visible = false;
	end
	self:SetVisible( visible );
end

function EffectWindow:Rotate()
	if ( self.settings.orientation == Turbine.UI.Orientation.Horizontal ) then
		self.settings.orientation = Turbine.UI.Orientation.Vertical;
	else
		self.settings.orientation = Turbine.UI.Orientation.Horizontal;
	end
	self:Refresh();
end

function EffectWindow:Refresh()
	if ( self.settings.orientation == Turbine.UI.Orientation.Horizontal ) then
		self:SetSize( self.settings.itemWidth * #self.settings.effects, self.settings.itemHeight );
	else
		self:SetSize( self.settings.itemWidth, #self.settings.effects * self.settings.itemHeight );
	end

	local width, height	= self:GetSize();
	self.EffectList:SetSize( width, height );
	self.EffectList:Refresh();
end

function EffectWindow:ValidateSize( nWidth, nHeight )
	local nW = nWidth;
	local nH = nHeight;

	-- If the alt key is being held down then snap to a background grid that is 4x2
	if ( self:IsAltKeyDown() ) then
		nW = math.ceil( nWidth / 4 ) * 4;
		nH = math.ceil( nHeight / 2 ) * 2;
	end

	self:SetSize( nW, nH );
end

-- Spezial thanks to MrJackdaw
function EffectWindow:ValidatePosition( nLeft, nTop )
	local nX = nLeft;
	local nY = nTop;
	local width, height = self:GetSize();

	-- If the alt key is being held down then snap to a background grid that is 16x16
	if ( self:IsAltKeyDown() ) then
		nX = math.ceil( nLeft / 16 ) * 16;
		nY = math.ceil( nTop / 16 ) * 16;

	-- Snap to other bars if the shift key is held down
	elseif ( self:IsShiftKeyDown() ) then
		local snapDistance = 10;
		local Borders = { { { x = nLeft, y = nTop }, { x = nLeft, y = nTop + height } },
											{ { x = nLeft, y = nTop }, { x = nLeft + width, y = nTop } },
											{ { x = nLeft + width, y = nTop }, { x = nLeft + width, y = nTop + height } },
											{ { x = nLeft, y = nTop + height }, { x = nLeft + width, y = nTop + height } } };
		for i=1, #effectWindows do
			local minDistance = { x = snapDistance * 2, y = snapDistance * 2 };
			local cOtherWindow = effectWindows[i];
			local O = {};
			O[1] = { x = cOtherWindow:GetLeft(), y = cOtherWindow:GetTop() };
			O[2] = { x = O[1].x + cOtherWindow:GetWidth(), y = O[1].y + cOtherWindow:GetHeight() };

			if ( cOtherWindow ~= self ) then
				for i = 1, 2 do
					if ( PTweety.BuffMonitor.Utils.DistancePointToLine( O[i], Borders[1] ) <= snapDistance ) then
						nX = O[i].x;
					end
					if ( PTweety.BuffMonitor.Utils.DistancePointToLine( O[i], Borders[2] ) <= snapDistance ) then
						nY = O[i].y;
					end
					if ( PTweety.BuffMonitor.Utils.DistancePointToLine( O[i], Borders[3] ) <= snapDistance ) then
						nX = O[i].x - width;
					end
					if ( PTweety.BuffMonitor.Utils.DistancePointToLine( O[i], Borders[4] ) <= snapDistance ) then
						nY = O[i].y - height;
					end
				end
			end
		end
	end

	self:SetPosition( PTweety.BuffMonitor.Utils.ValidatePosition( nX, nY, width, height ) );
end
