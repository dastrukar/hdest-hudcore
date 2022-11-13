class HUDCrosshair : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "crosshair";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (
			AutomapActive
			|| sb.CPlayer.mo != sb.CPlayer.Camera
			|| (
				sb.hpl.Health > 0
				&& (sb.hpl.bInvisible || sb.hpl.alpha <= 0)
			)
		)
			return;


		//sb.draw the crosshair
		if(
			!sb.blurred
			&&sb.hpl.health>0
		)sb.drawHDXHair(sb.hpl,ticfrac);
	}
}
