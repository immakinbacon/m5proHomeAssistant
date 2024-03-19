#!/bin/bash
haToken="authorizationToken"
if [ $1 = "lightToggle" ]
then
	printf "~M146" | nc -n "$2" 8899
elif [ $1 = "pause" ]
then
	printf "~M25" | nc -n "$2" 8899
elif [ $1 = "resume" ]
then
	printf "~M24" | nc -n "$2" 8899
elif [ $1 = "stop" ]
then
	printf "~M26" | nc -n "$2" 8899
elif [ $1 = "home" ]
then
	printf "~G28" | nc -n "$2" 8899
elif [ $1 = "fanOn" ]
then
	printf "~M106" | nc -n "$2" 8899
elif [ $1 = "fanOff" ]
then
	printf "~M107" | nc -n "$2" 8899
elif [ $1 = "status" ]
then
	online=$(printf "^C" | nc -nv "$2" 8899 2>&1)
	if [[ "$online" == *"open"* ]]
	then
		m115=$(printf "~M115" | nc -n "$2" 8899)
		m119=$(printf "~M119" | nc -n "$2" 8899)
		m105=$(printf "~M105" | nc -n "$2" 8899)
		m27=$(printf "~M27" | nc -n "$2" 8899)
		name=$(echo "$m115" | grep "Machine Name")
		name=${name:14:-1}
		led=$(echo "$m119" | grep "LED")
		currentFile=$(echo "$m119" | grep "CurrentFile")
		machineStatus=$(echo "$m119" | grep "MachineStatus" | tr "[:upper:]" "[:lower:]" | tr '_' ' ')
		filamentDetected=$(echo "$m119" | grep "^Status" | sed -e 's/.*S:\(.*\)\ L.*/\1/')
		extruderTemp=$(echo "$m105" | grep "T0" | sed -e 's/.*T0:\([0-9]*\.[0-9]*\)\/.*/\1/')
		bedTemp=$(echo "$m105" | grep "T0" | sed -e 's/.*B:\([0-9]*\.[0-9]*\)\/.*/\1/')
		progress=$(echo "$m27" | grep "SD printing byte" | sed -e 's/.* \([0-9]*\).*/\1/')
		layer=$(echo "$m27" | grep "Layer" | sed -e 's/.* \(.*\).*/\1/')
		currentLayer=$(echo "$layer" | cut -d"/" -f1 | xargs)
		totalLayer=$(echo "$layer" | cut -d"/" -f2 | xargs)
		if [ ${led:5:-1} = "1" ]
		then
			led="on"
		else
			led="off"
		fi
		if [ $filamentDetected = "1" ]
		then
			filamentDetected="on"
		else
			filamentDetected="off"
		fi
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_text.""$name""name" -d "{\"state\":\"$name\"}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_boolean.""$name""led" -d "{\"state\":\"$led\"}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_text.""$name""currentfile" -d "{\"state\":\"${currentFile:12:-1}\"}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_text.""$name""machinestatus" -d "{\"state\":\"${machineStatus:14:-1}\"}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_boolean.""$name""filamentDetected" -d "{\"state\":\"$filamentDetected\"}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_number.""$name""extrudertemp" -d "{\"state\":$extruderTemp}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_number.""$name""bedtemp" -d "{\"state\":$bedTemp}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_number.""$name""progress" -d "{\"state\":$progress}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_number.""$name""currentlayer" -d "{\"state\":$currentLayer}"
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_number.""$name""totallayer" -d "{\"state\":$totalLayer}"
	else
		curl -H "Content-Type: application/json" -H "Authorization: Bearer $haToken" -X POST "http://localhost:8123/api/states/input_text.""$name""machinestatus" -d "{\"state\":\"offline\"}"
	fi
fi
