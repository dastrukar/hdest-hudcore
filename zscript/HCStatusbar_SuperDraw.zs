extend class HCStatusbar
{
	private void SuperDraw(int state, double ticFrac)
	{
		cplayer.inventorytics=0;




		//blacking out
		if(hpl.blackout>0)fill(
			color(hpl.blackout,6,2,0),0,0,screen.getwidth(),screen.getheight()
		);


		drawtip();
		if(idmypos)Drawmypos();
	}
}
