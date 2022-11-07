// i'm tired of overriding statusbar.zs >:[
class HCStatusbar : HDStatusbar
{
	private Array<HUDElement> _HUDElements;

	int mxht;

	override void Init()
	{
		Super.Init();

		Console.PrintF("Initialising HCStatusbar.");

		// Get all classes that inherit from HUDElement
		_HUDElements.Clear();
		for (int ci = 0; ci < AllClasses.Size(); ci++)
		{
			if (AllClasses[ci] is "HUDElement" && AllClasses[ci].GetClassName() != "HUDElement")
			{
				let element = HUDElement(new(AllClasses[ci]));
				element.Init(self);

				if (element.Namespace == "")
					continue;

				bool elementReplaced = false;
				for (int ei = 0; ei < _HUDElements.Size(); ei++)
				{
					if (_HUDElements[ei].Namespace == element.Namespace)
					{
						elementReplaced = true;
						_HUDElements[ei] = element;
						break;
					}
				}

				if (!elementReplaced)
					_HUDElements.Push(element);
			}
		}

		InitVariables();
	}

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
