class HUDAmmoCounters : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "ammocounters";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			sb.drawammocounters(-18);		}
		else if (
			!AutomapActive
			&& sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& State <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		)
		{
			if (sb.HUDLevel != 2)
				return;
			sb.drawammocounters(sb.mxht);		}
	}
}
