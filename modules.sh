# Don't run this.
# This is just used for seperating some variables that would otherwise clutter up the main script

# Generic stuff
GenericElse=\
"		else if (sb.CPlayer.mo == sb.CPlayer.Camera && sb.hpl.Health > 0)
		{
			sb.BeginHUD(forceScaled: false);
"
GenericEnd=\
"	}
}
"

# Files
InitFile="zscript/HCStatusbar_Init.zs"
DrawFile="zscript/HCStatusbar_SuperDraw.zs"
HeartbeatFile="zscript/modules/HUDHeartbeat.zs"
EKGFile="zscript/modules/HUDEKG.zs"

# Regex
InitVariables="
^		int mxht
"

StartOfDraw='^	override void Draw'
StartOfDrawIgnore='^		if\(automapactive\)'
EndOfDrawIgnore='^		}$'
EndOfDraw='^	\}'
StartOfHeartbeat='^		\/\/heartbeat'
EndOfHeartbeat='^		\}'
StartOfEKG='^		\/\/health'
EndOfEKG='^		\);else'

# Headers
DrawHUDStuff="override void DrawHUDStuff(HCStatusbar sb)"
AutomapActive=\
"
		if(AutomapActive)
		{
			sb.BeginHUD();
"

InitHeader=\
"extend class HCStatusbar
{
	override void Init()
	{
		Super.Init();

		Console.PrintF(\"Initialising HCStatusbar.\");

		// Get all classes that inherit from HUDElement
		_HUDElements.Clear();
		for (int i = 0; i < AllClasses.Size(); i++)
		{
			if (AllClasses[i] is \"HUDElement\" && AllClasses[i].GetClassName() != \"HUDElement\")
				_HUDElements.Push(HUDElement(new(AllClasses[i])));
		}

"

DrawHeader=\
"extend class HCStatusbar
{
	private void SuperDraw(int state, double ticFrac)
	{
"

HeartbeatHeader=\
"class HUDHeartbeatMonitor : HUDElement
{
	${DrawHUDStuff}
	{${AutomapActive}
"

EKGHeader=\
"class HUDEKGMonitor : HUDElement
{
	${DrawHUDStuff}
	{${AutomapActive}
"
