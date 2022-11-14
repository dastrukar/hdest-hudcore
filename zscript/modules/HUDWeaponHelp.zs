class HUDWeaponHelp : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "weaponhelp";
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
			string s=sb.hpl.wephelptext;
			if(s!="")screen.drawText(NewSmallFont,OptionMenuSettings.mFontColorValue,
				8,
				wephelpheight,
				s,
				DTA_VirtualWidth,640,
				DTA_VirtualHeight,480,
				DTA_Alpha,0.8
			);
		}
	}
}
