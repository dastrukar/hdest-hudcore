class HUDKeys : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "keys";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (HDSpectator(sb.hpl))
			return;

		if (AutomapActive)
		{

			//KEYS!
			if(sb.hpl.countinv("BlueCard"))sb.drawimage("BKEYB0",(10,24),sb.DI_TOPLEFT);
			if(sb.hpl.countinv("YellowCard"))sb.drawimage("YKEYB0",(10,44),sb.DI_TOPLEFT);
			if(sb.hpl.countinv("RedCard"))sb.drawimage("RKEYB0",(10,64),sb.DI_TOPLEFT);
			if(sb.hpl.countinv("BlueSkull"))sb.drawimage("BSKUA0",(6,30),sb.DI_TOPLEFT);
			if(sb.hpl.countinv("YellowSkull"))sb.drawimage("YSKUA0",(6,50),sb.DI_TOPLEFT);
			if(sb.hpl.countinv("RedSkull"))sb.drawimage("RSKUB0",(6,70),sb.DI_TOPLEFT);
		}
		else if (CheckCommonStuff(sb, state, ticFrac))
		{
			//keys
			string keytype="";
			if(sb.hpl.countinv("BlueCard"))keytype="STKEYS0";
			if(sb.hpl.countinv("BlueSkull")){
				if(keytype=="")keytype="STKEYS3";
				else keytype="STKEYS6";
			}
			if(keytype!="")sb.drawimage(
				keytype,
				(50,-16),
				sb.DI_SCREEN_CENTER_BOTTOM
			);
			keytype="";
			if(sb.hpl.countinv("YellowCard"))keytype="STKEYS1";
			if(sb.hpl.countinv("YellowSkull")){
				if(keytype=="")keytype="STKEYS4";
				else keytype="STKEYS7";
			}
			if(keytype!="")sb.drawimage(
				keytype,
				(50,-10),
				sb.DI_SCREEN_CENTER_BOTTOM
			);
			keytype="";
			if(sb.hpl.countinv("RedCard"))keytype="STKEYS2";
			if(sb.hpl.countinv("RedSkull")){
				if(keytype=="")keytype="STKEYS5";
				else keytype="STKEYS8";
			}
			if(keytype!="")sb.drawimage(
				keytype,
				(50,-4),
				sb.DI_SCREEN_CENTER_BOTTOM
			);
		}
	}
}
