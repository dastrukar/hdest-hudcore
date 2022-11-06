extend class HCStatusbar
{
	override void Init()
	{
		Super.Init();

		Console.PrintF("Initialising HCStatusbar.");

		// Get all classes that inherit from HUDElement
		_HUDElements.Clear();
		for (int i = 0; i < AllClasses.Size(); i++)
		{
			if (AllClasses[i] is "HUDElement" && AllClasses[i].GetClassName() != "HUDElement")
				_HUDElements.Push(HUDElement(new(AllClasses[i])));
		}

		int mxht=-4-mIndexFont.mFont.GetHeight();
	}
}
