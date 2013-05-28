
import "Turbine.Animation";
import "Turbine.UI.Extensions";

VitalsBar = class( Turbine.UI.Control );

function VitalsBar:Constructor()
	Turbine.UI.Control.Constructor( self );

	self:SetBackColor( Turbine.UI.Color( 1, 1, 0, 0 ) );

	-- The fill bar is the bar used to represent the current value of the
	-- vital.
	self.fillBar = Turbine.UI.Control();
	self.fillBar:SetBackground( "TurbinePlugins/Vitals/Resources/PowerBar.tga" );
	self.fillBar:SetBackColorBlendMode( Turbine.UI.BlendMode.Multiply );
	self.fillBar:SetParent( self );

	-- The buff bar is an additional bar colored differently used to
	-- represent the additional vital granted due to effects that
	-- increase the max.
	self.buffBar = Turbine.UI.Control();
	self.buffBar:SetBackground( "TurbinePlugins/Vitals/Resources/PowerBar.tga" );
	self.buffBar:SetBackColorBlendMode( Turbine.UI.BlendMode.Multiply );
	self.buffBar:SetParent( self );

	-- The debuff bar represents the amount of the vital lost due to
	-- effects that modify the max in a negative way.
	self.debuffBar = Turbine.UI.Control();
	self.debuffBar:SetBackground( "TurbinePlugins/Vitals/Resources/PowerBar.tga" );
	self.debuffBar:SetBackColorBlendMode( Turbine.UI.BlendMode.Multiply );
	self.debuffBar:SetParent( self );

	-- The animation classes for smoothly moving the bars.
	self.value = Turbine.Animation.LerpValue();
	self.max = Turbine.Animation.LerpValue();
	self.baseMax = Turbine.Animation.LerpValue();

	-- The display text for the vitals bar.
	self.text = Turbine.UI.Label();
	self.text:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.text:SetOutlineColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.text:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.text:SetFont( Turbine.UI.Lotro.Font.Verdana12 );
	self.text:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	self.text:SetZOrder( 100 );
	self.text:SetParent( self );

	self.horizontalLayout = Turbine.UI.HorizontalLayout.LeftToRight;
	self.showPercentage = false;

	self.lastUpdate = 0;
end

function VitalsBar:GetHorizontalLayout()
	return self.horizontalLayout;
end

function VitalsBar:SetHorizontalLayout( value )
	self.horizontalLayout = value;
	self:PerformLayout();
end

function VitalsBar:GetShowPercentage()
	return self.showPercentage;
end

function VitalsBar:SetShowPercentage( value )
	self.showPercentage = value;
	self:PerformLayout();
end

function VitalsBar:IsTextVisible()
	return self.text.IsVisible()
end

function VitalsBar:SetTextVisible( value )
	self.text:SetVisible( value );
end

function VitalsBar:SetMouseVisible( value )
	Turbine.UI.Control.SetMouseVisible( self, value );

	self.fillBar:SetMouseVisible( value );
	self.buffBar:SetMouseVisible( value );
	self.debuffBar:SetMouseVisible( value );
	self.text:SetMouseVisible( value );
end

function VitalsBar:SetColor( value )
	self.fillBar:SetBackColor( value );
	self:SetBackColor( Turbine.UI.Color( 0.4, value.R / 2, value.G / 2, value.B / 2 ) );
end

function VitalsBar:GetBuffColor()
	return self.buffBar:GetBackColor();
end

function VitalsBar:SetBuffColor( value )
	self.buffBar:SetBackColor( value );
end

function VitalsBar:GetDebuffColor()
	return self.debuffBar:GetBackColor();
end

function VitalsBar:SetDebuffColor( value )
	self.debuffBar:SetBackColor( value );
end

function VitalsBar:SetValue( value )
	self.value:SetValue( value );

	if ( self.value:NeedsUpdate() ) then
		self:SetWantsUpdates( true );
	end
end

function VitalsBar:SetMax( value )
	self.max:SetValueImmediate( value );
	self.value:SetRate( self.max:GetTargetValue() / self:GetWidth() * 90 );

	if ( self.max:NeedsUpdate() ) then
		self:SetWantsUpdates( true );
	end
