class HUDInventory : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "inventory";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//inventory selector
			sb.drawInvSel(6,100,10,109,sb.DI_TOPLEFT);
		}
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			//inventory
			sb.drawSurroundingInv(25,-4,42,sb.mxht,sb.DI_SCREEN_CENTER_BOTTOM);
			sb.drawInvSel(25,-14,42,sb.mxht,sb.DI_SCREEN_CENTER_BOTTOM);
		}
	}
}
