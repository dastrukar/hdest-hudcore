def generate_init_code(z_layer, namespace):
	return '\n'.join([
		'	override void Init(HCStatusbar sb)',
		'	{',
		f'		ZLayer = {z_layer};',
		f'		Namespace = "{namespace}";',
		'	}',
	])
