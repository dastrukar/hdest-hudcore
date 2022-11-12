class HUDCompass : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "compass";
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
			//compass
			int STB_COMPRAD=12;vector2 compos=(-STB_COMPRAD,STB_COMPRAD)*2;
			double compangle=sb.hpl.angle;
			double compangle2=sb.hpl.deltaangle(0,compangle);
			if(abs(compangle2)<120)screen.drawText(NewSmallFont,
				font.CR_GOLD,
				600+compangle2*32/sb.cplayer.fov,
				wephelpheight,
				"E",
				DTA_VirtualWidth,640,DTA_VirtualHeight,480
			);
			compangle2=sb.hpl.deltaangle(-90,compangle);
			if(abs(compangle2)<120)screen.drawText(NewSmallFont,
				font.CR_BLACK,
				600+compangle2*32/sb.cplayer.fov,
				wephelpheight,
				"S",
				DTA_VirtualWidth,640,DTA_VirtualHeight,480
			);
			compangle2=sb.hpl.deltaangle(180,compangle);
			if(abs(compangle2)<120)screen.drawText(NewSmallFont,
				font.CR_RED,
				600+compangle2*32/sb.cplayer.fov,
				wephelpheight,
				"W",
				DTA_VirtualWidth,640,DTA_VirtualHeight,480
			);
			compangle2=sb.hpl.deltaangle(90,compangle);
			if(abs(compangle2)<120)screen.drawText(NewSmallFont,
				font.CR_WHITE,
				600+compangle2*32/sb.cplayer.fov,
				wephelpheight,
				"N",
				DTA_VirtualWidth,640,DTA_VirtualHeight,480
			);
			string s=sb.hpl.wephelptext;
			wephelpheight+=NewSmallFont.GetHeight();
			screen.drawText(NewSmallFont,
				font.CR_OLIVE,
				600,
				wephelpheight,
				"^",
				DTA_VirtualWidth,640,DTA_VirtualHeight,480
			);
		}
	}
}
