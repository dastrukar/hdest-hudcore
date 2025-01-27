from .base import HUDCategory

class HUDDrawCategory(HUDCategory):
	@property
	def category_name(self):
		return 'draw'

	@property
	def search_pattern(self):
		return r'^	override void Draw.*?^	}'

	@property
	def source_file(self):
		return 'statusbar.zs'

class HUDAutomapCategory(HUDCategory):
	@property
	def category_name(self):
		return 'automap'

	@property
	def search_pattern(self):
		return r'^	void DrawAutomapStuff.*?^	}'

	@property
	def source_file(self):
		return 'statusbar.zs'

class HUDAlwaysCategory(HUDCategory):
	@property
	def category_name(self):
		return 'always'

	@property
	def search_pattern(self):
		return r'^	void DrawAlwaysStuff.*?^	}'

	@property
	def source_file(self):
		return 'statusbar.zs'

class HUDCommonCategory(HUDCategory):
	@property
	def category_name(self):
		return 'common'

	@property
	def search_pattern(self):
		return r'^	void DrawCommonStuff.*?^	}'

	@property
	def source_file(self):
		return 'statusbar.zs'

class HUDCrosshairCategory(HUDCategory):
	@property
	def category_name(self):
		return 'crosshair'

	@property
	def search_pattern(self):
		return r'^	virtual void DrawHDXHair.*?^	}'

	@property
	def source_file(self):
		return 'crosshair.zs'

CATEGORIES = (
	HUDDrawCategory(),
	HUDAutomapCategory(),
	HUDAlwaysCategory(),
	HUDCommonCategory(),
	HUDCrosshairCategory(),
)
