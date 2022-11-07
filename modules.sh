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
	override void Init()
	{
		Super.Init();

		Console.PrintF(\"Initialising HCStatusbar.\");

		// Get all classes that inherit from HUDElement
		_HUDElements.Clear();
		for (int ci = 0; ci < AllClasses.Size(); ci++)
		{
			if (AllClasses[ci] is \"HUDElement\" && AllClasses[ci].GetClassName() != \"HUDElement\")
			{
				let element = HUDElement(new(AllClasses[ci]));
				element.Init(self);

				if (element.Namespace == \"\")
					continue;

				int elementIndex = -1;
				for (int ei = 0; ei < _HUDElements.Size(); ei++)
				{
					if (_HUDElements[ei].Namespace == element.Namespace)
					{
						elementIndex = ei;
						_HUDElements[ei] = element;
					}

				}
				_HUDElements.Push(element);
			}
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
	${Init}
	{
		Namespace = \"heartbeat\";
	}

	${DrawHUDStuff}
	{${AutomapActive}
"

EKGHeader=\
"class HUDEKGMonitor : HUDElement
{
	${Init}
	{
		Namespace = \"ekg\";
	}

	${DrawHUDStuff}
	{${AutomapActive}
"
