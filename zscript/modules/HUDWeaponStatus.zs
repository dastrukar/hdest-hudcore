class HUDWeaponStatus : HUDItemOverrides
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "weaponstatus";
		_OverrideType = HCOVERRIDETYPE_WEAPON;

		Super.Init(sb);
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (CheckCommonStuff(sb, state, ticFrac))
		{

			//weapon readouts!
			if(sb.cplayer.readyweapon&&sb.cplayer.readyweapon!=WP_NOCHANGE)
				DrawItemHUDAdditions(sb);
		}
	}
}
