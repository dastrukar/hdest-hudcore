from pathlib import Path
from .generators import generate_init_code

HDEST_ZSCRIPT_PATH = Path('.', 'hideousdestructor', 'zscript')
HUDCORE_ZSCRIPT_PATH = Path('.', 'zscript')
HUDCORE_MODULES_PATH = Path(HUDCORE_ZSCRIPT_PATH, 'modules')

HUDCORE_INIT_OVERRIDE = 'override void Init(HCStatusbar sb)'
HUDCORE_DRAW_OVERRIDE = 'override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)'

ALWAYS_CONDITION = '(!CheckAlwaysStuff(sb, state, ticFrac))'
COMMON_CONDITION = '(CheckCommonStuff(sb, state, ticFrac))'
AUTOMAP_CONDITION = '(AutomapActive)'

ALWAYSIF_CODE = '\n'.join([
	f'		if {ALWAYS_CONDITION}',
	'			return;',
])
CHECKSPECTATOR_CODE = '\n'.join([
	'		if (HDSpectator(sb.hpl))',
	'			return;',
])
SETSIZE_CODE = '\n'.join([
	'		sb.SetSize(0, 320, 200);',
	'		sb.BeginHUD(forceScaled: false);',
])

# newline added at the end because i can't be arsed to write code to handle it lol
GENERIC_ENDCODE = '\n'.join([
	'	}',
	'}',
	'',
])

HUDFRAGS_HEADERCODE = '\n'.join([
	'class HUDFrags : HUDElement',
	'{',
	generate_init_code(0, 'frags'),
	'',
	f'	{HUDCORE_DRAW_OVERRIDE}',
	'	{',
	'',
])
HUDFRAGS_ENDCODE = GENERIC_ENDCODE
