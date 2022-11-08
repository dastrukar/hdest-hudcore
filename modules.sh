# Don't run this.
# This is just used for seperating some variables that would otherwise clutter up the main script

# Generic stuff
Condition="(sb.CPlayer.mo == sb.CPlayer.Camera && sb.hpl.Health > 0)"
GenericIf=\
"		if ${Condition}
		{
			sb.BeginHUD(forceScaled: false);
"
GenericElse=\
"		else if ${Condition}
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
InventoryFile="zscript/modules/HUDInventory.zs"
HeartbeatFile="zscript/modules/HUDHeartbeat.zs"
EKGFile="zscript/modules/HUDEKG.zs"
MugshotFile="zscript/modules/HUDMugshot.zs"

# Regex
InitVariables="
^		int mxht
"

StartOfDraw='^		\/\/blacking out'
StartOfDrawIgnore='^		if\(automapactive\)'
EndOfDrawIgnore='^		}$'
EndOfDraw='^	\}'
StartOfInventory='^		\/\/inventory'
EndOfInventory='^		DrawInvSel'
StartOfHeartbeat='^		\/\/heartbeat'
EndOfHeartbeat='^		\}'
StartOfEKG='^		\/\/health'
EndOfEKG='^		\);else'
StartOfMugshot1='^		\/\/mugshot'
StartOfMugshot2='^		if\(usemughud\)'
EndOfMugshot1='^		DrawTexture'
EndOfMugshot2='^		\);'

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
	private void InitVariables()
	{
"

DrawHeader=\
"extend class HCStatusbar
{
	private void SuperDraw(int state, double ticFrac)
	{
"

InventoryHeader=\
"class HUDInventory : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"inventory\";
	}

	${DrawHUDStuff}
	{${AutomapActive}
"

HeartbeatHeader=\
"class HUDHeartbeat : HUDElement
{
	${Init}
	{
		ZLayer = 0;
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
		ZLayer = 0;
		Namespace = \"ekg\";
	}

	${DrawHUDStuff}
	{${AutomapActive}
"

MugshotHeader=\
"class HUDMugshot : HUDElement
{
	${Init}
	{
		ZLayer = 1;
		Namespace = \"mugshot\";
	}

	${DrawHUDStuff}
	{${AutomapActive}
"
