class HUDWeaponStash : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "weaponstash";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			sb.drawweaponstash(true,-48);		}
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			if (sb.HUDLevel != 2)
				return;
			sb.drawweaponstash();		}
	}
}
