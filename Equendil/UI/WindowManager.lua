import "Turbine.UI";

import "Equendil.Utils.WeakEvent";

-- WindowManager lets us handles HUD toggling ("F12"), repositioning ("CTRL + \") and 'Escape" actions in a global manner
-- Managed windows and "dragbars" will be made visible/invisible/closed based on those events.

-- WindowManager is a global unique instance 

-- Actions not defined in Turbine.UI.Lotro.Action
local ActionToggleDisplay = 0x100000B3;
local ActionReposition = 0x1000007B;

-- local class, we don't want anyone else to reify this
local Manager = class( Turbine.UI.Window );
function Manager:Constructor()
	Turbine.UI.Window.Constructor( self );

	self.GUIRepositioning = Equendil.Utils.WeakEvent();
	
	-- self:SetVisible( false ); -- we only want to catch key events here

	-- weak table so we don't prevent windows from being garbage collected
	self.windows = setmetatable({}, {__mode='k'}); 
	self.closeableWindows = setmetatable({}, {__mode='k'});
	self.dragBars = setmetatable({}, {__mode='k'});
	
	-- status
	self.repositioning = false;
	self.visibleHUD = true;
	
	-- action handler
	self:SetWantsKeyEvents(true);
	self.KeyDown = function( sender, args )
		if args.Action == ActionReposition then -- repositioning
			self.repositioning = not self.repositioning;
			self.GUIRepositioning( self.repositioning );
		elseif args.Action == ActionToggleDisplay then -- toggle display
			-- if the display was visible, save the visibility status of managedwindows
			if self.visibleHUD then
				for window, visible in pairs( self.windows ) do 
					self.windows[window] = window:IsVisible()
				end
			end
			
			self.visibleHUD = not self.visibleHUD;
			
			-- update visibility of all managed windows
			for window, visibility in pairs( self.windows ) do
				window:SetVisible( self.visibleHUD and visibility );
			end
		elseif args.Action == Turbine.UI.Lotro.Action.Escape then
			for window, v in pairs( self.closeableWindows ) do
				window:Close();
			end
			return;
		else
			return;
		end
	
		-- if we're here, either RepositionUI or ToggleHUD action was taken, set the drag bar visibility accordingly
		for dragBar, _ in pairs( self.dragBars ) do
			self:_SetDragBarVisibility( dragBar );
		end
	end
end

function Manager:_SetDragBarVisibility( dragbar )
	dragbar:SetVisible( self.repositioning and self.visibleHUD );
	if self.repositioning and self.visibleHUD then
		dragbar:Activate();
	end
end

-- manage a window
function Manager:ManageWindow( window, closeOnEscape )
	self.windows[window] = window:IsVisible();
	window:SetVisible( self.visibleHUD and window:IsVisible() );
	
	if closeOnEscape == nil or closeOnEscape == true then -- default = close on escape
		self.closeableWindows[window] = true;
	end
end

-- manage a dragbar
function Manager:ManageDragBar( dragBar )
	self.dragBars[dragBar] = true;
	self:_SetDragBarVisibility( dragBar );
end

function Manager:IsGUIRepositioning()
	return self.repositioning;
end

function Manager:IsGUIVisible()
	return self.visibleHUD;
end

-- create a unique instance of the window manager
WindowManager = Manager();