end

function VitalsBar:SetBaseMax( value )
	self.baseMax:SetValueImmediate( value );

	if ( self.baseMax:NeedsUpdate() ) then
		self:SetWantsUpdates( true );
	end
end

function VitalsBar:SizeChanged( args )
	self:PerformLayout();
end

function VitalsBar:Update( args )
	local delta = 0;
	local currentTime = Turbine.Engine.GetGameTime();

	if ( self.lastUpdate > 0 ) then
		delta = currentTime - self.lastUpdate;
	end

	self.lastUpdate = currentTime;

	self.value:Update( delta );
	self.max:Update( delta );
	self.baseMax:Update( delta );

	local current = math.floor( self.value:GetValue() + 0.5 ) 
	local max = math.floor( self.max:GetValue() + 0.5 ) 
	local baseMax = math.floor( self.baseMax:GetValue() + 0.5 ) 

	if ( self.showPercentage ) then
		local percentage = math.floor( ( current / max * 100 ) + 0.5 );
		self.text:SetText( percentage .. "%" );
	else
		self.text:SetText( current .. "/" .. max );
	end

	self:PerformLayout();

	if ( not ( self.value:NeedsUpdate() or self.max:NeedsUpdate() or self.baseMax:NeedsUpdate() ) ) then
		self:SetWantsUpdates( false );
		self.lastUpdate = 0;
	end
end

function VitalsBar:PerformLayout()
	local width, height = self:GetSize();

	-- Layout the text.
	self.text:SetPosition( 0, -1 );
	self.text:SetSize( width, height );

	local current = self.value:GetValue();
	local max     = self.max:GetValue();
	local baseMax = self.baseMax:GetValue();

	local baseBarWidthPercent = 1;

	-- Calculate the percentage of the bar that is the base vital display
	-- versus the adjusted display portion for buffs and debuffs.
	if ( max < baseMax ) then
		baseBarWidthPercent = max / baseMax;
	elseif ( baseMax < max ) then
		baseBarWidthPercent = baseMax / max;
	end

	local baseBarFillPercent   = 0;
	local adjustBarFillPercent = 0;

	-- Calculate the amount of fill for the base bar and the buffed bar.
	if ( max < baseMax ) then
		-- Debuff case.
		baseBarFillPercent = current / max;
		adjustBarFillPercent = 1;
	elseif ( current <= baseMax ) then
		baseBarFillPercent = current / baseMax;
	else
		baseBarFillPercent = 1;
		adjustBarFillPercent = ( current - baseMax ) / ( max - baseMax );
	end

	-- Determine the actual layout of the bars now.
	local baseBarLeft      = 0;
	local baseBarMaxWidth  = math.floor( width * baseBarWidthPercent );
	local baseBarWidth     = math.floor( baseBarMaxWidth * baseBarFillPercent );
	local adjustedBarLeft  = 0;
	local adjustedBarWidth = math.floor( ( width - baseBarWidth ) * adjustBarFillPercent );

	if ( self.horizontalLayout == Turbine.UI.HorizontalLayout.LeftToRight ) then
		baseBarLeft     = 0;
		adjustedBarLeft = baseBarMaxWidth;
	else
		baseBarLeft     = width - baseBarWidth; 
		adjustedBarLeft = width - baseBarMaxWidth - adjustedBarWidth;
	end

	self.fillBar:SetPosition( baseBarLeft, 0 );
	self.fillBar:SetSize( baseBarWidth, height );

	self.debuffBar:SetVisible( false );
	self.buffBar:SetVisible( false );

	if ( max < baseMax ) then
		self.debuffBar:SetVisible( true );
		self.debuffBar:SetPosition( adjustedBarLeft, 0 );
		self.debuffBar:SetSize( adjustedBarWidth, height );
	elseif ( baseMax < max ) then
		self.buffBar:SetVisible( true );
		self.buffBar:SetPosition( adjustedBarLeft, 0 );
		self.buffBar:SetSize( adjustedBarWidth, height );
	end
end
