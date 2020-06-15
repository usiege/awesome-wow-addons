DevTools
---------------------------------------------------------------------------
Authors and Contributors:
	Iriel <iriel@vigilance-committee.org>
	Kirov
	Esamynn
---------------------------------------------------------------------------
Development/research tools for WoW API development

A simple AddOn which provides some slash commands

/reload

Just a shortcut (since I'm lazy) for /script ReloadUI()

/dump expression

Prints the result of executing a LUA expression (Basically /script but with
output). It should be able to handle pretty much any kind of return data
(including self-referential nested tables!)

e.g.
	/dump GetPlayerMapPosition("player")

	DevTools: value=GetPlayerMapPosition("player")
	[1]0.43320921063423
	[2]0.69365233182907

/dtchatevent

Toggle chat event tracking/debugging (this is a saved setting). When
active each chat frame message (in all standard ChatFrames) will be
prefixed by a marker that can be clicked on the pop up the details of
the event that created it.

/dtchatevent buffer 

Displays the current chat event rolling buffer size.

/dtchatevent buffer <size>

Set the current chat event rolling buffer size
(e.g. /dtchatevent buffer 10000), the default buffer size is 1000.

/dtframestack

Toggles the 'frame stack' window, which displays the stack of visible
frames under the mouse pointer. (There are also key bindings for this).

/dteventtrace [command]
/dtevents [command]

Without any command it toggles visibility of the event trace frame. The
following commands are also recognized:

   stop       -- Halts collection of events
   start      -- Starts normal collection of events
   fill       -- Starts collection of 50 events (then stops)
   toggle     -- Equivalent to no parameters

---------------------------------------------------------------------------
Configuration

You can set the following global values to change the behaviour of /dump:

DEVTOOLS_MAX_ENTRY_CUTOFF = 30;    -- Maximum table entries shown
DEVTOOLS_LONG_STRING_CUTOFF = 200; -- Maximum string size shown
DEVTOOLS_DEPTH_CUTOFF = 10;        -- Maximum table depth
DEVTOOLS_USE_TABLE_CACHE = true;   -- Look up table names
DEVTOOLS_USE_FUNCTION_CACHE = true;-- Look up function names
DEVTOOLS_USE_USERDATA_CACHE = true;-- Look up userdata names
DEVTOOLS_INDENT='  ';              -- Indentation string

---------------------------------------------------------------------------
History

1.11 - 2008-08-08
* More WoLK beta fixes (FauxScrollFrame related)

1.10 - 2008-08-08
* Various WoLK beta fixes

1.9 - 2008-07-19
* Updated for 3.0 slash command handling

1.8 - 2008-04-19
* Removed dependency on Blizzard_CombatLog since symbols are in base UI now
* Added /dteventtrace [no]auto to toggle automatic startup on addon reload
  IMPORTANT: THE DEFAULT IS TO **NOT** AUTOMATICALLY START
* Audited global variables and cleaned up some code

1.7 - 2008-02-18
* Updated to describe COMBAT_LOG_EVENT fields in much more detail
* Added optional dependency on blizzard combat log to load constants
* Automatically scans global environment for COMBATLOG_OBJECT_ constants

1.6 - 2008-02-17
* Updated event trace in order to store larger number of args due to
  2.4 combat logs.
* Improved memory usage of event detail popup

1.5 - 2006-12-24
* Removed some extra debug messages
* Added scrollbar to event frame
* Added keybindings to event frame WHEN SELECTED
    UP/DOWN -- Previous/Next displayed event
    SHIFT-UP/DOWN -- Previous/Next event
    CTRL-UP/DOWN -- Previous/Next event with same name
    PAGEUP/PAGEDOWN -- Fast scrolling up and down of display list.

1.4 - 2006-12-21
* Fixed /dtevents so it works

1.3 - 2006-12-19
* Re-implemented lots of EventTrace options frame innards
* Added EventTrace key bindings for start/stop/toggle/fill/show
* Some cleanup of EventTrace code

1.2 - 2006-12-17
* Added slash command for event trace frame
* Cleaned up some event trace code in preparation for full functionality
* Updated framestack to show visually which frames are mouse enabled
* Miscellaneous efficiency improvements

1.1pre1 - 2006-10-07
* First stage integration of event list display and filtering is now
  complete.
* Significant enhancements for lua 5.1

1.0pre2 - 2006-04-09
* Added /dtchatevent buffer
* Added tooltip error when clicking on out-of-buffer event link
* Added line wrapping for long event arguments and escaping of newlines
* Added easy indication for runs of spaces (and spaces at beginning or end
  of strings).
* Added /dtframestack (plus key bindings)

1.0pre1 - 2006-04-03
* Added /dtchatevent
* Rearranged code a little

0.7 - 2006-03-27
* Switched from RunScript to loadstring

0.6 - 2005-08-30
* Fixed tableEntriesSkipped issue.

0.5 - 2005-07-23
* Added function cache (gives names of functions if known)
* Added userdata cache (gives names of userdata if known)
* Cleaned up trailing comma formatting so it's more consistent
* Added customizable indentation (DEVTOOLS_INDENT)
* Restructured scanner to be a little more object oriented (for future
  development)
* Switched many formatting tasks to use string.format
* Handle function/userdata/table table keys better.
* Made DevTools_Dump(value) friendly enough to use from code for debugging.

0.4 - 2005-03-20
* Added cutoff for deep tables
* Added table cache for self-referential tables
* Cleaned up display of name table keys
* Added nicer handling for simple variable dumps
* Added color coding of output

0.3 - 2005-02-05
* Re-worked output method for large objects.
* Removed message on load to reduce spam
* Added limits on max table entries and max string length output

0.2 - 2004-12-27
* Added some documentation

0.1
* Initial version, /dump and /reload

