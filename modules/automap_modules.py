from .base import HUDModule
from .file_io import write_to_file_if_not_exists, insert_to_file
from .generators import generate_init_code
from . import constants

# this is separated into two parts, see common_modules.py
class HUDFragsModule(HUDModule):
	@property
	def class_name(self):
		return 'HUDFrags'

	@property
	def search_category(self):
		return 'automap'

	@property
	def search_pattern(self):
		return r'^\t\t//frags.*?^\t\t\);$'

	def generate(self, match):
		write_to_file_if_not_exists(constants.HUDCORE_MODULES_PATH, self, constants.HUDFRAGS_HEADERCODE + constants.HUDFRAGS_ENDCODE)
		insert_to_file(constants.HUDCORE_MODULES_PATH, self, constants.HUDFRAGS_HEADERCODE, constants.HUDFRAGS_ENDCODE, '\n'.join([
			f'		if {constants.AUTOMAP_CONDITION}',
			'		{',
			match.replace('\t\t', '\t\t\t'),
			'		}',
		]))
