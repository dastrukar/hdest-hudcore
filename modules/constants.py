from pathlib import Path

HDEST_ZSCRIPT_PATH = Path('.', 'hideousdestructor', 'zscript')
HUDCORE_ZSCRIPT_PATH = Path('.', 'zscript')
HUDCORE_MODULES_PATH = Path(HUDCORE_ZSCRIPT_PATH, 'modules')

HUDCORE_INIT_OVERRIDE = 'override void Init(HCStatusbar sb)'
HUDCORE_DRAW_OVERRIDE = 'override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)'

ALWAYS_CONDITION = '(!CheckAlwaysStuff(sb, state, ticFrac))'
COMMON_CONDITION = '(CheckCommonStuff(sb, state, ticFrac))'

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
