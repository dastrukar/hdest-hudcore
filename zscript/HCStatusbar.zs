// i'm tired of overriding statusbar.zs >:[
class HCStatusbar : HDStatusbar
{
	private Array<HUDElement> _HUDElements;

	int mxht;
	int mhht;
	bool UseMugHUD;

	// used for debugging sorter
	private void PrintArray()
	{
		string text = "[ ";
		for (int i = 0; i < _HUDElements.Size(); i++)
		{
			text = text.._HUDElements[i].ZLayer.." ";
		}

		Console.PrintF(text.."]");
	}

	// Poor man's QuickSort
	private void QuickSortElements(int minIndex, int maxIndex)
	{
		if (minIndex >= maxIndex)
			return;

		int leftIndex = minIndex;
		int rightIndex = maxIndex - 1;

		// Pick pivot
		int pivotIndex = maxIndex;
		HUDElement pivot = _HUDElements[pivotIndex];

		while (leftIndex < rightIndex)
		{
			// Find a value larger than to the pivot
			while (leftIndex < rightIndex && _HUDElements[leftIndex].ZLayer < pivot.ZLayer)
			{
				++leftIndex;
			}

			// Find a value less than/equal to the pivot
			while (leftIndex < rightIndex && _HUDElements[rightIndex].ZLayer >= pivot.ZLayer)
			{
				--rightIndex;
			}

			if (leftIndex >= rightIndex)
				break;

			// Swap
			HUDElement tmp = _HUDElements[leftIndex];
			_HUDElements[leftIndex] = _HUDElements[rightIndex];
			_HUDElements[rightIndex] = tmp;
		}

		// Try to swap pivot
		if (leftIndex < pivotIndex && _HUDElements[leftIndex].ZLayer > pivot.ZLayer)
		{
			HUDElement tmp = _HUDElements[leftIndex];
			_HUDElements[leftIndex] = pivot;
			_HUDElements[pivotIndex] = tmp;
			pivotIndex = leftIndex;
		}

		QuickSortElements(minIndex, pivotIndex - 1);
		QuickSortElements(pivotIndex + 1, maxIndex);
	}

	override void Init()
	{
		Super.Init();

		Console.PrintF("Initialising HCStatusbar.");

		// Get all classes that inherit from HUDElement
		bool sortElements = false;
		int highestZLayer = 0;
		_HUDElements.Clear();
		for (int ci = 0; ci < AllClasses.Size(); ci++)
		{
			if (AllClasses[ci] is "HUDElement" && AllClasses[ci].GetClassName() != "HUDElement")
			{
				let element = HUDElement(new(AllClasses[ci]));
				element.Init(self);

				if (element.Namespace == "")
					continue;

				// Check if the list is unsorted
				if (element.ZLayer > highestZLayer)
					highestZLayer = element.ZLayer;

				else if (element.ZLayer < highestZLayer)
					sortElements = true;

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

		if (sortElements)
			QuickSortElements(0, _HUDElements.Size() - 1);

		InitVariables();
		UseMugHUD = false;
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
			BeginHUD();
			DrawAutomapHUD(ticFrac);
		}
		else
		{
			SetSize(0, 320, 200);
			BeginHUD(forceScaled: false);
			UseMugHUD = (
				hd_hudstyle.GetInt() == 1
				|| (
					State == HUD_Fullscreen
					&& !hd_hudstyle.GetInt()
				)
			);
		}

		// Draw elements
		for (int i = 0; i < _HUDElements.Size(); i++)
		{
			_HUDElements[i].DrawHUDStuff(self, state, ticFrac);
		}

		// basically Super.Draw() but a bit trimmed
		SuperDraw(state, ticFrac);
	}
}
