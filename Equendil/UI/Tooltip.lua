import "Equendil.UI.DecoratedContainer";
import "Equendil.UI.Resources";

Tooltip = class( Turbine.UI.Window );
function Tooltip:Constructor()
	Turbine.UI.Window.Constructor( self );
	
	self:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self:SetZOrder( 100 );
	self:SetParent( nil );
	-- self:SetOpacity( 0.8 );

	self.borders = Equendil.UI.DecoratedContainer( Equendil.UI.Decoration.SimpleGreyOutline );
	self.borders:SetParent( self );

	self.label = Turbine.UI.Label();
	self.label:SetParent( self );
	self.label:SetFont( Turbine.UI.Lotro.Font.TrajanPro16 );
	self.label:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.label:SetForeColor( Equendil.UI.Color.TurbineLightYellow );
	self.label:SetOutlineColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.label:SetPosition( 4, 4 );

	self:SetSize( 250, 40 );
end

function Tooltip:SetWidth( width )
	Turbine.UI.Window.SetWidth( self, width );
	self.borders:SetWidth( width );
	self.label:SetWidth( width - 10 );
end

function Tooltip:SetHeight( height )
	Turbine.UI.Window.SetHeight( self, height );
	self.borders:SetHeight( height );
	self.label:SetHeight( height - 10 );
end

function Tooltip:SetSize( width, height )
	self:SetWidth( width );
	self:SetHeight( height );
end

function Tooltip:Show( text )
	local x = Turbine.UI.Display.GetMouseX() + 20;
	local y = Turbine.UI.Display.GetMouseY() + 20;
	
	x = Equendil.Utils.Maths.constrain( 0, x, Turbine.UI.Display.GetWidth() - self:GetWidth() );
	y = Equendil.Utils.Maths.constrain( 0, y, Turbine.UI.Display:GetHeight() - self:GetHeight() );
	
	self:SetPosition( x, y );
	
	self.label:SetText( text );
	self:SetVisible( true );
	self:Activate();

end

function Tooltip:Hide()
	self:SetVisible( false );
end