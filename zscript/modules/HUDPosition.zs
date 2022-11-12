class HUDPosition : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "position";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;
		if (
			!AutomapActive
			&& sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& State <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		)
		{

			if (sb.HUDLevel != 2)
				return;
			int wephelpheight=NewSmallFont.GetHeight()*5;
			wephelpheight+=NewSmallFont.GetHeight();
			string postxt=string.format("0,0,0",sb.hpl.pos.x,sb.hpl.pos.y,sb.hpl.pos.z);
			screen.drawText(NewSmallFont,
				font.CR_OLIVE,
				600-(NewSmallFont.StringWidth(postxt)>>1),
				wephelpheight+6,
				postxt,
				DTA_VirtualWidth,640,DTA_VirtualHeight,480
			);
		}
	}
}
