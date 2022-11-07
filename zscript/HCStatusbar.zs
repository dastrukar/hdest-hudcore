// i'm tired of overriding statusbar.zs >:[
class HCStatusbar : HDStatusbar
{
	private Array<HUDElement> _HUDElements;

	int mxht;

	override void Draw(int state, double ticFrac)
	{
		hpl = HDPlayerPawn(CPlayer.mo);
		if (!CPlayer || !hpl)
			return;

		CPlayer.InventoryTics = 0;

		if (AutomapActive)
		{
			SetSize(0, 480, 300);
			DrawAutomapHUD(ticFrac);
		}
		else
			SetSize(0, 320, 200);

		// Draw elements
		for (int i = 0; i < _HUDElements.Size(); i++)
		{
			_HUDElements[i].DrawHUDStuff(self);
		}

		// basically Super.Draw() but a bit trimmed
		SuperDraw(state, ticFrac);
	}
}
