// Why is this part of the statusbar?
// Oh well.
class HUDSetWeaponDefault : HUDElement
{
	override void Init(HCStatusbar sb)
	{
		ZLayer = 0;
		Namespace = "setweapondefault";
	}

	override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)
	{
		if (!CheckAlwaysStuff(sb, state, ticFrac))
			return;

		//reads sb.hd_setweapondefault and updates accordingly
		if(sb.hd_setweapondefault.getstring()!=""){
			string wpdefs=cvar.getcvar("sb.hd_weapondefaults",sb.cplayer).getstring().makelower();
			string wpdlastchar=wpdefs.mid(wpdefs.length()-1,1);
			while(
				wpdlastchar==" "
				||wpdlastchar==","
			){
				wpdefs=wpdefs.left(wpdefs.length()-1);
				wpdlastchar=wpdefs.mid(wpdefs.length()-1,1);
			}
			string newdef=sb.hd_setweapondefault.getstring().makelower();
			newdef.replace(",","");
			string newdefwep=newdef.left(3);
			newdefwep.replace(" ","");
			newdefwep.replace(",","");
			if(newdefwep.length()==3){
				int whereisold=wpdefs.rightindexof(newdefwep);
				if(whereisold<0){
					wpdefs=wpdefs..","..newdef;
				}else{
					string leftofdef=wpdefs.left(whereisold);
					wpdefs=wpdefs.mid(whereisold);
					int whereiscomma=wpdefs.indexof(",");
					if(whereiscomma<0){
						if(newdef==newdefwep)wpdefs="";
						else wpdefs=newdef;
					}else{
						if(newdef==newdefwep)wpdefs=wpdefs.mid(whereiscomma);
						else wpdefs=newdef..wpdefs.mid(whereiscomma);
					}
					if(leftofdef!=""){
						wpdlastchar=leftofdef.mid(leftofdef.length()-1,1);
						while(
							wpdlastchar==" "
							||wpdlastchar==","
						){
							leftofdef=leftofdef.left(leftofdef.length()-1);
							wpdlastchar=leftofdef.mid(leftofdef.length()-1,1);
						}
						wpdefs=leftofdef..","..wpdefs;
					}
				}
				wpdefs.replace(",,",",");
				wpdlastchar=wpdefs.mid(wpdefs.length()-1,1);
				while(
					wpdlastchar==" "
					||wpdlastchar==","
				){
					wpdefs=wpdefs.left(wpdefs.length()-1);
					wpdlastchar=wpdefs.mid(wpdefs.length()-1,1);
				}

				sb.hd_setweapondefault.setstring("");
				cvar.findcvar("sb.hd_weapondefaults").setstring(wpdefs);
			}
		}


		//update loadout1 based on old custom
		//delete once old custom is gone!
		let lomt=LoadoutMenuHackToken(ThinkerFlag.Find(sb.cplayer.mo,"LoadoutMenuHackToken"));
		if(lomt)cvar.findcvar("hd_loadout1").setstring(lomt.loadout);
	}
}
