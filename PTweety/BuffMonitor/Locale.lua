local _locale = "en"; --Turbine.Engine.GetLocale();

l = {};

if ( "de" == _locale ) then
	l.help		= "BuffMonitor\n       <rgb=#FFFFFF>/bm options</rgb>: Zeigt den Einstellungsdialog";
	l.shorthelp	= "Zeigt oder versteckt den BuffMonitor.";
	--[[
			ä	\195\164
			Ä	\195\132
			ö	\195\182
			Ö	\195\150
			ü	\195\188
			Ü	\195\156
			ß	\195\159
	--]]

else -- set english locale as default
	l.help		= "BuffMonitor\n       <rgb=#FFFFFF>/bm options</rgb>: Shows the setup window";
	l.shorthelp	= "usage: /bm options";

end

L = function(key) return l[key] end;