# Don't run this.
# This is just used for seperating some variables that would otherwise clutter up the main script

# Generic stuff
GenericEnd=\
"	}
}
"

# Always stuff
AlwaysCondition="(
			AutomapActive
			|| sb.CPlayer.mo != sb.CPlayer.Camera
			|| (
				sb.hpl.Health > 0
				&& (sb.hpl.bInvisible || sb.hpl.alpha <= 0)
			)
		)"
AlwaysIf="if ${AlwaysCondition}
			return;

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


##
## Files
##
# Core
InitFile="zscript/HCStatusbar_InitVariables.zs"
DrawFile="zscript/HCStatusbar_SuperDraw.zs"

# Always stuff
SetWeaponDefaultFile="zscript/modules/HUDSetWeaponDefault.zs"
CrosshairFile="zscript/modules/HUDCrosshair.zs"

# Stuff
FragsFile="zscript/modules/HUDFrags.zs"
AutomapPosFile="zscript/modules/HUDAutomapPos.zs"
KeysFile="zscript/modules/HUDKeys.zs"
InventoryFile="zscript/modules/HUDInventory.zs"
HeartbeatFile="zscript/modules/HUDHeartbeat.zs"
EKGFile="zscript/modules/HUDEKG.zs"
ItemAdditionsFile="zscript/modules/HUDItemAdditions.zs"
WeaponStatusFile="zscript/modules/HUDWeaponStatus.zs"
WeaponSpriteFile="zscript/modules/HUDWeaponSprite.zs"
WeaponStashFile="zscript/modules/HUDWeaponStash.zs"
AmmoCountersFile="zscript/modules/HUDAmmoCounters.zs"
EncumbranceFile="zscript/modules/HUDEncumbrance.zs"
CompassFile="zscript/modules/HUDCompass.zs"
WeaponHelpFile="zscript/modules/HUDWeaponHelp.zs"
PositionFile="zscript/modules/HUDPosition.zs"
SpeedometerFile="zscript/modules/HUDSpeedometer.zs"
MugshotFile="zscript/modules/HUDMugshot.zs"
ObjectDescriptionFile="zscript/modules/HUDObjectDescription.zs"


##
## Regex
##
# Core
InitVariables="
^		int mxht
^		int mhht
"

StartOfDraw='^		\/\/blacking out'
EndOfDraw='^	\}'

# Always stuff
StartOfSetWeaponDefault='^		\/\/reads hd_setweapondefault'
EndOfSetWeaponDefault='^		if\(lomt\)'

StartOfCrosshair='^		\/\/draw the crosshair'
EndOfCrosshair='^		\)Draw'

# Stuff
StartOfFrags='^		\/\/frags'
EndOfFrags='^		\);'

RegexOfAutomapPos='^		drawmypos'

StartOfInventory='^		\/\/inventory'
EndOfInventory='^		DrawInvSel'

StartOfKeys='^		\/\/[kK][eE][yY][sS]'
EndOfKeys='^		if\(hpl.countinv\(\"RedSkull\"\)\)'

StartOfHeartbeat='^		\/\/heartbeat'
EndOfHeartbeat='^		\}'

StartOfEKG='^		\/\/health'
EndOfEKG='^		\);else'

StartOfItemAdditions='^		\/\/items'
EndOfItemAdditions1='^		DrawItemHUDAdditions'
EndOfItemAdditions2='^		\);'

StartOfWeaponStatus='^		\/\/weapon readouts'
EndOfWeaponStatus='drawweaponstatus'

StartOfWeaponSprite1='^		\/\/gun'
StartOfWeaponSprite2='^		\/\/weapon sprite'
EndOfWeaponSprite='^		drawselectedweapon'

RegexOfWeaponStash='		drawweaponstash'
RegexOfAmmoCounters='		drawammocounters'

StartOfEncumbrance='^			\/\/encumbrance'
EndOfEncumbrance='^			int wephelpheight'

StartOfCompass1='^			int wephelpheight'
StartOfCompass2='^			wephelpheight'
EndOfCompass1='^			string s='
EndOfCompass2='^			\);'

StartOfWeaponHelp='^			string s='
EndOfWeaponHelp='^			\);'

StartOfPosition='^			string postxt'
EndOfPosition='^			\);'

StartOfSpeedometer='^		if\(hd_debug>=3\)'
EndOfSpeedometer='^		\}'

StartOfMugshot1='^		\/\/mugshot'
EndOfMugshot1='^		DrawTexture'
StartOfMugshot2='^		if\(usemughud\)'
EndOfMugshot2='^		\);'

StartOfObjectDescription='^		\/\/object desc'
EndOfObjectDescription='^		\);'


##
## Headers
##
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

SetWeaponDefaultHeader=\
"// Why is this part of the statusbar?
// Oh well.
class HUDSetWeaponDefault : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"setweapondefault\";
	}

	${DrawHUDStuff}
	{
		${AlwaysIf}
"

CrosshairHeader=\
"class HUDCrosshair : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"crosshair\";
	}

	${DrawHUDStuff}
	{
		${AlwaysIf}
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

AutomapPosHeader=\
"class HUDAutomapPos : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"automappos\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${AutomapActive}
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

CompassHeader=\
"class HUDCompass : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"compass\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${CommonIf}
			if (sb.HUDLevel != 2)
				return;
"

WeaponHelpHeader=\
"class HUDWeaponHelp : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"weaponhelp\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${CommonIf}
			if (sb.HUDLevel != 2)
				return;
"

PositionHeader=\
"class HUDPosition : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"position\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${CommonIf}
			if (sb.HUDLevel != 2)
				return;
"

SpeedometerHeader=\
"class HUDSpeedometer : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"speedometer\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${CommonIf}
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

ObjectDescriptionHeader=\
"class HUDObjectDescription : HUDElement
{
	${Init}
	{
		ZLayer = 0;
		Namespace = \"objectdescription\";
	}

	${DrawHUDStuff}
	{${CheckSpectator}${CommonIf}
"
