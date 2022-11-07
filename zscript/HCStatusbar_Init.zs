extend class HCStatusbar
{
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

				int elementIndex = -1;
				for (int ei = 0; ei < _HUDElements.Size(); ei++)
				{
					if (_HUDElements[ei].Namespace == element.Namespace)
					{
						elementIndex = ei;
						_HUDElements[ei] = element;
					}

				}
				_HUDElements.Push(element);
			}
		}

		mxht=-4-mIndexFont.mFont.GetHeight();
	}
}
