class HUDCrosshair : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "crosshair";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (!CheckAlwaysStuff(sb, state, ticFrac))
			return;


		//sb.draw the crosshair
		if(
			!sb.blurred
			&&sb.hpl.health>0
		)sb.drawHDXHair(sb.hpl,ticfrac);
		sb.SetSize(0, 320, 200);
		sb.BeginHUD(forceScaled: false);
	}
}
