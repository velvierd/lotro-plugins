import "Turbine";
import "Turbine.UI";


--[[
	-- define EffectList
--]]

EffectList = class( Turbine.UI.ListBox );

function EffectList:Constructor( tSettings, id )
	Turbine.UI.ListBox.Constructor( self );

	self.settings = tSettings;

	self:SetPosition( 0, 0 );
	self:SetOrientation( Turbine.UI.Orientation.Horizontal );
	self:SetMouseVisible(false);

	self.SizeChanged = function( sender, args )
		local nEffectItemCount = self:GetItemCount();

		if ( nEffectItemCount > 0 ) then
			for i=1, nEffectItemCount do
				self:GetItem( i ):SetSize( self.settings.itemWidth, self.settings.itemHeight );
			end
		end
	end

	for i = 1, #self.settings.effects do
		self:AddEffect( self.settings.effects[i], id );
	end

	self:Refresh();
end

function EffectList:Destroy()
	self:SetVisible( false );

	self.SizeChanged = nil;

	for i=1, self:GetItemCount() do
		self:GetItem( i ):Destroy();
	end
end

function EffectList:SetMaxItemsPerLine()
	if ( self.settings.orientation == Turbine.UI.Orientation.Horizontal ) then
		Turbine.UI.ListBox.SetMaxItemsPerLine( self, self:GetItemCount() or 1 );
	else
		Turbine.UI.ListBox.SetMaxItemsPerLine( self, 1 );
	end
end

function EffectList:AddEffect( effect, id )
	if ( effect == nil ) then
		table.insert( self.settings.effects, Settings.GetEffectItemDefaults() );
		effect = self.settings.effects[#self.settings.effects];
		Settings.Save();
		ResetOptions();
	end

	local effectItem = EffectItem( effect, { colors = self.settings.colors, showEffect = self.settings.showEffect } )
	effectItem:SetParent( self );
	effectItem:SetSize( self.settings.itemWidth, self.settings.itemHeight );
	effectItem.Add = function()
		-- add default EffectItem
		self:AddEffect( nil, id );
	end
	effectItem.Delete = function()
		table.foreach( self.settings.effects, function( k, v ) if ( v == effectItem.settings ) then table.remove( self.settings.effects, k ) end end );
		self:RemoveItem( effectItem );
		effectItem:Destroy();
		Settings.Save();
		ResetOptions();
		self:Refresh();

		if ( #self.settings.effects == 0 ) then
			-- add default EffectItem
			self:AddEffect( nil, id );
		end
	end
	effectItem.Options = function()
		Turbine.PluginManager.ShowOptions(Plugins.BuffMonitor);
		PTweety.BuffMonitor.options:SetOptions( id );
	end
	self:AddItem( effectItem );

	self:Refresh();
end

function EffectList:Refresh()
	self:SetMaxItemsPerLine();
end
