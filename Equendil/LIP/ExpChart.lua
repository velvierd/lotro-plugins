local function FormatNumber( n )
	if n < 1000 then
		return string.format( "%d", n );
	else 
		local r = math.mod( n, 1000 );
		return FormatNumber( math.floor( n / 1000 ) ) .. "," .. string.format( "%03d", r );
	end
end


local ExpItem = class( Turbine.UI.Control );
function ExpItem:Constructor( level, totalExp, expToLevel )
	Turbine.UI.Control.Constructor( self );
	
	self.level = level;
	self.exp = exp;
	
	self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	self:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self:SetSize( 235, 16 );

	self.labelLevel = Turbine.UI.Label();
	self.labelLevel:SetParent( self );
	self.labelLevel:SetSize( 30, 16 );
	self.labelLevel:SetPosition( 0, 0 );
	self.labelLevel:SetFont( L.Font.RightPanelList );
	self.labelLevel:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelLevel:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.labelLevel:SetMouseVisible( false );
	self.labelLevel:SetText( tostring( level ) );
	
	self.labelTotalExp = Turbine.UI.Label();
	self.labelTotalExp:SetParent( self );
	self.labelTotalExp:SetSize( 80, 16 );
	self.labelTotalExp:SetPosition( 40, 0 );
	self.labelTotalExp:SetFont( L.Font.RightPanelList );
	self.labelTotalExp:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelTotalExp:SetForeColor( Equendil.UI.Color.Green );
	self.labelTotalExp:SetMouseVisible( false );
	self.labelTotalExp:SetText( FormatNumber( totalExp ) );
	
	self.labelExpToLevel = Turbine.UI.Label();
	self.labelExpToLevel:SetParent( self );
	self.labelExpToLevel:SetSize( 80, 16 );
	self.labelExpToLevel:SetPosition( 130, 0 );
	self.labelExpToLevel:SetFont( L.Font.RightPanelList );
	self.labelExpToLevel:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelExpToLevel:SetForeColor( Equendil.UI.Color.Green );
	self.labelExpToLevel:SetMouseVisible( false );
	if expToLevel ~= 0 then
		self.labelExpToLevel:SetText( FormatNumber( expToLevel ) );
	end
end

function ExpItem:Highlight()
	self:SetBackColor( Turbine.UI.Color( 0.5, 0.5, 0.5, 1 ) );
end

ExpChart = class( Turbine.UI.Control );
function ExpChart:Constructor()
	Turbine.UI.Control.Constructor( self );
	
	self.legendaryItem = nil;
	self:SetSize( 235, 286 );
	self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	self:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	
	self.label = Turbine.UI.Label();
	self.label:SetParent( self );
	self.label:SetSize( 235, 16 );
	self.label:SetPosition( 0, 0 );
	self.label:SetFont( L.Font.RightPanelHeader );
	self.label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.label:SetForeColor( Equendil.UI.Color.White );
	self.label:SetMouseVisible( false );
	
	self.labelLevel = Turbine.UI.Label();
	self.labelLevel:SetParent( self );
	self.labelLevel:SetSize( 30, 16 );
	self.labelLevel:SetPosition( 0, 20 );
	self.labelLevel:SetFont( L.Font.RightPanelHeader );
	self.labelLevel:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelLevel:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.labelLevel:SetMouseVisible( false );
	self.labelLevel:SetText( L["Lvl"] );
	
	self.labelTotalExp = Turbine.UI.Label();
	self.labelTotalExp:SetParent( self );
	self.labelTotalExp:SetSize( 80, 16 );
	self.labelTotalExp:SetPosition( 40, 20 );
	self.labelTotalExp:SetFont( L.Font.RightPanelHeader );
	self.labelTotalExp:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelTotalExp:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.labelTotalExp:SetMouseVisible( false );
	self.labelTotalExp:SetText( L["Exp Total"] );
	
	self.labelTotalExp = Turbine.UI.Label();
	self.labelTotalExp:SetParent( self );
	self.labelTotalExp:SetSize( 80, 16 );
	self.labelTotalExp:SetPosition( 130, 20 );
	self.labelTotalExp:SetFont( L.Font.RightPanelHeader );
	self.labelTotalExp:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	self.labelTotalExp:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.labelTotalExp:SetMouseVisible( false );
	self.labelTotalExp:SetText( L["Exp Needed"] );	
	
	self.levelList = Turbine.UI.ListBox();
    self.levelList:SetParent( self );
    self.levelList:SetPosition( 0, 40 );
    self.levelList:SetSize( 340, 256 );
	self.levelList:SetVerticalScrollBar( self.scrollbar );
	self.levelList:SetMouseVisible( false );
	
	self.actionLegendaryItemChanged = function() self:Update() end;
end

function ExpChart:Set( legendaryItem )
	if self.legendaryItem ~= nil then
		self.legendaryItem.Changed:Remove( self.actionLegendaryItemChanged );
	end
	
	self.legendaryItem = legendaryItem;

	if self.legendaryItem ~= nil then
		self.legendaryItem.Changed:Add( self.actionLegendaryItemChanged );
	end
	
	self:Update();
end

-- Experience needed for each level up to lvl 30, further levels increase by 20,000 for a third, 40,000 for a 2nd age, 60,000 for a 1st age
local ExperiencePerLevel = 
{
	0,			-- level 1
	100,
	350,
	850,
	1700,		-- level 5
	3000,
	4850,
	7718,
	11130,		
	15435,		-- level 10
	20738,		-- level 11
	27143,
	34755,
	43680,
	54023,		-- level 15
	65888,
	79380,
	94605,
	111668,
	130673,		-- level 20
	151725,
	174930,
	200393,
	228218,
	258510,		-- level 25
	291375,
	330031,
	372000,
	418068,
	467828		-- level 30
};

local function GetExperienceToLevel( level, age )
	if level > 30 then
		if age == 1 then
			return ExperiencePerLevel[30] + ( 80000 * (level - 30 ) );
		else
			return ExperiencePerLevel[30] + ( ( ( 4 - age ) * 20000 ) * (level - 30 ) );
		end
	else
		return ExperiencePerLevel[level];
	end
end

function ExpChart:Update()
	self.levelList:ClearItems();

	if self.legendaryItem == nil then 
		self.label:SetText("");
		return 
	end

	self.label:SetForeColor( Equendil.UI.Color.TurbineLI[self.legendaryItem:GetAge()] );
	
	local currentLevelAdded = false;
	local currentLevel = self.legendaryItem:GetLevel();
	local age = self.legendaryItem:GetAge();
	self.label:SetText( self.legendaryItem:GetName() );
	for _,level in ipairs( {2,10,11,20,21,30,31,40,41,50,51,60,70} ) do 
		if currentLevelAdded == false and currentLevel < level then
			local expItem = ExpItem( currentLevel, GetExperienceToLevel( currentLevel, age ), 0 );
			self.levelList:AddItem( expItem );
			expItem:Highlight();
			currentLevelAdded = true;
		end
		local totalExp = GetExperienceToLevel( level, age );
		local expToLevel = math.max( 0, totalExp - GetExperienceToLevel( currentLevel, age ) );
		local expItem = ExpItem( level, totalExp, expToLevel  );
		self.levelList:AddItem( expItem );
		if level == currentLevel then
			expItem:Highlight();
			currentLevelAdded = true;
		end
	end
end


