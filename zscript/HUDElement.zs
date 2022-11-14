// Each class that derives from this will be used in HCStatusbar.
class HUDElement ui abstract
{
	int ZLayer;
	string Namespace;

	virtual void Init(HCStatusbar sb)
	{
		ZLayer = 0;

		// Every HUDElement has a namespace. If they don't have one, it won't be added to the HUD. (might reconsider this)
		// If another HUDElement has the same namespace, they'll overwrite each other.
		Namespace = "";
	}

	virtual void Tick(HCStatusbar sb) {}

	virtual void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac) {}

	// The following functions are for doing checks, because typing them out everytime is annoying as hell
	// If you want to check for automap, just use the AutomapActive variable

	// Returns true if the statusbar would be running DrawAlwaysStuff
	protected bool CheckAlwaysStuff(HCStatusbar sb, int state, double ticFrac)
	{
		return !(
			AutomapActive
			|| sb.CPlayer.mo != sb.CPlayer.Camera
			|| (
				sb.hpl.Health > 0
				&& (sb.hpl.bInvisible || sb.hpl.alpha <= 0)
			)
		);
	}

	// Returns true if the statusbar would be running DrawCommonStuff
	protected bool CheckCommonStuff(HCStatusbar sb, int state, double ticFrac)
	{
		return (
			!AutomapActive
			&& sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& state <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		);
	}
}
