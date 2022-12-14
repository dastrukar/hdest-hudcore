class HUDMugshot : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 1;
		Namespace = "mugshot";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//mugshot
			sb.drawTexture(sb.GetMugShot(5,Mugshot.CUSTOM,sb.GetMug(sb.hpl.mugshot)),(6,-14),sb.DI_BOTTOMLEFT,alpha:sb.blurred?0.2:1.);
		}
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			if(sb.usemughud)sb.drawTexture(
				sb.GetMugShot(5,Mugshot.CUSTOM,sb.GetMug(sb.hpl.mugshot)),(0,-14),
				sb.DI_ITEM_CENTER_BOTTOM|sb.DI_SCREEN_CENTER_BOTTOM,
				alpha:sb.blurred?0.2:1.
			);
		}
	}
}
