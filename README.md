Stepmania-Zpawn
===============

Zettbou Plays Around With Noteskins (and themes)

------------------------------------------------

Stepmania 5
-----------

### Themes 

* default_JousEdit_Clock *Finished*

```
-- Analog Clock --

Adds and extra screen selection on ScreenTitleMenu to a screen with just a black background and an analog clock.
```

* default_JousEdit_Noteskin *WIP*

```
-- Noteskin Modification System --

An in theme noteskin modification system so you can change the way the provided noteskin looks in game
Adds and extra noteskin which you can select and use in ScreenPlayerOptions.
Also adds an extra screen selection on ScreenTitleMenu called ScreenNoteskinCustomize
In ScreenNoteskinCustomize you got Screens with RGB value changers for 4th's 8th's etc.
Also got a screen for ajusting the look of the noteskin, These values are:
* Noteskin Type: DDR, ITG Metal, ITG Cel, Notebar And Orbular.
* Hold and Roll head colouring: DDR style or 4th's 8th's etc based.
* Hold and Roll Body and End: DDR style or ITG
* Slim Mode: Changes the vertical size.
```
```
WIP Notes:
Still need to write the noteskin size, theme side is done.
```

* default_JousEdit_ScreenSelectMusic *Finished*

```
Actually 2 diffrent codes, but both are for ScreenSelectMusic, So in same theme.

-- cdtitle Resizer --
Resizes the cdtitle between a value of 60x80, so we dont get the hassel of giant cdtitles
Also puts it between the p1 and p2 pane's.

-- Song Background Changer --
Changes the background to selected song.
```

* default_JousEdit_SpeedMod_System *WIP*

```
-- New Speedmods System --

Changes the way speedmods are selected on ScreenPlayerOptions.
Instead of a load of values like, 1.0x,2.0x,3.0x,4.0x,5.0x,c100,c200,c300,c400,c500,m100,m200,etc.
It uses 2 slections to defined the speedmod type Like:
Constant Mod, Multiplication Mod, Average Mod, Maximum Mod
100,200,300,400,500
So it combines the values of the first selection and second selection to get actual speedmod.

Examples:
Constant Mod + 200 = C200
Multiplication Mod + 300 = 3.0x (better known as xmod)
Average Mod + 400 = A400 (Nonexistent atm, need to write system)
Maximum Mod + 500 = M500
```
```
WIP Notes:
Need to write Average Mod System, fallbacks to C550 for now.
```

### Noteskins

* CybularZ
 * Dance

```
3d Test noteskin, Uses a colour scroller for entire colouring.
```

* easyV2
 * Dance
 * Pump

```
Easy to read noteskin, Made for hard keyboard files that have a load of clusters.
Has support for both Dance and Pump.
```

* Editor_Old
 * Dance
 * Pump

```
Stepmania 5 Editor Noteskin Original, Has support for Dance and Pump.
```

* exactBar
 * Dance
 * Pump

```
Change receptor's when using Reverse or Nonreverse, Also has backboard/lanes.
Also has dance and pump support.
```

* exactV2
 * Dance
 * Pump

```
Noteskin made for testing accuraty of a player.
Also has dance and pump support.
```

* Noteskin_Elements
 * Dance

```
A noteskin that shows the element names of the parts of the noteskin, Only has dance support atm, global support planned.
```

* Pitchular
 * Dance

```
When noteskin explosion happens plays sound, Pitch changes depending on lane, Based on orbular.
```

* Scroll_Test
 * Dance

```
Unfinished Test noteskin to see if using lua scroll instead of multible images would work.
```
