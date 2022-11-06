// i'm tired of overriding statusbar.zs >:[
class HCStatusbar : HDStatusbar
{
	private Array<HUDElement> _HUDElements;

	int mxht;

	override void Draw(int state, double ticFrac)
	{
		// basically Super.Draw() but a bit trimmed
		SuperDraw(state, ticFrac);

		if (AutomapActive)
			DrawAutomapHUD(ticFrac);

		// Draw elements
		for (int i = 0; i < _HUDElements.Size(); i++)
		{
			_HUDElements[i].DrawHUDStuff(self);
		}
	}
}
