import "Turbine";
import "Turbine.UI";
import "Equendil.QuickBars.QuickBar";
import "Equendil.QuickBars.SetupWindow";
import "Equendil.UI.WindowManager";
import "Equendil.Utils.PluginData";

Mng = class( Turbine.UI.Window ); -- inheriting from window se we can trackthe repositioning event (CTRL+ \)

Mng.DataKey = "EQ_QuickBars";

function Mng:Constructor()
	Turbine.UI.Window.Constructor( self );

	self.bars = {};
	
	-- event handler
	self.BarAdded = Equendil.Utils.Event();
	self.BarRemoved = Equendil.Utils.Event();
	
	self.actionSaveAll = function() self:Save() end;
	
	-- We want to save data when we exit repositioning to make sure positions are proper (and not of automatically expanded bars)
	self.actionGUIRepositioning = function( flag ) 
		if flag == false then
			-- nothing might actually have changed but better safe than sorry, if the bars were saved during repositioning, position might be wrong
			self:Save();
		end
		self:_UpdateForcedExpansion();
	end
	
	Equendil.UI.WindowManager.GUIRepositioning:Add( self.actionGUIRepositioning );
	
	self.setup = Equendil.QuickBars.SetupWindow( self );
	self.setup.Closed = function() 
		self:_UpdateForcedUnlock();
		self:_UpdateForcedExpansion();
	end
end

function Mng:ToggleSetup()
	self:ShowSetup( not self.setup:IsVisible() );
end

function Mng:ShowSetup( flag )
	self.setup:SetVisible( flag );
	if flag then
		self.setup:Activate();
	end
	self:_UpdateForcedUnlock();
	self:_UpdateForcedExpansion();
end

function Mng:_UpdateForcedUnlock()
	local forcedUnlock = self.setup:IsVisible();
	for _, bar in pairs( self.bars ) do
		bar:ForceUnlock( forcedUnlock );
	end
end

function Mng:_UpdateForcedExpansion()
	local forcedExpansion = Equendil.UI.WindowManager:IsGUIRepositioning() or self.setup:IsVisible();
	for _, bar in pairs( self.bars ) do
		bar:ForceExpansion( forcedExpansion );
	end
end

function Mng:_NewBar()
	local bar = Equendil.QuickBars.QuickBar();
	bar:SetName( "Новая панель" );
	bar:SetMode( Equendil.QuickBars.Mode.Selection );
	bar:SetSize( 12 );
	bar:SetDirection( Equendil.QuickBars.Direction.Right );
	bar:ForceExpansion( Equendil.UI.WindowManager:IsGUIRepositioning() or self.setup:IsVisible() );
	bar:ForceUnlock( self.setup:IsVisible() );
	
	table.insert( self.bars, bar );

	return bar;
end

-- create a new bar
function Mng:NewBar()
	local bar = self:_NewBar();
	
	-- register the callback for bar changes
	bar.Changed:Add( self.actionSaveAll );
	
	-- fire an event
	self.BarAdded( bar );
	
	self:Save();
	
	return bar;
end

function Mng:RemoveBar( bar )
	local index = -1;
	for i, v in ipairs( self.bars ) do
		if bar == v then index = i end
	end
	
	if index ~= -1 then 
		table.remove( self.bars, index );
		bar.Changed:Remove( self.actionSaveAll );
		self.BarRemoved( bar );
		bar:Dispose(); -- HACKish
	end
	
	self:Save();
end

function Mng:GetBars()
	return self.bars;
end

function Mng:Reset()
	for i, bar in ipairs( self.bars ) do 
		bar.Changed:Remove( actionSaveAll );
		bar:Dispose(); -- HACK ish
		self.BarRemoved( bar );
	end
	
	self.bars = {};
end

function Mng:Save()
	local function dataSaved() end -- data is saved, nothing more to do ....

	local pluginData = {};
	pluginData.bars = {};
	
	for i, bar in ipairs( self.bars ) do 
		pluginData.bars[i] = bar:Serialize();
	end
	
	Equendil.Utils.PluginData.Save(Turbine.DataScope.Character, Mng.DataKey, pluginData, dataSaved ); 
end

function Mng:Deserialize( data )
	-- first we clear everything ...
	self:Reset();

	if data == nil then return end;
	
	-- and setup the bars 
	for i, barData in ipairs( data.bars ) do
		-- create a new bar and load the data
		local bar = self:_NewBar();
		bar:Deserialize( data.bars[i] );
		
		-- register callback for bar changes 
		bar.Changed:Add( self.actionSaveAll );

		-- notification
		self.BarAdded( bar );
	end
end

function Mng:Load()
	-- callback handling the data in case of defered load
	local function dataLoaded( data )	self:Deserialize( data ); end

	-- Get the data, which we might get either as a return value or through the callback ...
	local pluginData = Equendil.Utils.PluginData.Load( Turbine.DataScope.Character, Mng.DataKey, dataLoaded );
	-- seems the defered handler is called no matter what so we handle the data there
end
