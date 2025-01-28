from .base import HUDModule
from .file_io import write_to_file
from .generators import generate_init_code
from . import constants

class HUDSetWeaponDefaultModule(HUDModule):
	@property
	def class_name(self):
		return 'HUDSetWeaponDefault'

	@property
	def search_category(self):
		return 'always'

	@property
	def search_pattern(self):
		return r'^\t\t//reads hd_setweapondefault.*?if\(lomt\).*?$'

	def generate(self, match):
		write_to_file(constants.HUDCORE_MODULES_PATH, self, '\n'.join([
			'// Why is this part of the statusbar?',
			'// Oh well.',
			f'class {self.class_name} : HUDElement',
			'{',
			generate_init_code(0, 'setweapondefault'),
			'',
			f'	{constants.HUDCORE_DRAW_OVERRIDE}',
			'	{',
			constants.ALWAYSIF_CODE,
			'',
			match,
			'	}',
			'}',
		]))

class HUDItemOverlaysModule(HUDModule):
	@property
	def class_name(self):
		return 'HUDItemOverlays'

	@property
	def search_category(self):
		return 'always'

	@property
	def search_pattern(self):
		return r'^\t\t//draw item overlays.*?^\t\t}'

	def generate(self, match):
		write_to_file(constants.HUDCORE_MODULES_PATH, self, '\n'.join([
			f'class {self.class_name} : HUDItemOverrides',
			'{',
			f'	{constants.HUDCORE_INIT_OVERRIDE}',
			'	{',
			'		ZLayer = 0;',
			'		Namespace = \"itemoverlays\";',
			'		_OverrideType = HCOVERRIDETYPE_OVERLAY;',
			'',
			'		Super.Init(sb);',
			'	}',
			'',
			f'	{constants.HUDCORE_DRAW_OVERRIDE}',
			'	{',
			constants.ALWAYSIF_CODE,
			'',
			'		DrawItemHUDAdditions(sb);',
			constants.SETSIZE_CODE,
			'	}',
			'}',
		]))

class HUDWeaponTextModule(HUDModule):
	@property
	def class_name(self):
		return 'HUDWeaponText'

	@property
	def search_category(self):
		return 'always'

	@property
	def search_pattern(self):
		return r'^\t\t//draw information text.*?^\t\t\);'

	def generate(self, match):
		write_to_file(constants.HUDCORE_MODULES_PATH, self, '\n'.join([
			f'class {self.class_name} : HUDElement',
			'{',
			generate_init_code(0, 'weapontext'),
			'',
			f'	{constants.HUDCORE_DRAW_OVERRIDE}',
			'	{',
			constants.ALWAYSIF_CODE,
			'',
			match,
			constants.SETSIZE_CODE,
			'	}',
			'}',
		]))
