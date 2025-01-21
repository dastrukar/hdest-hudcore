from pathlib import Path
from .base import HUDModule, generate_init_code, generate_alwaysif_code
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
		return '\n'.join([
			'// Why is this part of the statusbar?',
			'// Oh well.',
			'class HUDSetWeaponDefault : HUDElement',
			'{',
			generate_init_code(0, 'setweapondefault'),
			'',
			f'	{constants.HUDCORE_DRAW_OVERRIDE}',
			'	{',
			generate_alwaysif_code(),
			'',
			match,
			'	}',
			'}',
		])

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
		return '\n'.join([
			'class HUDItemOverlays : HUDItemOverrides',
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
			generate_alwaysif_code(),
			'',
			match,
			'	}',
			'}',
		])
