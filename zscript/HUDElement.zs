// Each class that derives from this will be used in HCStatusbar.
class HUDElement ui abstract
{
	int ZLayer;
	string Namespace;

	virtual void Init(HCStatusbar sb)
	{
		ZLayer = 0;

		// Every HUDElement has a namespace. If they don't have one, it won't be added to the HUD. (might reconsider this)
		// If another HUDElement has the same namespace, they'll overwrite each other.
		Namespace = "";
	}

	virtual void Tick(HCStatusbar sb) {}

	virtual void DrawHUDStuff(HCStatusbar sb) {}
}
