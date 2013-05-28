
ContextMenuExample = class( Example );

function ContextMenuExample:GetName()
	return "ContextMenu";
end

function ContextMenuExample:IsRunning()
	return self.running;
end

function ContextMenuExample:Start()
	if ( self.running ) then
		return;
	end

	self.running = true;

	-- Display a test menu.
	local contextMenu = Turbine.UI.ContextMenu();

	local menuItems = contextMenu:GetItems();
	menuItems:Add( Turbine.UI.MenuItem( "Red" ) );
	menuItems:Add( Turbine.UI.MenuItem( "Orange" ) );
	menuItems:Add( Turbine.UI.MenuItem( "Yellow" ) );
	menuItems:Add( Turbine.UI.MenuItem( "Green" ) );
	menuItems:Add( Turbine.UI.MenuItem( "Blue" ) );
	menuItems:Add( Turbine.UI.MenuItem( "Purple" ) );

	-- Register event handlers with all the menu items.
	local i;

	for i = 1, menuItems:GetCount() do
		local menuItem = menuItems:Get( i );
		local itemText = menuItem:GetText();
		
		if ( itemText == self.selectedItem ) then
			menuItem:SetChecked( true );
			menuItem:SetEnabled( false );
		end

		menuItem.Click = function( sender, args )
			self.selectedItem = itemText;
			Turbine.Shell.WriteLine( "You have selected " .. self.selectedItem .. "." );

			-- Stop the example when an item is selected.
			self:Stop();
		end
	end

	contextMenu:ShowMenu();

	Example.Start( self );
end

function ContextMenuExample:Stop()
	self.running = false;

	Example.Stop( self );
end

-- Register an instance of this example.
RegisterExample( ContextMenuExample() );
