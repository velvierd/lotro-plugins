-- DragBar by Deusdictum

pcall( function( ) import "PTweety.BuffMonitor.UI.DeltaButtonWindow"; end );
pcall( function( ) import "PTweety.BuffMonitor.UI.DeltaButtonControl"; end );

PTweety.BuffMonitor.UI.DeltaButton = function( tResources, bfZoneTest, ctlAttachTo )
	if PTweety.BuffMonitor.UI.DeltaButtonControl ~= nil and ctlAttachTo ~= nil then
		return DeltaButtonWindow( tResources, bfZoneTest, ctlAttachTo );
	elseif PTweety.BuffMonitor.UI.DeltaButtonWindow ~= nil and ctlAttachTo == nil then
		return DeltaButtonControl( tResources, bfZoneTest );
	end

	return nil;
end