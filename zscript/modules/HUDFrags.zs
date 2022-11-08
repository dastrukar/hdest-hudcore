class HUDFrags : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "frags";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//frags
			if(deathmatch||fraglimit>0)sb.drawstring(
				sb.mHUDFont,sb.FormatNumber(sb.cplayer.fragcount),
				(30,24),sb.DI_TOPLEFT|sb.DI_TEXT_ALIGN_LEFT,
				Font.CR_RED
			);
		}
		else if (
			sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& State <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		)
		{
			//frags
			if(deathmatch||fraglimit>0)sb.drawstring(
				sb.mHUDFont,sb.FormatNumber(sb.cplayer.fragcount),
				(74,sb.mhht),sb.DI_TEXT_ALIGN_LEFT|sb.DI_SCREEN_CENTER_BOTTOM,
				Font.CR_RED
			);
		}
	}
}
