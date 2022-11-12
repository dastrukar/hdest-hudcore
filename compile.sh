#!/bin/bash

statusbarPath="hideousdestructor/zscript/statusbar.zs"

source modules.sh

# Clear files
echo "Removing files..."
rm -rfv zscript/HCStatusbar_*
rm -rfv zscript/modules/*

# Make sure the submodule is up to date
echo "Looking for HDest submodule..."
if [[ ! -d "hideousdestructor" ]]
then
	echo "No HDest submodule found!"
	echo "Please run 'git submodule update --init' to initialise the submodule."
	echo "Then, checkout to your preferred commit/version and compile again."
	exit
fi
echo "Found HDest submodule..."

# Split by lines
IFS="
"


# Categories
category=""
startOfAutomapStuff='^	void DrawAutomapStuff()'
endOfCategory='^	\}'
startOfCommonStuff='^	void DrawCommonStuff()'

module=""
ignore="false"

# Get init stuff
printf "${InitHeader}" >> ${InitFile}

function SearchLine() # 1: regex   2: string
{
	grep -E "${1}" <<< "${2}"
}

function ProcessLine() # 1: string
{
	line=${1}

	# Could this be more efficient?
	# Probably.

	# Add access to HDStatusbar variables
	line=$(sed -E 's/hpl/sb.hpl/gi' <<< "${line}")
	line=$(sed -E 's/cplayer/sb.cplayer/gi' <<< "${line}")
	line=$(sed -E 's/fill/sb.fill/gi' <<< "${line}")
	line=$(sed -E 's/hud_/sb.hud_/gi' <<< "${line}")
	line=$(sed -E 's/draw/sb.draw/gi' <<< "${line}")
	line=$(sed -E 's/hd_/sb.hd_/gi' <<< "${line}")
	line=$(sed -E 's/sb\.hd_debug/hd_debug/gi' <<< "${line}")
	line=$(sed -E 's/sbcolour/sb.sbcolour/gi' <<< "${line}")
	line=$(sed -E 's/DI_/sb.DI_/gi' <<< "${line}")
	line=$(sed -E 's/pnew/sb.pnew/gi' <<< "${line}")
	line=$(sed -E 's/FormatNumber/sb.FormatNumber/gi' <<< "${line}")
	line=$(sed -E 's/blurred/sb.blurred/gi' <<< "${line}")
	line=$(sed -E 's/GetMug/sb.GetMug/gi' <<< "${line}")
	line=$(sed -E 's/usemughud/sb.usemughud/gi' <<< "${line}")
	line=$(sed -E 's/mHUDFont/sb.mHUDFont/gi' <<< "${line}")
	line=$(sed -E 's/hudlevel/sb.hudlevel/gi' <<< "${line}")

	# Fix some mistakes
	line=$(sed -E 's/sb\.hd_hudsprite/hd_hudsprite/gi' <<< "${line}")
	line=$(sed -E 's/_sb\./_/gi' <<< "${line}")

	# Alternative variables :]
	line=$(sed -E 's/mxht/sb.mxht/gi' <<< "${line}")
	line=$(sed -E 's/mhht/sb.mhht/gi' <<< "${line}")

	printf ${line}
}

function FindInitVariables() # 1: string
{
	for var in ${InitVariables}
	do
		if [[ $(SearchLine "${var}" "${1}") != "" ]]
		then
			printf "true"
			continue
		fi
	done
}

function TryCloseModule() # 1: category
{
	if [[ "${1}" == "common" ]]
	then
		printf "${GenericEnd}"
	fi
}

function ConditionalPrintF() # 1: category   2: automapString   3: commonString
{
	if [[ "${1}" == "automap" ]]
	then
		printf "${2}"

	else
		printf "${3}"
	fi
}

function GenericChecker() # 1: module   2: searchLine   3: string
{
	if [[ "${module}" == "${1}" || $(SearchLine "${2}" "${3}") != "" ]]
	then
		printf "true"
	fi
}

for i in $(cat "${statusbarPath}")
do
	##
	## Categories
	##
	# Automap category
	if [[ $(SearchLine "${startOfAutomapStuff}" "${i}") != "" ]]
	then
		echo "Category: Automap"
		category="automap"
		continue
	fi

	# Common category
	if [[ $(SearchLine "${startOfCommonStuff}" "${i}") != "" ]]
	then
		echo "Category: Common"
		category="common"
		continue
	fi

	##
	## Core stuff
	##
	# Init variables
	if [[ $(FindInitVariables ${i}) != "" ]]
	then
		echo "Found init variable: ${i}"
		line=$(sed -e 's/^		int /		/' <<< "${i}")
		line=$(sed -e 's/^		bool /		/' <<< "${i}")
		printf "${line}\n" >> ${InitFile}
		continue
	fi

	# Draw functions
	if [[ $(GenericChecker "draw" "${StartOfDraw}" "${i}") == "true" ]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Core: Draw"
			module="draw"
			printf "${DrawHeader}" >> ${DrawFile}
			continue
		fi

		if [[ $(SearchLine "${EndOfDraw}" "${i}") != "" ]]
		then
			module=""
			printf "${GenericEnd}" >> ${DrawFile}
			continue
		fi

		line="${i}"
		# Always draw tips
		line=$(sed -E 's/if\(hpl\.health<1\)drawtip/drawtip/gi' <<< "${line}")
		printf "${line}\n" >> ${DrawFile}
	fi

	##
	## Modules
	##
	# Frags
	if [[ $(GenericChecker "frags" "${StartOfFrags}" "${i}") == "true" ]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: Frags"
			module="frags"
			ConditionalPrintF "${category}" "${FragsHeader}" "${CommonElse}" >> ${FragsFile}
		fi

		ProcessLine "	${i}\n" >> ${FragsFile}
		if [[ $(SearchLine "${EndOfFrags}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${FragsFile}
			TryCloseModule "${category}" >> ${FragsFile}
		fi
	fi

	# Keys
	if [[ $(GenericChecker "keys" "${StartOfKeys}" "${i}") == "true" ]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: Keys"
			module="keys"
			ConditionalPrintF "${category}" "${KeysHeader}" "${CommonElse}" >> ${KeysFile}
		fi

		if [[ "${category}" == "common" && $(SearchLine "${StartOfEKG}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${KeysFile}
			TryCloseModule "${category}" >> ${KeysFile}
		else
			ProcessLine "	${i}\n" >> ${KeysFile}
		fi

		if [[ "${category}" == "automap" && $(SearchLine "${EndOfKeys}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${KeysFile}
		fi
	fi

	# Inventory
	if [[ $(GenericChecker "inventory" "${StartOfInventory}" "${i}") == "true" ]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: Inventory"
			module="inventory"
			ConditionalPrintF "${category}" "${InventoryHeader}" "${CommonElse}" >> ${InventoryFile}
		fi

		ProcessLine "	${i}\n" >> ${InventoryFile}
		if [[ $(SearchLine "${EndOfInventory}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${InventoryFile}
			TryCloseModule "${category}" >> ${InventoryFile}
		fi
	fi

	# Heartbeat Monitor
	if [[ $(GenericChecker "heartbeat" "${StartOfHeartbeat}" "${i}") == "true" ]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: Heartbeat"
			module="heartbeat"
			ConditionalPrintF "${category}" "${HeartbeatHeader}" "${CommonElse}" >> ${HeartbeatFile}
		fi

		ProcessLine "	${i}\n" >> ${HeartbeatFile}
		if [[ $(SearchLine "${EndOfHeartbeat}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${HeartbeatFile}
			TryCloseModule "${category}" >> ${HeartbeatFile}
		fi
	fi

	# EKG
	if [[ $(GenericChecker "ekg" "${StartOfEKG}" "${i}") == "true" ]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: EKG"
			module="ekg"
			ConditionalPrintF "${category}" "${EKGHeader}" "${CommonElse}" >> ${EKGFile}
		fi

		ProcessLine "	${i}\n" >> ${EKGFile}
		if [[ $(SearchLine "${EndOfEKG}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${EKGFile}
			TryCloseModule "${category}" >> ${EKGFile}
		fi
	fi

	# Mugshot
	if [[
		$(GenericChecker "mugshot" "${StartOfMugshot1}" "${i}") == "true"
		|| $(GenericChecker "mugshot" "${StartOfMugshot2}" "${i}") == "true"
	]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: Mugshot"
			module="mugshot"
			ConditionalPrintF "${category}" "${MugshotHeader}" "${CommonElse}" >> ${MugshotFile}
		fi

		ProcessLine "	${i}\n" >> ${MugshotFile}
		if [[ $(SearchLine "${EndOfMugshot1}" "${i}") != "" || $(SearchLine "${EndOfMugshot2}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${MugshotFile}
			TryCloseModule "${category}" >> ${MugshotFile}
		fi
	fi

	# ItemAdditions
	if [[ $(GenericChecker "itemadditions" "${StartOfItemAdditions}" "${i}") == "true" ]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: ItemAdditions"
			module="itemadditions"
			ConditionalPrintF "${category}" "${ItemAdditionsHeader}" "${CommonElse}" >> ${ItemAdditionsFile}
		fi

		ProcessLine "	${i}\n" >> ${ItemAdditionsFile}
		if [[
			("${category}" == "automap" && $(SearchLine "${EndOfItemAdditions1}" "${i}") != "")
			|| ("${category}" == "common" && $(SearchLine "${EndOfItemAdditions2}" "${i}") != "")
		]]
		then
			module=""
			printf "		}\n" >> ${ItemAdditionsFile}
			TryCloseModule "${category}" >> ${ItemAdditionsFile}
		fi
	fi

	# WeaponStatus
	if [[ $(GenericChecker "weaponstatus" "${StartOfWeaponStatus}" "${i}") == "true" ]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: WeaponStatus"
			module="weaponstatus"
			printf "${WeaponStatusHeader}" >> ${WeaponStatusFile}
		fi

		ProcessLine "	${i}\n" >> ${WeaponStatusFile}
		if [[ $(SearchLine "${EndOfWeaponStatus}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${WeaponStatusFile}
			TryCloseModule "${category}" >> ${WeaponStatusFile}
		fi
	fi

	# WeaponSprite
	if [[
		$(GenericChecker "weaponsprite" "${StartOfWeaponSprite1}" "${i}") == "true"
		|| $(GenericChecker "weaponsprite" "${StartOfWeaponSprite2}" "${i}") == "true"
	]]
	then
		if [[ "${module}" == "" ]]
		then
			echo "Adding Module: WeaponSprite"
			module="weaponsprite"
			ConditionalPrintF "${category}" "${WeaponSpriteHeader}" "${CommonElse}" >> ${WeaponSpriteFile}
		fi

		ProcessLine "	${i}\n" >> ${WeaponSpriteFile}
		if [[ $(SearchLine "${EndOfWeaponSprite}" "${i}") != "" ]]
		then
			module=""
			printf "		}\n" >> ${WeaponSpriteFile}
			TryCloseModule "${category}" >> ${WeaponSpriteFile}
		fi
	fi

	# WeaponStash
	if [[ $(GenericChecker "weaponstash" "${RegexOfWeaponStash}" "${i}") == "true" ]]
	then
		echo "Adding Module: WeaponStash"
		ConditionalPrintF "${category}" "${WeaponStashHeader}" "${WeaponStashElse}" >> ${WeaponStashFile}

		ProcessLine $(ConditionalPrintF "${category}" "	${i}\n" "${i}\n") >> ${WeaponStashFile}
		printf "		}\n" >> ${WeaponStashFile}
		TryCloseModule "${category}" >> ${WeaponStashFile}
	fi

	# AmmoCounters
	if [[ $(GenericChecker "ammocounters" "${RegexOfAmmoCounters}" "${i}") == "true" ]]
	then
		echo "Adding Module: AmmoCounters"
		ConditionalPrintF "${category}" "${AmmoCountersHeader}" "${WeaponStashElse}" >> ${AmmoCountersFile}

		ProcessLine $(ConditionalPrintF "${category}" "	${i}\n" "${i}\n") >> ${AmmoCountersFile}
		printf "		}\n" >> ${AmmoCountersFile}
		TryCloseModule "${category}" >> ${AmmoCountersFile}
	fi
done

# Close the init file
printf "${GenericEnd}" >> ${InitFile}
