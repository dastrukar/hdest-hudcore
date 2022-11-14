class HUDSpeedometer : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "speedometer";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;
		if (CheckCommonStuff(sb, state, ticFrac))
		{

			int wephelpheight=NewSmallFont.GetHeight()*5;
			wephelpheight+=NewSmallFont.GetHeight();
			if(hd_debug>=3){
				double velspd=sb.hpl.vel.length();
				string velspdout=velspd.."   "..(velspd*HDCONST_MPSTODUPT).."mps   "..(velspd*HDCONST_MPSTODUPT*HDCONST_MPSTOKPH).."km/h";
				screen.drawText(NewSmallFont,
					font.CR_GRAY,
					600-(NewSmallFont.StringWidth(velspdout)>>1),
					NewSmallFont.GetHeight(),
					velspdout,
					DTA_VirtualWidth,640,DTA_VirtualHeight,480
				);
			}
		}
	}
}
