# Don't run this.
# This is just used for seperating some variables that would otherwise clutter up the main script

# Generic stuff
GenericEnd=\
"	}
}
"

# Common stuff
CommonCondition="(
			sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& State <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		)"
CommonIf=\
"		if ${CommonCondition}
		{
			sb.BeginHUD(forceScaled: false);
"
CommonElse=\
"		else if ${CommonCondition}
		{
			sb.BeginHUD(forceScaled: false);
"

# Files
InitFile="zscript/HCStatusbar_InitVariables.zs"
DrawFile="zscript/HCStatusbar_SuperDraw.zs"
FragsFile="zscript/modules/HUDFrags.zs"
InventoryFile="zscript/modules/HUDInventory.zs"
HeartbeatFile="zscript/modules/HUDHeartbeat.zs"
EKGFile="zscript/modules/HUDEKG.zs"
MugshotFile="zscript/modules/HUDMugshot.zs"

# Regex
InitVariables="
^		int mxht
^		int mhht
"

StartOfDraw='^		\/\/blacking out'
StartOfDrawIgnore='^		if\(automapactive\)'
EndOfDrawIgnore='^		}$'
EndOfDraw='^	\}'
StartOfFrags='^		\/\/frags'
EndOfFrags='^		\);'
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
DrawHUDStuff="override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)"
CheckSpectator=\
"
		if (HDSpectator(sb.hpl))
			return;
"
AutomapActive=\
"
		if (AutomapActive)
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

FragsHeader=\
"class HUDFrags : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"frags\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}
		${AutomapActive}
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
	{${CheckSpectator}
		${AutomapActive}
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
	{${CheckSpectator}
		${AutomapActive}
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
	{${CheckSpectator}
		${AutomapActive}
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
	{${CheckSpectator}
		${AutomapActive}
"
