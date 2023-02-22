class HUDItemOverrides : HUDElement abstract
{
	protected int _OverrideType; // Determines what type would be used (see HCItemOverride)
	protected Array<HCItemOverride> _Overrides;

	// Make sure to call this *after* you've set your _OverrideType
	override void Init(HCStatusbar sb)
	{
		_Overrides.Clear();

		int highestPriority = 0;
		bool sortOverrides = false;
		for (int i = 0; i < AllClasses.Size(); i++)
		{
			if (
				!(AllClasses[i] is "HCItemOverride")
				|| AllClasses[i].IsAbstract()
			)
				continue;

			let itemOverride = HCItemOverride(new(AllClasses[i]));
			itemOverride.Init(sb);
			
			if (itemOverride.OverrideType != _OverrideType)
				continue;

			if (itemOverride.Priority > highestPriority)
				highestPriority = itemOverride.Priority;

			else if (itemOverride.Priority < highestPriority)
				sortOverrides = true;

			_Overrides.Push(itemOverride);
		}

		if (sortOverrides)
			QuickSortOverrides(0, _Overrides.Size() - 1);
	}

	// copied from HCStatusbar.zs
	protected void QuickSortOverrides(int minIndex, int maxIndex)
	{
		if (minIndex >= maxIndex)
			return;

		int leftIndex = minIndex;
		int rightIndex = maxIndex - 1;

		// Pick pivot
		int pivotIndex = maxIndex;
		HCItemOverride pivot = _Overrides[pivotIndex];

		while (leftIndex < rightIndex)
		{
			// Find a value larger than to the pivot
			while (leftIndex < rightIndex && _Overrides[leftIndex].Priority < pivot.Priority)
			{
				++leftIndex;
			}

			// Find a value less than/equal to the pivot
			while (leftIndex < rightIndex && _Overrides[rightIndex].Priority >= pivot.Priority)
			{
				--rightIndex;
			}

			if (leftIndex >= rightIndex)
				break;

			// Swap
			HCItemOverride tmp = _Overrides[leftIndex];
			_Overrides[leftIndex] = _Overrides[rightIndex];
			_Overrides[rightIndex] = tmp;
		}

		// Try to swap pivot
		if (leftIndex < pivotIndex && _Overrides[leftIndex].Priority > pivot.Priority)
		{
			HCItemOverride tmp = _Overrides[leftIndex];
			_Overrides[leftIndex] = pivot;
			_Overrides[pivotIndex] = tmp;
			pivotIndex = leftIndex;
		}

		QuickSortOverrides(minIndex, pivotIndex - 1);
		QuickSortOverrides(pivotIndex + 1, maxIndex);
	}

	protected HCItemOverride FindOverride(Inventory item)
	{
		for (int i = 0; i < _Overrides.Size(); i++)
		{
			if (_Overrides[i].CheckItem(item))
				return _Overrides[i];
		}

		return NULL;
	}

	// Replaces sb.DrawItemHUDAdditions(), and sb.DrawWeaponStatus()
	// also mostly copied from the original, so credits to Matt
	protected void DrawItemHUDAdditions(HCStatusbar sb, int hdFlags = 0, int gzFlags = 0)
	{
		HCItemOverride itemOverride;

		if (!sb.hpl)
			return;

		switch (_OverrideType)
		{
			case HCOVERRIDETYPE_ITEM:
				for (let item = sb.hpl.Inv; item != NULL; item = item.Inv)
				{
					let hp = HDPickup(item);
					if (!hp)
						continue;

					itemOverride = FindOverride(hp);
					if (itemOverride)
						itemOverride.DrawHUDStuff(sb, hdFlags, gzFlags);

					else
						hp.DrawHUDStuff(sb, sb.hpl, hdFlags, gzFlags);
				}

				break;

			case HCOVERRIDETYPE_WEAPON:
				if (!sb.CPlayer.ReadyWeapon)
					break;

				itemOverride = FindOverride(sb.CPlayer.ReadyWeapon);
				if (itemOverride)
					itemOverride.DrawHUDStuff(sb, hdFlags, gzFlags);

				else
					sb.DrawWeaponStatus(sb.CPlayer.ReadyWeapon);

				break;

			case HCOVERRIDETYPE_OVERLAY:
				for (int i = 0; i < sb.hpl.OverlayGivers.Size(); i++)
				{
					let ppp = sb.hpl.OverlayGivers[i];
					if (
						!ppp
						|| ppp.Owner != sb.hpl
					)
						continue;

					itemOverride = FindOverride(ppp);
					if (itemOverride)
						itemOverride.DrawHUDStuff(sb, hdFlags, gzFlags);
					ppp.DisplayOverlay(sb, sb.hpl);
				}
				break;
		}
	}
}
