class HUDWeaponSprite : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "weaponsprite";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//guns
			sb.drawselectedweapon(-80,-60,sb.DI_BOTTOMRIGHT);
		}
		else if (
			!AutomapActive
			&& sb.CPlayer.mo == sb.CPlayer.Camera
			&& sb.hpl.Health > 0
			&& State <= sb.HUD_Fullscreen
			&& sb.HUDLevel > 0
			&& !HDSpectator(sb.hpl)
		)
		{
			//weapon sprite
			if(
				sb.hudlevel==2
				||cvar.getcvar("hd_hudsprite",sb.cplayer).getbool()
				||!cvar.getcvar("r_drawplayersprites",sb.cplayer).getbool()
			)
			sb.drawselectedweapon(58,-6,sb.DI_SCREEN_CENTER_BOTTOM|sb.DI_ITEM_LEFT_BOTTOM);
		}
	}
}
