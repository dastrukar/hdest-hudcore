enum OverrideTypes
{
	HCOVERRIDETYPE_ITEM,
	HCOVERRIDETYPE_WEAPON,
	HCOVERRIDETYPE_OVERLAY
};

// Generic class to allow overriding an item's/weapon's DrawHUDStuff
class HCItemOverride ui abstract
{
	int OverrideType;
	int Priority;

	virtual void Init(HCStatusbar sb)
	{
		Priority = 0; // The bigger the number, the higher the priority
		OverrideType = HCOVERRIDETYPE_ITEM; // Determines if it's an item/a weapon/an item overlay
	}

	// Check if it's the correct item
	abstract bool CheckItem(Inventory item);

	// The following functions will only run if CheckItem returned true
	virtual void Tick(HCStatusbar sb) {}
	virtual void DrawHUDStuff(HCStatusbar sb, Inventory item, int hdFlags, int gzFlags) {}
}
