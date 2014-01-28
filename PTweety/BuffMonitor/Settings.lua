import "Turbine.Gameplay";
import "PTweety.BuffMonitor";


--[[
	-- define Settings
--]]

Settings = class();

function Settings:Constructor( reset )
	if ( reset ) then
		-- set defaults
		self:SetDefaults();
		self:Save();
	else
		self:_Load();
	end
end

function Settings:Encode( object )
	if ( Turbine.Engine.GetLocale() == "en" ) then
		return object;
	end

	return PTweety.BuffMonitor.Utils.DeepCopyEncode( object );
end

function Settings:Decode( object )
	if ( Turbine.Engine.GetLocale() == "en" ) then
		return object;
	end

	return PTweety.BuffMonitor.Utils.DeepCopyDecode( object );
end

function Settings:Copy()
	return PTweety.BuffMonitor.Utils.DeepCopy( self );
end

function Settings:_Load()
	local fLoad = Turbine.PluginData.Load; -- VindarPatch may not touch me
	local tSettings = fLoad( Turbine.DataScope.Character, "BuffMonitorSettings" );

	if ( type( tSettings ) ~= "table" ) then
		-- set defaults
		self:SetDefaults();
		self:Save();
	else
		tSettings = self:Decode( tSettings );

		for i,v in pairs( tSettings ) do
			if (i == "windows") then
				self.windows = {};
				local size = table.getn(v);
				for i = 1, size do
					self.windows[i] = v[i];
				end
			else
				self[i] = v;
			end
		end
		self:CheckMigration();
	end
end

function Settings:_Save()
	local fSave = Turbine.PluginData.Save; -- VindarPatch may not touch me
	local tSettings = self:Encode( self );

	fSave( Turbine.DataScope.Character, "BuffMonitorSettings", tSettings );
end

function Settings:CheckMigration()
	local save = false;
	if ( self.version == nil ) then
		self.LogManager = nil;
		self.windows = {};
		for i,v in pairs( self.BuffMonitorWindow.groups ) do
			self.windows[i] = v.window;
			
			self.windows[i].name = self.windows[i].title;
			self.windows[i].title = nil;
			self.windows[i].visible = true;
			self.windows[i].visibleType = WindowVisibility.Always;
			self.windows[i].visibleMounted = true;
			self.windows[i].visibleByFoot = true;
			self.windows[i].colors = Settings.GetColorDefaults();
			self.windows[i].showEffect = { icon = true, name = true, timer = true, elapsed = true, remaining = true };
			
			local itemWidth, itemHeight = 0;
			
			if ( self.windows[i].orientation == Turbine.UI.Orientation.Horizontal ) then
				itemWidth = math.floor( self.windows[i].width / #self.windows[i].effects );
				itemHeight = self.windows[i].height;
			else
				itemWidth = self.windows[i].width;
				itemHeight = math.floor( self.windows[i].height / #self.windows[i].effects );
			end

			self.windows[i].itemWidth = itemWidth;
			self.windows[i].itemHeight = itemHeight;
		end
		self.BuffMonitorWindow = nil;
		self.version = 1;
		save = true;
	end

	if ( save ) then
		self:Save();
	end
end

function Settings.GetEffectItemDefaults()
	-- effect window
	return { match = {} };
end

function Settings.GetColorDefaults()
	-- colors
	local colors = {};
	local col = Colors.Flash;
	colors[col] = {};
	colors[col].remaining = { a = 255, r = 255, g = 255, b = 255 };
	colors[col].elapsed   = { a = 102, r = 255, g = 255, b = 255 };
	
	col = Colors.Primary;
	colors[col] = {};
	colors[col].remaining = { a = 255, r =   0, g = 121, b = 254 };
	colors[col].elapsed   = { a = 102, r =   0, g = 121, b = 254 };

	col = Colors.Secondary;
	colors[col] = {};
	colors[col].remaining = { a = 255, r = 255, g = 255, b = 255 };
	colors[col].elapsed   = { a = 102, r = 255, g = 255, b = 255 };
	return colors;
end

function Settings.GetEffectWindowDefaults()
	-- effect window
	return {
		left = 200,
		top = 25,
		itemWidth = 200,
		itemHeight = 24,
		colors = Settings.GetColorDefaults(),
		showEffect = { icon = true, name = true, timer = true, elapsed = true, remaining = true },
		orientation = Turbine.UI.Orientation.Vertical,
		name = "New Window",
		visible = true,
		visibleType = WindowVisibility.Always,
		visibleMounted = true,
		visibleByFoot = true,
		effects = { Settings.GetEffectItemDefaults() }
	};
end

function Settings:SetDefaults()
	-- current settings version
	self.version = 1;

	-- effect windows
	self.windows = { Settings.GetEffectWindowDefaults() };
end

-- load the plugin settings
function Settings.Load()
	Settings.instance = Settings( false );
	--if ( not pcall( function() Settings.instance = Settings( false ); end ) ) then
	--	Settings.instance = Settings( true );
	--end
end

-- save the plugin settings
function Settings.Save()
	if ( Settings.instance ~= nil ) then
		Settings.instance:_Save();
	end
end

-- reset the settings
function Settings.Reset()
	Settings.instance = Settings( true );
end