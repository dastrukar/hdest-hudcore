#!/bin/bash

statusbarPath="hideousdestructor/zscript/statusbar.zs"
branchTag="main" # Which version do you want to use?

# Make sure the submodule is up to date
git submodule init
git submodule update

# Split by lines
IFS="
"

# Categories
category=""
startOfAutomapStuff="	void DrawAutomapStuff(){"
endOfCategory="	}"

# Modules
module=""
startOfHeartbeat='^		\/\/heartbeat'
endOfHeartbeat='^		}'
startOfEKG='^		\/\/health'
endOfEKG='^		);else'

function SearchLine() # 1: regex   2: string
{
	grep -E "${1}" <<< "${2}"
}

function ProcessLine() # 1: string
{
	indent="$(grep -o -E $(printf '\t')+ <<< ${1})"
	hasBracket="$(grep -o -E '{$' <<< ${1})"

	line=$(sed -E 's/{$//' <<< ${1})
	line=$(sed -E 's/hpl/sb.hpl/g' <<< "${line}" )

	echo ${line}
	if [[ "${hasBracket}" != "" ]]
	then
		printf "${indent}{"
	fi
}

for i in $(cat ${statusbarPath})
do
	##
	## Categories
	##
	# Automap category
	if [[ "$(SearchLine ${startOfAutomapStuff} ${i})" != "" ]]
	then
		category="automap"
		continue
	fi

	##
	## Modules
	##
	# Heartbeat Monitor
	if [[ "${module}" == "Heartbeat" || "$(SearchLine ${startOfHeartbeat} ${i})" != "" ]]
	then
		module="Heartbeat"
		echo "$(ProcessLine ${i})"
		if [[ "$(SearchLine ${endOfHeartbeat} ${i})" != "" ]]
		then
			module=""
			echo "		// End of Heartbeat"
		fi
	fi

	# EKG
	if [[ "${module}" == "EKG" || "$(SearchLine ${startOfEKG} ${i})" != "" ]]
	then
		module="EKG"
		echo "$(ProcessLine ${i})"
		if [[ "$(SearchLine ${endOfEKG} ${i})" != "" ]]
		then
			module=""
			echo "		// End of EKG"
		fi
	fi
done
