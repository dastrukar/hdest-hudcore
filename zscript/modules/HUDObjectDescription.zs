class HUDObjectDescription : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "objectdescription";
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

			//object description
			sb.drawstring(
				sb.pnewsmallfont,sb.hpl.viewstring,
				(0,20),sb.DI_SCREEN_CENTER|sb.DI_TEXT_ALIGN_CENTER,
				Font.CR_GREY,0.4,scale:(1,1)
			);
		}
	}
}
