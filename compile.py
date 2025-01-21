#!/usr/bin/env python3

import os
from pathlib import Path
import sys
import re
from modules.categories import CATEGORIES
from modules.modules import MODULES
from modules.constants import HDEST_ZSCRIPT_PATH, HUDCORE_ZSCRIPT_PATH, HUDCORE_MODULES_PATH

def main():
	print('> Looking for HDest submodule...')
	if not HDEST_ZSCRIPT_PATH.is_dir():
		print(
			'> FATAL ERROR:',
			'> No HDest submodule found!',
			'> Please run "git submodule update --init" to initialise the submodule.',
			'> Then, checkout to your preferred commit/version and compile again.',
			sep='\n'
		)
		return 1

	print('> Found HDest submodule...')

	if not HUDCORE_ZSCRIPT_PATH.is_dir():
		print(
			'> FATAL ERROR:',
			'> Could not find HUDCore zscript directory...',
			'> Are you sure you\'re in the right directory?',
			sep='\n'
		)
		return 1

	# remove previously generated files
	print('> Removing previously generated files...')
	# for f in HUDCORE_ZSCRIPT_PATH.glob('HCStatusbar_*'):
	# 	f.unlink()

	# for f in HUDCORE_MODULES_PATH.glob('*'):
	# 	f.unlink()

	# create category contents
	source_files = {}
	source_categories = {}
	for cat in CATEGORIES:
		if cat.source_file not in source_files:
			source_files[cat.source_file] = Path(HDEST_ZSCRIPT_PATH, cat.source_file).read_text()

		source = source_files[cat.source_file]
		match = re.search(cat.search_pattern, source, flags=re.MULTILINE | re.DOTALL)
		if not match:
			print(f'> WARNING: Could not find category "{cat.category_name}".')
			continue

		print(f'> Found category "{cat.category_name}".')
		source_categories[cat.category_name] = match.group()

	# free up some memory consumption
	del source_files

	# create module files
	for mod in MODULES:
		print(f'> Creating module {mod.class_name}')
		if mod.search_category not in source_categories:
			print(f'> Failed to create module {mod.class_name}: Could not find category {mod.search_category}')
			continue

		match = re.search(mod.search_pattern, source_categories[mod.search_category], flags=re.MULTILINE | re.DOTALL)
		if not match:
			print(f'> Failed to create module {mod.class_name}: No matches with search_pattern')
			continue

		mod.generate(match.group())

if __name__ == '__main__':
	sys.exit(main())
