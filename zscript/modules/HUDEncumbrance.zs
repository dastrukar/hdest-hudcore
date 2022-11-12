class HUDEncumbrance : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "encumbrance";
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

			if (sb.HUDLevel != 2)
				return;
			//encumbrance
			if(sb.hpl.enc){
				double pocketenc=sb.hpl.pocketenc;
				sb.drawstring(
					sb.pnewsmallfont,sb.FormatNumber(int(sb.hpl.enc)),
					(8,sb.mxht),sb.DI_TEXT_ALIGN_LEFT|sb.DI_SCREEN_LEFT_BOTTOM,
					sb.hpl.overloaded<0.8?Font.CR_OLIVE:sb.hpl.overloaded>1.6?Font.CR_RED:Font.CR_GOLD,scale:(0.5,0.5)
				);
				int encbarheight=sb.mxht+5;
				sb.fill(
					color(128,96,96,96),
					4,encbarheight,1,-1,
					sb.DI_SCREEN_LEFT_BOTTOM|sb.DI_ITEM_LEFT
				);
				sb.fill(
					color(128,96,96,96),
					5,encbarheight,1,-20,
					sb.DI_SCREEN_LEFT_BOTTOM|sb.DI_ITEM_LEFT
				);
				sb.fill(
					color(128,96,96,96),
					3,encbarheight,1,-20,
					sb.DI_SCREEN_LEFT_BOTTOM|sb.DI_ITEM_LEFT
				);
				encbarheight--;
				sb.drawrect(
					4,encbarheight,1,
					-min(sb.hpl.maxpocketspace,pocketenc)*19/sb.hpl.maxpocketspace,
					sb.DI_SCREEN_LEFT_BOTTOM|sb.DI_ITEM_LEFT
				);
				bool overenc=sb.hpl.flip&&pocketenc>sb.hpl.maxpocketspace;
				sb.fill(
					overenc?color(255,216,194,42):color(128,96,96,96),
					4,encbarheight-19,1,overenc?3:1,
					sb.DI_SCREEN_LEFT_BOTTOM|sb.DI_ITEM_LEFT
				);
			}
		}
	}
}
