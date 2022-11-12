# Don't run this.
# This is just used for seperating some variables that would otherwise clutter up the main script

# Generic stuff
GenericEnd=\
"	}
}
"

# Common stuff
CommonCondition="(
			!AutomapActive
			&& sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& State <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		)"
CommonIf=\
"		if ${CommonCondition}
		{
"
CommonElse=\
"		else if ${CommonCondition}
		{
"

# Files
InitFile="zscript/HCStatusbar_InitVariables.zs"
DrawFile="zscript/HCStatusbar_SuperDraw.zs"
FragsFile="zscript/modules/HUDFrags.zs"
KeysFile="zscript/modules/HUDKeys.zs"
InventoryFile="zscript/modules/HUDInventory.zs"
HeartbeatFile="zscript/modules/HUDHeartbeat.zs"
EKGFile="zscript/modules/HUDEKG.zs"
MugshotFile="zscript/modules/HUDMugshot.zs"
ItemAdditionsFile="zscript/modules/HUDItemAdditions.zs"
WeaponStatusFile="zscript/modules/HUDWeaponStatus.zs"
WeaponSpriteFile="zscript/modules/HUDWeaponSprite.zs"
WeaponStashFile="zscript/modules/HUDWeaponStash.zs"
AmmoCountersFile="zscript/modules/HUDAmmoCounters.zs"
EncumbranceFile="zscript/modules/HUDEncumbrance.zs"

# Regex
InitVariables="
^		int mxht
^		int mhht
"

StartOfDraw='^		\/\/blacking out'
EndOfDraw='^	\}'

StartOfFrags='^		\/\/frags'
EndOfFrags='^		\);'

StartOfInventory='^		\/\/inventory'
EndOfInventory='^		DrawInvSel'

StartOfKeys='^		\/\/[kK][eE][yY][sS]'
EndOfKeys='^		if\(hpl.countinv\(\"RedSkull\"\)\)'

StartOfHeartbeat='^		\/\/heartbeat'
EndOfHeartbeat='^		\}'

StartOfEKG='^		\/\/health'
EndOfEKG='^		\);else'

StartOfMugshot1='^		\/\/mugshot'
EndOfMugshot1='^		DrawTexture'
StartOfMugshot2='^		if\(usemughud\)'
EndOfMugshot2='^		\);'

StartOfItemAdditions='^		\/\/items'
EndOfItemAdditions1='^		DrawItemHUDAdditions'
EndOfItemAdditions2='^		\);'

StartOfWeaponStatus='^		\/\/weapon readouts'
EndOfWeaponStatus='drawweaponstatus'

StartOfWeaponSprite1='^		\/\/gun'
StartOfWeaponSprite2='^		\/\/weapon sprite'
EndOfWeaponSprite='^		drawselectedweapon'

# because these are only one line
RegexOfWeaponStash='		drawweaponstash'
RegexOfAmmoCounters='		drawammocounters'

StartOfEncumbrance='^			\/\/encumbrance'
EndOfEncumbrance='^			int wephelpheight'

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
	{${AutomapActive}
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
	{${CheckSpectator}${AutomapActive}
"

KeysHeader=\
"class HUDKeys : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"keys\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${AutomapActive}
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
	{${CheckSpectator}${AutomapActive}
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
	{${CheckSpectator}${AutomapActive}
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
	{${CheckSpectator}${AutomapActive}
"

ItemAdditionsHeader=\
"class HUDItemAdditions : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"itemadditions\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${AutomapActive}
"

WeaponStatusHeader=\
"class HUDWeaponStatus : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"weaponstatus\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}
${CommonIf}
"

WeaponSpriteHeader=\
"class HUDWeaponSprite : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"weaponsprite\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${AutomapActive}
"

WeaponStashHeader=\
"class HUDWeaponStash : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"weaponstash\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${AutomapActive}
"
WeaponStashElse=\
"		else if ${CommonCondition}
		{
			if (sb.HUDLevel != 2)
				return;
"

AmmoCountersHeader=\
"class HUDAmmoCounters : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"ammocounters\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${AutomapActive}
"

EncumbranceHeader=\
"class HUDEncumbrance : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"encumbrance\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${CommonIf}
			if (sb.HUDLevel != 2)
				return;
"
