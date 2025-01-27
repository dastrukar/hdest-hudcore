from . import always_modules
from . import core_modules

MODULES = (
	core_modules.HCInitVariables(),
	core_modules.HCSuperDraw(),
	always_modules.HUDSetWeaponDefaultModule(),
	always_modules.HUDItemOverlaysModule(),
	always_modules.HUDWeaponTextModule(),
)
