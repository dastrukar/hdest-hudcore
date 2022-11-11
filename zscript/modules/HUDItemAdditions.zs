class HUDItemAdditions : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "itemadditions";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//items
			sb.drawItemHUDAdditions(HDSB_AUTOMAP,sb.DI_TOPLEFT);
		}
		else if (
			!AutomapActive
			&& sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& State <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		)
		{
			//items
			sb.drawItemHUDAdditions(
				sb.usemughud?HDSB_MUGSHOT:0
				,sb.DI_SCREEN_CENTER_BOTTOM
			);
		}
	}
}
