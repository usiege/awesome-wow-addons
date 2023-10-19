TinyPad is a notepad addon.

To summon: /tinypad or /pad or set a key binding.
To resize: drag the resize grip in the lower right corner of the window.

The mod should be self explanatory how to use. Mouseover buttons to see what they do.

=== Notes on link support

* Links supported: Items, Spells, Tradeskills, Recipes, Achievements, and Battle Pets you own
* To add links to pages: Bring up a TinyPad page and put the blinking cursor where you want to insert a link, then shift+click an item, spell, recipe, quest or achievement as you ordinarily would to chat.  To link an entire tradeskill, click the chat bubble in the upper right of the tradeskill window, as you would for chat or macros.
* To view links: Click them.
* To send links: Shift+click to chat as you would normally.
* Links can't be copy-pasted naturally and remain clickable.  But the addon Linkerize will allow cut/pasting links with control codes.
* Links may display only a handful of characters, but they have many hidden control characters. The EditBox is not intended to handle massive amounts of text, so keep that in mind if trying to cram the entire contents of AtlasLoot into one page.

=== Other Notes

* Searches are case insensitive.
* You can bind a key to search.
* While locked, the window won't go away with ESC, but you can still toggle it with /pad or a key binding.
* You can also run pages with /run TinyPad:Run(page)
* You can add a page with TinyPad:Insert("text here adds a new page")
* You can delete multiple pages with TinyPad.DeletePagesContaining("regex") NOTE: be careful with this one.
* Clicking on an item link while a tradeskill window is open will jump to that item if your tradeskill can create it.

v2.1.8, 7/17/18, toc update for 8.0 patch
v2.1.7, 10/29/17, size option now toggles a traditional scale, bookmarks excluded from size change, pages save as text changes and undo to initial state when shown
v2.1.6, 10/1/17, added Size button to the options panel to toggle the size of TinyPad (for now it's a fix for the cursor not being at the insertion point in 7.3 patch)
v2.1.5, 8/29/17, fix for PlaySound change in 7.3, toc update for 7.3 patch
v2.1.4, 3/28/17, toc update for 7.2 patch
v2.1.3, 10/24/16, toc update for 7.1 patch
v2.1.2, 9/11/16, fix for lua error when attempting to link a profession to chat
v2.1.1, 7/17/16, fix for clicking a tradeskill link while tradeskill window is open
v2.1.0, 5/28/16, toc update for 7.0 patch, support/fixes for Legion, linking a stack will no longer summon the stack split frame
v2.0.5, 6/22/15, toc update for 6.2 patch
v2.0.4, 2/24/15, toc update for 6.1 patch
v2.0.3, 11/8/14, quest links causing serious taint issues, temporarily removing ability to link quests
v2.0.2 10/14/14, 6.0 patch, AddOns binding category
v2.0.1, 9/12/14, completely rewritten, improved scrollbar vs cursor handling, improved link handling, shift+enter to search backwards, WoD compatable
v1.95, 9/11/13, toc update for 5.4 patch
v1.94, 8/26/13, fix for battlepet links (use reflink instead of link), and secure hook for quest links
v1.93, 5/21/13, toc update for 5.3 patch
v1.92, 11/13/12, removed UpdateScrollChildRect, max scroll enforced when focused and cursor position -5 to end
v1.91, 8/27/12, 5.0 (Mists of Pandaria) toc update
v1.90, 2/4/12, cleaned up XML, shift+clicking page turns move a page, changed search method from string:lower comparisons to a [Cc][Aa][Ss][Ee]insensitive search, added bookmark system
v1.8, 1/14/12, fixes for quest/tradeskill linking, added achievement linking
v1.71, 9/28/10, removed 'arg1' from moving, added TinyPad.Insert and TinyPad.DeletePagesContaining
v1.7, 9/1/10, changed 'this' references to 'self' in xml, updated toc
v1.62, 7/8/10, actual fix for linking to chat, SetItemRef extra params
v1.61, 6/24/10, fix for linking to chat
v1.6, 12/3/08, added support for inserting/displaying links
v1.53, 8/8/08, changed toc, this to self, passed arg1s, changed getn's to #'s
v1.52, 11/1/06, UISpecialFrames added back
v1.51, 10/23/06, UISpecialFrames removed
v1.5, 10/4/06, updated for Lua 5.1
v1.4, 8/22/06, bug fix: run script saves page to run, changed: moved buttons to search panel, reduced minimum width
v1.3, 8/5/06, added undo, widened page number
v1.2, 6/23/06, added search, lock, fonts, /pad <page>, /pade run <page>
v1.1, 12/18/05, remove autofocus, added confirmation on delete
v1.0, 12/16/05, initial release
