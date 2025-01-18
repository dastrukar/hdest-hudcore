HUDCORE_INIT_OVERRIDE = 'override void Init(HCStatusbar sb)'
HUDCORE_DRAW_OVERRIDE = 'override void DrawHUDStuff(HCStatusbar sb, int state, double ticFrac)'

ALWAYS_CONDITION = '(!CheckAlwaysStuff(sb, state, ticFrac))'
COMMON_CONDITION = '(CheckCommonStuff(sb, state, ticFrac))'
