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
		if (CheckCommonStuff(sb, state, ticFrac))
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
