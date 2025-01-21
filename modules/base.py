from pathlib import Path
from abc import ABC, abstractmethod
from . import constants
import re

# NOTE: search_pattern is checked line by line, not the entire file at once

class HUDModule(ABC):
	@property
	@abstractmethod
	def class_name(self):
		return 'classname'

	@property
	@abstractmethod
	def search_category(self):
		return 'categoryname'

	@property
	@abstractmethod
	def search_pattern(self):
		return r''

	@abstractmethod
	def generate(self, match):
		pass

class HUDCategory(ABC):
	@property
	@abstractmethod
	def category_name(self):
		return 'categoryname'

	@property
	@abstractmethod
	def search_pattern(self):
		return r''

	# can only read files in 'hideousdestructor/zscript'
	@property
	@abstractmethod
	def source_file(self):
		return 'filename.zs'

# the following are module helper functions
def write_to_file(dir, module, text):
	Path(dir, f'{module.class_name}.zs').write_text(text + '\n')

def generate_init_code(z_layer, namespace):
	return '\n'.join([
		'	override void Init(HCStatusbar sb)',
		'	{',
		f'		ZLayer = {z_layer};',
		f'		Namespace = "{namespace}";',
		'	}',
	])

def generate_alwaysif_code():
	return '\n'.join([
		f'		if {constants.ALWAYS_CONDITION}',
		'			return;',
	])

def generate_checkspectator_code():
	return '\n'.join([
		'		if (HDSpectator(sb.hpl))',
		'			return;',
	])

