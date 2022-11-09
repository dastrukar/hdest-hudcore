extend class HCStatusbar
{
	private void SuperDraw(int state, double ticFrac)
	{
		if(hpl.blackout>0)fill(
			color(hpl.blackout,6,2,0),0,0,screen.getwidth(),screen.getheight()
		);
		drawtip();
		if(idmypos)drawmypos();
	}
}
