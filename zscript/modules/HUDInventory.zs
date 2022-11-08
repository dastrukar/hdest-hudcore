class HUDInventory : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "inventory";
	}

	override void DrawHUDStuff(HCStatusbar sb)
	{
		if(AutomapActive)
		{
			sb.BeginHUD();

			//inventory selector
			sb.drawInvSel(6,100,10,109,sb.DI_TOPLEFT);
		}
		else if (sb.CPlayer.mo == sb.CPlayer.Camera && sb.hpl.Health > 0)
		{
			sb.BeginHUD(forceScaled: false);
			//inventory
			sb.drawSurroundingInv(25,-4,42,sb.mxht,sb.DI_SCREEN_CENTER_BOTTOM);
			sb.drawInvSel(25,-14,42,sb.mxht,sb.DI_SCREEN_CENTER_BOTTOM);
		}
	}
}
