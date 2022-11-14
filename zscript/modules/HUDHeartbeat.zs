class HUDHeartbeat : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "heartbeat";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//heartbeat/playercolour tracker
			if(sb.hpl && sb.hpl.beatmax){
				float cpb=sb.hpl.beatcount*1./sb.hpl.beatmax;
				float ysc=-(4+sb.hpl.bloodpressure*0.05);
				if(!sb.hud_aspectscale.getbool())ysc*=1.2;
				sb.fill(
					color(int(cpb*255),sb.sbcolour.r,sb.sbcolour.g,sb.sbcolour.b),
					32,-24-cpb*3,
					4,ysc,
					sb.DI_BOTTOMLEFT
				);
			}
		}
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			//heartbeat/playercolour tracker
			if(sb.hpl.beatmax){
				float cpb=sb.hpl.beatcount*1./sb.hpl.beatmax;
				float ysc=-(3+sb.hpl.bloodpressure*0.05);
				if(!sb.hud_aspectscale.getbool())ysc*=1.2;
				sb.fill(
					color(int(cpb*255),sb.sbcolour.r,sb.sbcolour.g,sb.sbcolour.b),
					-12,-6-cpb*2,3,ysc, sb.DI_SCREEN_CENTER_BOTTOM
				);
			}
		}
	}
}
