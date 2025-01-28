from pathlib import Path

def write_to_file(dir, module, text):
	Path(dir, f'{module.class_name}.zs').write_text(text + '\n')

def write_to_file_if_not_exists(dir, module, text):
	path = Path(dir, f'{module.class_name}.zs')
	if path.exists():
		return

	path.write_text(text + '\n')

def insert_to_file(dir, module, header, end, text):
	path = Path(dir, f'{module.class_name}.zs')
	contents = path.read_text()
	# remove header and end
	if header:
		contents = contents.replace(header, '')

	if end:
		contents = contents.replace(end, '')

	# insert text at the end of contents
	contents = contents + text

	# insert newline just in case
	contents = contents + '\n'

	# re-add header and end
	if header:
		contents = header + contents

	if end:
		contents = contents + end

	path.write_text(contents)
