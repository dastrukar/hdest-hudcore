class HUDEKG : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "ekg";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//health
			if(
				hd_debug
				||hd_nobleed
			)sb.drawstring(
				sb.pnewsmallfont,sb.FormatNumber(sb.hpl.health),
				(34,-24),sb.DI_BOTTOMLEFT|sb.DI_TEXT_ALIGN_CENTER,
				sb.hpl.health>70?Font.CR_OLIVE:(sb.hpl.health>33?Font.CR_GOLD:Font.CR_RED),scale:(0.5,0.5)
			);else sb.drawHealthTicker((40,-24),sb.DI_BOTTOMLEFT);
		}
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			//health
			if(
				hd_debug
				||hd_nobleed
			)sb.drawstring(
				sb.pnewsmallfont,sb.FormatNumber(sb.hpl.health),
				(0,sb.mxht),sb.DI_TEXT_ALIGN_CENTER|sb.DI_SCREEN_CENTER_BOTTOM,
				sb.hpl.health>70?Font.CR_OLIVE:(sb.hpl.health>33?Font.CR_GOLD:Font.CR_RED),scale:(0.5,0.5)
			);else sb.drawHealthTicker();
		}
	}
}
