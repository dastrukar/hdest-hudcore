class HUDAutomapPos : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "automappos";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			sb.drawmypos(10);
		}
	}
}
