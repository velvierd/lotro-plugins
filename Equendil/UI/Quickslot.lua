import "Turbine.UI.Lotro";

-- Quickslot class override. Quickslot is blanked if its shortcut is dragged out.
-- TODO: swap shortcuts
QuickSlot = class( Turbine.UI.Lotro.Quickslot );

function QuickSlot:Constructor()
	Turbine.UI.Lotro.Quickslot.Constructor( self );

	self.pressed = false;
	self.dragging = false;
	self.locked = false;
	
	-- event
	self.Clicked = Equendil.Utils.Event;
	
	-- Drag & drop is possibly initiated by pressing the left mouse button ...
	self.MouseDown = function( sender, args )
		if args.Button == Turbine.UI.MouseButton.Left then
			self.pressed = true;
		end
	end
	-- Drag & drop terminates when the left mouse button is released ...
	-- however it could just be a click, so the quickslot is only cleared if the pointer left the quickslot since the left mouse button was pressed
	self.MouseUp = function( sender, args )
		-- we get a mouse up event when drag & dropping with the mouse button still down .... can't rely on that event
		-- still clearing the "pressed" button status and the shortcut to keep this working ...
		if args.Button == Turbine.UI.MouseButton.Left then
			if self.dragging and not self.locked then -- did the mouse leave the quickslot ?
				self:SetShortcut(nil); -- blank the shortcut, this will trigger a ShortCutChanged() event
			end
		end -- resets flags
		self.pressed = false;
		self.dragging = false;
	end
	
	-- if the pointer leaves the quickslot since the left mouse button was pressed, we'll assume it's a proper drag & drop action
	self.MouseLeave = function( sender, args )
		if self.pressed then
			self.dragging = true;
		end
	end

	-- Relay mouse click events
	self.MouseClick = function( sender, args )
		if self.Clicked ~= nil then
			self.Clicked( args.Button );
		end
	end
	
	-- quickslot seems to go invisble when a shortcut is cleared (manually, item sold, destroyed ...). 
	-- We don't want that. behaviour, so we update the visibility of the quickslot everytime it's changed (from the outside)
	self.actionUpdateVisibility = function( sender, args )
		self:_UpdateVisibility();
	end
	
	self.VisibleChanged = self.actionUpdateVisibility;
end

function QuickSlot:_UpdateVisibility()
	local shortcut = self:GetShortcut();
	local isEmpty = shortcut:GetType() == Turbine.UI.Lotro.ShortcutType.Undefined;
	self.VisibleChanged = nil;
	self:SetVisible( not ( self.locked and isEmpty ) );
	self.VisibleChanged = self.actionUpdateVisibility;
end

-- overloading SetShortcut so it doesn't fail if we set a shortcut that's not valid (item sold to a vendor for instance)
function QuickSlot:SetShortcut( shortcut )
	local success, rv = pcall( Turbine.UI.Lotro.Quickslot.SetShortcut, self, shortcut );
	return rv;
end

function QuickSlot:Lock( flag )
	self.locked = flag;
	self:SetAllowDrop( not flag );
	self:_UpdateVisibility();
end