class HUDItemOverlays : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "itemoverlays";
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
