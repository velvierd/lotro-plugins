local _locale = "en"; --Turbine.Engine.GetLocale();

l = {};

if ( "de" == _locale ) then
	l.help		= "BuffMonitor\n       <rgb=#FFFFFF>/bm options</rgb>: Zeigt den Einstellungsdialog";
	l.shorthelp	= "Zeigt oder versteckt den BuffMonitor.";
	--[[
			�	\195\164
			�	\195\132
			�	\195\182
			�	\195\150
			�	\195\188
			�	\195\156
			�	\195\159
	--]]

else -- set english locale as default
	l.help		= "BuffMonitor\n       <rgb=#FFFFFF>/bm options</rgb>: Shows the setup window";
	l.shorthelp	= "usage: /bm options";

end

L = function(key) return l[key] end;