
import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";

SmallEffectDisplay = class( Turbine.UI.Lotro.EffectDisplay );

local baseImageID = 0x41007E35;

function SmallEffectDisplay:Constructor()
	Turbine.UI.Lotro.EffectDisplay.Constructor( self );

	self.elapsedOverlay = Turbine.UI.Control();
	self.elapsedOverlay:SetStretchMode( 1 );
	self.elapsedOverlay:SetMouseVisible( false );
	self.elapsedOverlay:SetZOrder( 100 );
	self.elapsedOverlay:SetOpacity( 0.7 );
	self.elapsedOverlay:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.elapsedOverlay:SetBackColorBlendMode( Turbine.UI.BlendMode.Multiply );
	self.elapsedOverlay:SetParent( self );
end

function SmallEffectDisplay:SetEffect( value )
	Turbine.UI.Lotro.EffectDisplay.SetEffect( self, value );

	if ( value ~= nil ) then
		self.startTime = value:GetStartTime();
		self.duration = value:GetDuration();
		self.effectEndTime = ( self.startTime + self.duration );

		if ( Turbine.Engine.GetGameTime() < self.effectEndTime ) then
			self:SetWantsUpdates( true );
		end
	end
end

function SmallEffectDisplay:Update( args )
	local gameTime = Turbine.Engine.GetGameTime();
	local elapsedTime = gameTime - self.startTime;
	local percentComplete = elapsedTime / self.duration;

	local imageId = baseImageID + math.floor( 60 * percentComplete );

	self.elapsedOverlay:SetStretchMode( 3 );
	self.elapsedOverlay:SetPosition( 1, 1 );
	self.elapsedOverlay:SetSize( 32, 32 );
	self.elapsedOverlay:SetBackground( imageId );

	local width, height = self:GetSize();
	self.elapsedOverlay:SetStretchMode( 1 );
	self.elapsedOverlay:SetSize( width - 2, height - 2 );

	if ( gameTime > self.effectEndTime ) then
		self:SetWantsUpdates( false );
	end
end

function SmallEffectDisplay:SizeChanged( args )
	local width, height = self:GetSize();

	self.elapsedOverlay:SetSize( width - 2, height - 2 );
end
