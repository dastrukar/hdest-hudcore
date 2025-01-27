from .base import HUDModule, write_to_file, generate_init_code
from . import constants
import re

class HUDInitVariablesModule(HUDModule):
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
