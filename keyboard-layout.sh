#To use preferred keyboard layout, alter /usr/share/X11/xkb/symbols/gb to change the colemak section from:
#
#xkb_symbols "colemak" {
#    include "us(colemak)"
#
#    name[Group1]="English (UK, Colemak)";
#
#    key <AE02>	{ [         2,   quotedbl,  twosuperior,    oneeighth ]	};
#    key <AE03>	{ [         3,   sterling, threesuperior,    sterling ]	};
#    key <AE04>	{ [         4,     dollar,     EuroSign,   onequarter ]	};
#
#    key <AC11>	{ [apostrophe,         at, dead_circumflex, dead_caron]	};
#    key <TLDE>	{ [     grave,    notsign,          bar,          bar ]	};
#
#    key <BKSL>	{ [numbersign, asciitilde,   dead_grave,   dead_breve ]	};
#    key <LSGT>	{ [ backslash,        bar,          bar,    brokenbar ]	};
#
#    include "level3(ralt_switch_multikey)"
#};
#
#to:
#
#xkb_symbols "colemak" {
#    include "latin"
#
#    name[Group1]="English (UK, Colemak)";
#
#    key <AE02>	{ [         2,   quotedbl,  twosuperior,    oneeighth ]	};
#    key <AE03>	{ [         3,   sterling, threesuperior,    sterling ]	};
#    key <AE04>	{ [         4,     dollar,     EuroSign,   onequarter ]	};
#
#    key <AC11>	{ [apostrophe,         at, dead_circumflex, dead_caron]	};
#    key <TLDE>	{ [     grave,    notsign,          bar,          bar ]	};
#
#    key <BKSL>	{ [numbersign, asciitilde,   dead_grave,   dead_breve ]	};
#    key <LSGT>	{ [ backslash,        bar,          bar,    brokenbar ]	};
#    key <AB08>  { [     comma,	period		]	};
#    key <AB09>  { [     less,	greater		]	};
#    
#    include "level3(ralt_switch_multikey)"
#};
#
#run:
#
#sudo dpkg-reconfigure xkb-data
#
#and add English (UK, Colemak) to settings > text entry.
#
#
#Might be able to achieve necessary changes with:
#
#sed -i '/English (UK, Colemak)/a \ \n\ \ \ \ key <AE08> { [ comma, period ] };\n\ \ \ \ key <AE09> { [ less, greater ] };' gb
#sed -i 's/us(colemak)/latin/' gb
#
#Scripted version of above:

sudo cp /usr/share/X11/xkb/symbols/gb /usr/share/X11/xkb/symbols/gb-backup
sudo sed -i '/English (UK, Colemak)/a \ \n\ \ \ \ key <AE08> { [ comma, period ] };\n\ \ \ \ key <AE09> { [ less, greater ] };' /usr/share/X11/xkb/symbols/gb
sudo sed -i 's/us(colemak)/latin/' /usr/share/X11/xkb/symbols/gb
sudo dpkg-reconfigure xkb-data
