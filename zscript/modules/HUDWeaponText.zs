class HUDWeaponText : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "weapontext";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (!CheckAlwaysStuff(sb, state, ticFrac))
			return;

		//sb.Draw information text for selected weapon
		sb.SetSize(0,320,200);
		sb.BeginHUD(forcescaled:true);
		let hdw=HDWeapon(sb.cplayer.readyweapon);
		if(hdw&&hdw.msgtimer>0)sb.DrawString(
			sb.pSmallFont,hdw.wepmsg,(0,48),
			sb.DI_SCREEN_HCENTER|sb.DI_TEXT_ALIGN_CENTER,
			translation:Font.CR_DARKGRAY,
			wrapwidth:smallfont.StringWidth("m")*80
		);
		sb.SetSize(0, 320, 200);
		sb.BeginHUD(forceScaled: false);
	}
}
