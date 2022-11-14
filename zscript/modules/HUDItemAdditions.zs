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
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			//items
			sb.drawItemHUDAdditions(
				sb.usemughud?HDSB_MUGSHOT:0
				,sb.DI_SCREEN_CENTER_BOTTOM
			);
		}
	}
}
