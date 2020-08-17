***********************************
SCT - Damage 3.1
***********************************

Website - http://grayhoof.wowinterface.com/

What is it? - A mod that adds your damage to SCT. It provides a way for you to see your damage in a static location. This can be useful against large mobs like those in MC, Bosses, etc...Can use SCT animations or its on built in style.

What can it do?

- Your Melee, Spell, Skill, Periodic, and Pet Damage
- Spell Damage/Resists and Damage Type (by color)
- Can show damage at enemy nameplates
- Target and Spell ID's
- All "Miss" events (dodge, block, immune, etc...)
- Custom Colors for all text events and crits.
- Ability to show only target damage
- Five Fonts with option to pick up more using ShareMedia
- Can disable built in WoW damage
- Sliders for text size, fade speed, and on screen placement (with custom editbox)
- Localized to work in almost all WoW clients.

How do I use it? - First you must have SCT installed already. Next, unzip  SCTD it into your interface\addons directory. For more info on installing, please read install.txt. Now just run WoW and once logged in, type /sctdmenu to get the options screen or you can click the SCTD button on the SCT options menu.

FAQ
How do I remove the damage the scrolls above my targets head? - WoW itself does this. You can turn it off by checking the the "Disable WoW Damage" option, or by going to the Advanced Options under Interface options.

My Wow Damage won't turn back on, even after I turn off SCTD! - You need to turn this back on manually in WoW. Go to Advanced Options under Interface options and you will see a checkbox to enable damage. Also, it is highly recommended you don't use the "Enable Wow Damage in PvP" option if you are on a PvP server.

My peridoic damage is not showing up in the combat log or on the screen! How do I fix it? - You have turned off periodic damage on the Advanced Options under Interface options. Make sure the "Periodic Damage" check box is checked, even if you have Damage unchecked.

SCTD damage is ontop of my SCT messages, how do I fix this? - I highly suggest you move SCT's message using the sliders on the SCT option menu. You can also move SCTD using the sliders on its menu. Consider placing it over you target bar.

How do I reset SCTD or load another users settings? - SCTD is tied directly to SCT. You can reset SCTD using SCT's reset button or typing /sctreset. You can load another users SCTD settings by loading them from the SCT option menu.

I don't like enemy nameplates on. How do I make my damage appear over who I hit? - Enemy nameplates have to be on in order to show your hit over the enemy heads. SCT will turn them on if you turn on the option, but you must manually turn them off if you don't like it (see Target keybindings).

Support
Please post all errors and suggestions on http://grayhoof.wowinterface.com/ using the provided forms.

Version History
3.1 - Converted to a faster combat log system. Fix for nameplates in PvP. Convert to LibShareMedia-3.0.
3.01 - Fix miss issue using global strings. Added CN translation. Allowed fonts to go down to size 8.
3.0 - Converted to WoW 2.4 Combat Log. Converted to Ace3. Moved options menu to WoW 2.4 Addons Menu. Options menu reorganized to be much cleaner and simpler.
2.4 - Uses spell icons from SCT if enabled. Added Damage Shields as an optional event. Added Outgoing Damage Filter (separate from SCT's). Made all font sizes change 1 step at a time.
2.33 - Fixed minor bugs with Share Media. Added option to turn off custom events for SCTD only.
2.32 - Added SharedMedia for fonts. Added ability to use SCT Custom Events to filter/change SCTD events. See sct_event_config.lua for examples.
2.31 - Added Spell/Skill shortening (uses SCT settings).
2.3 - Added ability to show damage over enemy nameplates; see FAQ for more info.
2.22 - Fixed Miss events showing ParserLib internal variables. Cleaned up localization.
2.21 - Added Interruption Events. Spell colors now inherit colors set by SCT's settings.
2.2 - Converted to WoW 2.0 standards. Added options for all the new options from SCT (Alignment, HUD animations, etc...). Cleaned up UI a little to make everything fit.
2.1 - Cleaned up options page by using tabs buttons. Added totem and summoned pet damage and cleaned up pet code. Added crushing and glancing blows.
2.02 - Total new look for options window. Converted all table iterators to use pairs().
2.01 - Removed the PvP toggable ability. Caused too many problems.
2.0 - Complete rewrite using Ace2 and ParserLib with more performance in mind. Now uses its own custom animation frame within SCT for display, allowing much better customization bewtween SCT and SCTD. Sticky Crit options. Spell colors option.
1.1 - Made options frame its own LoadOnDemand mod, options frame is now moveable, added Color Crits options, added ability to show only damage to your target, added ability to turn SCTD off and turn WoW damage on when in PvP and vice versa, added ability to use SCT animation for all damage, added better crit animations, various bug fixes and teaks.
1.0 - Initial Release

