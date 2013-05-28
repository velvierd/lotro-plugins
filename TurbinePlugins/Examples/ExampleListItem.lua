
import "Turbine.UI";

ExampleListItem = class( Turbine.UI.Control );

function ExampleListItem:Constructor( example )
	Turbine.UI.Control.Constructor( self );

	self:SetBlendMode( Turbine.UI.BlendMode.Overlay );

	self.example = example;

	self.example.Started = function( sender, args )
		self.indicator:SetBackColor( Turbine.UI.Color( 1, 0, 1, 0 ) );
	end

	self.example.Stopped = function( sender, args )
		self.indicator:SetBackColor( Turbine.UI.Color( 1, 0, 0.1, 0 ) );
	end

	self.indicator = Turbine.UI.Control();
	self.indicator:SetParent( self );
	self.indicator:SetPosition( 2, 2 );
	self.indicator:SetSize( 16, 16 );
	self.indicator:SetBackground( "TurbinePlugins/Examples/Resources/Indicator.tga" );
	self.indicator:SetBlendMode( Turbine.UI.BlendMode.Overlay );
	self.indicator:SetBackColorBlendMode( Turbine.UI.BlendMode.Multiply );
	self.indicator:SetBackColor( Turbine.UI.Color( 1, 0, 0.1, 0 ) );

	self.nameLabel = Turbine.UI.Label();
	self.nameLabel:SetParent( self );
	self.nameLabel:SetText( example:GetName() );
	self.nameLabel:SetPosition( 24, 5 );

	self:Layout();
end

function ExampleListItem:GetExample()
	return self.example;
end

function ExampleListItem:SetSelected( value )
	if ( value ) then
		self:SetBackColor( Turbine.UI.Color( 1, 0.1, 0.3, 1 ) )
	else
		self:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0 ) )
	end
end

function ExampleListItem:Layout()
	local width = self:GetWidth();

	self.nameLabel:SetSize( width - self.nameLabel:GetLeft(), 18 );
end

function ExampleListItem:SizeChanged()
	self:Layout();
end
