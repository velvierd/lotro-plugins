import "Turbine.UI";

import "Equendil.Utils.Event";

TextBox = class( Turbine.UI.Lotro.TextBox );
function TextBox:Constructor()
	Turbine.UI.Lotro.TextBox.Constructor( self );
	
	self.TextChanged = Equendil.Utils.Event();

	self.text = nil;
	
	self.FocusGained = function( sender, args )
		self:SetWantsUpdates( true );
	end
	
	self.Update = function( sender, args )
		if self.text ~= self:GetText() then
			self.text = self:GetText();
			self.TextChanged();
		end
	end
	
	self.FocusLost = function( sender, args )
		self:SetWantsUpdates( false );
	end
end

function TextBox:SetText( text )
	Turbine.UI.Lotro.TextBox.SetText( self, text ); --forward call to parent class
	
	self.text = text;
end