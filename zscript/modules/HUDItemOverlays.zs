class HUDItemOverlays : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "itemoverlays";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (!CheckAlwaysStuff(sb, state, ticFrac))
			return;


		//sb.draw item overlays
		for(int i=0;i<sb.hpl.OverlayGivers.size();i++){
			let ppp=sb.hpl.OverlayGivers[i];
			if(
				ppp
				&&ppp.owner==sb.hpl
			)ppp.DisplayOverlay(sb,sb.hpl);
		}
		sb.SetSize(0, 320, 200);
		sb.BeginHUD(forceScaled: false);
	}
}
