import "Turbine.UI";

CommonControl = {};

CommonControl.LabelFieldHeading = function( name )
	local label = Turbine.UI.Label();
	label:SetFont( Turbine.UI.Lotro.Font.TrajanPro16 );
	label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	label:SetForeColor( Equendil.UI.Color.TurbineLightYellow );
	label:SetFontStyle( Turbine.UI.FontStyle.Outline );
	label:SetMouseVisible( false );
	label:SetText( name );
	
	return label;
end

CommonControl.LabelListHeading = function( name )
	local label = Turbine.UI.Label();
	label:SetFont( Turbine.UI.Lotro.Font.TrajanPro14 );
	label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	label:SetForeColor( Equendil.UI.Color.TurbineYellow );
	label:SetFontStyle( Turbine.UI.FontStyle.Outline );
	label:SetMouseVisible( false );
	label:SetText( name );	
	
	return label;
end