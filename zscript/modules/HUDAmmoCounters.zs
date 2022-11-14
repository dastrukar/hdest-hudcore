class HUDAmmoCounters : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "ammocounters";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			sb.drawammocounters(-18);		}
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			if (sb.HUDLevel != 2)
				return;
			sb.drawammocounters(sb.mxht);		}
	}
}
