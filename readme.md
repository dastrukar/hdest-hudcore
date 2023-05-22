> so its like the core of the hud modification   -my friend

## What?
Basically a replacement of HDest's HUD, designed to be more modular for easier customisability.

On it's own, HUD Core is basically just the default HUD.   
(though if you spot any oddities with the normal HUD stuff, please report it)

NOTE: Please don't copy the code of the modules, as they are poorly compiled through brute force scripting.

## Usage
Just load it up with HDest, and it should run.   
Again, you have to use addons that use HUD Core for anything to change.

## Compiling
You should only do this if HUD Core doesn't work with the latest version or a specific version.

Anyhow, if you wish to compile HUD Core, just run `compile.sh` and pray it works. (make sure that you set the specific branch/commit for the `hideousdestructor` submodule)   
For Windows users, you might want to grab Git Bash for this. (or anything that comes with Git and Bash)

### Notice for Mac/BSD users
I wrote the compile script on Linux, which means that I used GNU `sed`.   
Unfortunately, BSD `sed` doesn't have the substitution flag `i`, and therefore the script will fail.   
The fix is simple: Use GNU `sed` :]   
(no i'm not going to fix it, it's just going to make the script look even more worse than it already does)

## Technical info

### `HUDElement`
The generic class used by all HUD elements.

Variables:   
- `string Namespaces`   
Each element has its own namespace. If there are elements with the same namespace, they'll overwrite each other. The namespace that takes precedence is the one that gets initialised last. (depends on your load order)

- `int ZLayer`   
Self-explanatory. If a element's Z Layer is higher than other elements, it'll be drawn on top of them.

Virtual functions:   
- `virtual void Init(HCStatusbar sb)`
- `virtual void Tick(HCStatusbar sb)`
- `virtual void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)`

Utility functions:   
- `protected bool CheckAlwaysStuff(HCStatusbar sb, int state, double ticFrac)`   
Returns true if the statusbar would be running `DrawAlwaysStuff()`.

- `protected bool CheckCommonStuff(HCStatusbar sb, int state, double ticFrac)`   
Returns true if the statusbar would be running `DrawCommonStuff()`.

- If you want to check for automap, just use the AutomapActive variable.

### `HUDItemOverrides`
Used by elements that call an item's draw function. You most likely don't have to override this as all drawing is done by items. Instead, take a look at `HCItemOverride`.   
Though, if you do end up overriding it, make sure to set the `_OverrideType` variable before calling `Super.Init()`. (see `HCItemOverride` for valid values)   
Inherits from `HUDElement`.

### `HCItemOverride`
Generic class used in `HUDItemOverrides` for overriding an item's draw function.   

Variables:   
- `int OverrideType`   
Determines the type of item that should be overridden.   
The following are valid values:
```
HCOVERRIDETYPE_ITEM (for items, or anything that inherits from HDPickup)
HCOVERRIDETYPE_WEAPON (for weapons)
HCOVERRIDETYPE_OVERLAY (overrides an item's DisplayOverlay() function)
```

- `int Priority`   
Self-explanatory. If an override's priority is higher than other overrides, it'll be used first.

Functions:   
- `abstract bool CheckItem(Inventory item)`   
Used to check if the override should override the given item's draw function.   
The following functions will only run if `CheckItem()` returns true.

- `virtual void Tick(HCStatusbar sb)`
- `virtual void DrawHUDStuff(HCStatusbar sb, Inventory item, int hdFlags, int gzFlags)`

