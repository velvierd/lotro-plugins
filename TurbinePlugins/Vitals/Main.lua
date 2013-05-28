
import "Turbine.UI";
import "Turbine.UI.Lotro";

import "TurbinePlugins.Vitals";

vitalsWindow = VitalsWindow();
vitalsWindow:SetVisible( true );

-- Disable the ingame vitals.
Turbine.UI.Lotro.LotroUI.SetEnabled( Turbine.UI.Lotro.LotroUIElement.Vitals, false );
