import "Turbine.UI";


-- Actions not defined in Turbine.UI.Lotro.Action
local ActionReposition = 0x1000007B;
local ActionToggleHUD = 0x100000B3;


--[[
	-- define ResizeHandle
--]]

ResizeHandle = class( Turbine.UI.Window );

function ResizeHandle:Constructor( ctlAttachTo, nMinWidth, nMinHeight, nMaxWidth, nMaxHeight )
	Turbine.UI.Window.Constructor( self );

	self.wndTarget = ctlAttachTo;

	if type(nMinWidth) ~= "number" then
		self.nMinWidth = 0;
	else
		self.nMinWidth = nMinWidth;
	end

	if type(nMinHeight) ~= "number" then
		self.nMinHeight = 0;
	else
		self.nMinHeight = nMinHeight;
	end

	if type(nMaxWidth) ~= "number" then
		self.nMaxWidth = 0;
	else
		self.nMaxWidth = nMaxWidth;
	end

	if type(nMaxHeight) ~= "number" then
		self.nMaxHeight = 0;
	else
		self.nMaxHeight = nMaxHeight;
	end

	self:SetZOrder( 100 );
	self:SetSize( 16, 16 );
	self:SetPosition( self.wndTarget:GetLeft() + self.wndTarget:GetWidth() - self:GetWidth(), self.wndTarget:GetTop() + self.wndTarget:GetHeight() - self:GetHeight() );
	self:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self:SetBackground( 'PTweety/BuffMonitor/Resources/ResizeHandle_resize_widget.tga' );
	self:SetVisible( false );
	self:SetOpacity( 1 );

	self:SetResizeable( false );
	self.bHUDVisible = true;
	self:SetHUDVisible( true );

	self.KeyDown = function( sender, args )
		if args.Action == ActionReposition then --and self:GetAllowsResizing() then
			self:ToggleResizeable();
		elseif args.Action == ActionToggleHUD then --and self:GetAllowsHUDHiding() then
			self:ToggleHUDVisible();
		end
	end

	self:SetWantsKeyEvents( true );
	
	self.MouseDown = function( sender, args )
		sender.dragStartX = args.X;
		sender.dragStartY = args.Y;
		sender.dragging = true;
	end

	self.MouseMove = function( sender, args )
		local width, height = self.wndTarget:GetSize();

		if ( sender.dragging ) then
			-- beware of borders
			local newwidth = math.min( math.max( width + ( args.X - sender.dragStartX ), self.nMinWidth ), self.nMaxWidth );
			local newheight = math.min( math.max( height + ( args.Y - sender.dragStartY ), self.nMinHeight ), self.nMaxHeight );

			if type( self.wndTarget.ValidateSize ) == "function" then
				self.wndTarget:ValidateSize( newwidth, newheight );
			else
				self.wndTarget:SetSize( newwidth, newheight );
			end

			sender:RecalculatePosition();
		end
	end

	self.MouseUp = function( sender, args )
		sender.dragging = false;
		if type( self.wndTarget.Resized ) == "function" then
			self.wndTarget:Resized();
		end
	end

end

function ResizeHandle:RecalculatePosition( )
	local left, top = self.wndTarget:GetPosition();
	local width, height = self.wndTarget:GetSize();
	self:SetPosition( left + width - self:GetWidth(), top + height - self:GetHeight() );
end

function ResizeHandle:Refresh( )
	self:RecalculatePosition();
end

function ResizeHandle:SetMinimumSize( width, height )
	self.nMinWidth = width;
	self.nMinHeight = height;
end

function ResizeHandle:SetMaximumSize( width, height )
	self.nMaxWidth = width;
	self.nMaxHeight = height;
end


function ResizeHandle:SetResizeable( bValue )
	if self.bReposUI == bValue then
		return;
	end

	self.bReposUI = bValue;

	if self:IsResizeable() then
		self:SetVisible( self:IsHUDVisible() );

		if type( self.wndTarget.ResizeEnable ) == "function" then
			self.wndTarget:ResizeEnable();
		end
	else
		self:SetVisible( false );

		if type( self.wndTarget.ResizeDisable ) == "function" then
			self.wndTarget:ResizeDisable();
		end
	end
end

function ResizeHandle:IsResizeable( )
	return self.bReposUI;
end

function ResizeHandle:ToggleResizeable( )
	self:SetResizeable( not self:IsResizeable() );
end


function ResizeHandle:SetHUDVisible( bValue )
	if self.bHUDVisible == bValue then
		return;
	end

	self.bHUDVisible = bValue;

	if self:IsHUDVisible() then
		self.wndTarget:SetVisible( true );
		self:SetVisible( self:IsResizeable() );
		if type( self.wndTarget.HUDShow ) == "function" then
			self.wndTarget:HUDShow();
		end
	else
		self.wndTarget:SetVisible( false );
		self:SetVisible( false );
		if type( self.wndTarget.HUDHide ) == "function" then
			self.wndTarget:HUDHide();
		end
	end
end

function ResizeHandle:IsHUDVisible( )
	return self.bHUDVisible;
end

function ResizeHandle:ToggleHUDVisible( )
	self:SetHUDVisible( not self:IsHUDVisible() );
end
