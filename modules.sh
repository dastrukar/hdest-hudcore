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
InitFile="zscript/HCStatusbar_InitVariables.zs"
DrawFile="zscript/HCStatusbar_SuperDraw.zs"
HeartbeatFile="zscript/modules/HUDHeartbeat.zs"
EKGFile="zscript/modules/HUDEKG.zs"

# Regex
InitVariables="
^		int mxht
"

StartOfDraw='^		\/\/blacking out'
StartOfDrawIgnore='^		if\(automapactive\)'
EndOfDrawIgnore='^		}$'
EndOfDraw='^	\}'
StartOfHeartbeat='^		\/\/heartbeat'
EndOfHeartbeat='^		\}'
StartOfEKG='^		\/\/health'
EndOfEKG='^		\);else'

# Headers
Init="override void Init(HCStatusbar sb)"
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
	override void InitVariables()
	{
"

DrawHeader=\
"extend class HCStatusbar
{
	private void SuperDraw(int state, double ticFrac)
	{
"

HeartbeatHeader=\
"class HUDHeartbeat : HUDElement
{
	${Init}
	{
		Namespace = \"heartbeat\";
	}

	${DrawHUDStuff}
	{${AutomapActive}
"

EKGHeader=\
"class HUDEKG : HUDElement
{
	${Init}
	{
		Namespace = \"ekg\";
	}

	${DrawHUDStuff}
	{${AutomapActive}
"
