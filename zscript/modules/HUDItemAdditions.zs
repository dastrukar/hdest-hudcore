class HUDItemAdditions : HUDItemOverrides
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "itemadditions";
		_OverrideType = HCOVERRIDETYPE_ITEM;

		Super.Init(sb);
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//items
			DrawItemHUDAdditions(sb,HDSB_AUTOMAP,sb.DI_TOPLEFT);
		}
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			//items
			DrawItemHUDAdditions(sb,
				sb.usemughud?HDSB_MUGSHOT:0
				,sb.DI_SCREEN_CENTER_BOTTOM
			);
		}
	}
}
