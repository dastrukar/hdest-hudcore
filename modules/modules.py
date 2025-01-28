from . import always_modules
from . import core_modules
from . import common_modules
from . import automap_modules

MODULES = (
	core_modules.HCInitVariables(),
	core_modules.HCSuperDraw(),
	always_modules.HUDSetWeaponDefaultModule(),
	always_modules.HUDItemOverlaysModule(),
	always_modules.HUDWeaponTextModule(),
	automap_modules.HUDFragsModule(),
	common_modules.HUDFragsModule(),
)
