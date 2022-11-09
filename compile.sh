#!/bin/bash

statusbarPath="hideousdestructor/zscript/statusbar.zs"
branchTag="main" # Which version do you want to use?

source modules.sh

# Clear files
echo "Removing files..."
rm -rfv zscript/HCStatusbar_*
rm -rfv zscript/modules/*

# Make sure the submodule is up to date
git submodule init
git submodule update

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
	if [[ "${module}" == "draw" || $(SearchLine "${StartOfDraw}" "${i}") != "" ]]
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

		printf "${i}\n" >> ${DrawFile}
	fi

	##
	## Modules
	##
	# Frags
	if [[ "${module}" == "frags" || $(SearchLine "${StartOfFrags}" "${i}") != "" ]]
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
	if [[ "${module}" == "keys" || $(SearchLine "${StartOfKeys}" "${i}") != "" ]]
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
	if [[ "${module}" == "inventory" || $(SearchLine "${StartOfInventory}" "${i}") != "" ]]
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
	if [[ "${module}" == "heartbeat" || $(SearchLine "${StartOfHeartbeat}" "${i}") != "" ]]
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
	if [[ "${module}" == "ekg" || $(SearchLine "${StartOfEKG}" "${i}") != "" ]]
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
		"${module}" == "mugshot"
		|| $(SearchLine "${StartOfMugshot1}" "${i}") != ""
		|| $(SearchLine "${StartOfMugshot2}" "${i}") != ""
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
done

# Close the init file
printf "${GenericEnd}" >> ${InitFile}
