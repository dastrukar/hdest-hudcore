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

		if (
			!AutomapActive
			&& sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& State <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		)
		{

			//weapon readouts!
			if(sb.cplayer.readyweapon&&sb.cplayer.readyweapon!=WP_NOCHANGE)
				sb.drawweaponstatus(sb.cplayer.readyweapon);
		}
	}
}
