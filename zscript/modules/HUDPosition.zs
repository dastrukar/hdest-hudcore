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
		if (CheckCommonStuff(sb, state, ticFrac))
		{

			if (sb.HUDLevel != 2)
				return;
			int wephelpheight=NewSmallFont.GetHeight()*5;
			wephelpheight+=NewSmallFont.GetHeight();
			string postxt=string.format("%i,%i,%i",sb.hpl.pos.x,sb.hpl.pos.y,sb.hpl.pos.z);
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
