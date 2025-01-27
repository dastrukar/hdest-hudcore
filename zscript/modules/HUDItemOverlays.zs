class HUDItemOverlays : HUDItemOverrides
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "itemoverlays";
		_OverrideType = HCOVERRIDETYPE_OVERLAY;

		Super.Init(sb);
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (!CheckAlwaysStuff(sb, state, ticFrac))
			return;

		DrawItemHUDAdditions(sb);
		sb.SetSize(0, 320, 200);
		sb.BeginHUD(forceScaled: false);
	}
}
