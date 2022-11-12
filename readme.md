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

Anyhow, if you wish to compile HUD Core, just run `compile.sh` and pray it works.   
For Windows users, you might want to grab Git Bash for this. (or anything that comes with Git and Bash)

## How it works
HUD Core looks for any `HUDElement` class and cache them for use.

### Namespaces
Each `HUDElement` has its own namespace.   
If there are elements with the same namespace, they'll overwrite each other; the one that appears further down the `AllClasses` array takes precedence.

### Z Layer
If an element has a higher Z Layer than other elements, it'll be drawn on top of them.
