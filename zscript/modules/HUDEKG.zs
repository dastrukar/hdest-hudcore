class HUDEKGMonitor : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		Namespace = "ekg";
	}

	override void DrawHUDStuff(HCStatusbar sb)
	{
		if(AutomapActive)
		{
			sb.BeginHUD();

			//health
			if(hd_debug)sb.drawstring(
				sb.pnewsmallfont,sb.FormatNumber(sb.hpl.health),
				(34,-24),sb.DI_BOTTOMLEFT|sb.DI_TEXT_ALIGN_CENTER,
				sb.hpl.health>70?Font.CR_OLIVE:(sb.hpl.health>33?Font.CR_GOLD:Font.CR_RED),scale:(0.5,0.5)
			);else sb.drawHealthTicker((40,-24),sb.DI_BOTTOMLEFT);
		}
		else if (sb.CPlayer.mo == sb.CPlayer.Camera && sb.hpl.Health > 0)
		{
			sb.BeginHUD(forceScaled: false);
			//health
			if(hd_debug)sb.drawstring(
				sb.pnewsmallfont,sb.FormatNumber(sb.hpl.health),
				(0,sb.mxht),sb.DI_TEXT_ALIGN_CENTER|sb.DI_SCREEN_CENTER_BOTTOM,
				sb.hpl.health>70?Font.CR_OLIVE:(sb.hpl.health>33?Font.CR_GOLD:Font.CR_RED),scale:(0.5,0.5)
			);else sb.drawHealthTicker();
		}
	}
}
