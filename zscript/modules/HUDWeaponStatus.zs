class HUDWeaponStatus : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "weaponstatus";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (CheckCommonStuff(sb, state, ticFrac))
		{

			//weapon readouts!
			if(sb.cplayer.readyweapon&&sb.cplayer.readyweapon!=WP_NOCHANGE)
				sb.drawweaponstatus(sb.cplayer.readyweapon);
		}
	}
}
