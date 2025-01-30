from .base import HUDModule
from .file_io import write_to_file
from . import constants
import re

class HCInitVariables(HUDModule):
	@property
	def class_name(self):
		return 'HCStatusbar_InitVariables'

	@property
	def search_category(self):
		return 'common'

	@property
	def search_pattern(self):
		return r'^\t\tint mxht.*?\t\tint mhht.*?$'

	def generate(self, match):
		write_to_file(constants.HUDCORE_ZSCRIPT_PATH, self, '\n'.join([
			f'extend class HCStatusbar',
			'{',
			'	private void InitVariables()',
			'	{',
			re.sub(r'sb.', '', re.sub(r'int ', '', match)),
			'	}',
			'}',
		]))


class HCSuperDraw(HUDModule):
	@property
	def class_name(self):
		return 'HCStatusbar_SuperDraw'

	@property
	def search_category(self):
		return 'draw'

	@property
	def search_pattern(self):
		# TODO: check if inventorytics is actually required for anything
		return r'^\t\tcplayer.inventorytics.*?drawmypos.*?$'

	def generate(self, match):
		write_to_file(constants.HUDCORE_ZSCRIPT_PATH, self, '\n'.join([
			f'extend class HCStatusbar',
			'{',
			'	private void SuperDraw(int state, double ticFrac)',
			'	{',
			re.sub(r'if.*?Drawtip', 'drawtip', # always draw tips
				re.sub(r'sb.', '',
					re.sub(r'^\t\tif\(automapactive.*?^\t\t}$', '', match, flags=re.MULTILINE | re.DOTALL)
				)
			),
			'	}',
			'}',
		]))
