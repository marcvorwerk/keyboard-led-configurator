#!/usr/bin/env bash

set -e


_VERSION="0.1"
_AUTHOR="Marc Vorwerk <marc+github@marc-vorwerk.de>"


declare -A COLORS
COLORS=(
	["RED"]="FF0000"
	["BLUE"]="0000FF"
	["YELLOW"]="FFFF00"
	["GREEN"]="00FF00"
	)


DEVICE=0
MODE=direct


function show_help() {
    echo "Usage: $0 [OPTION]"
    echo "Options:"
    echo "  -h, --help           Show this help message and exit"
    echo "  -lc, --list-colors"
    echo "  -c, --color          Set Color [Red, Green, Blue, Yellow, ...)"
    echo "  -ld, --list-devices  Device ID of OpenRGB (Default: 0)"
    echo "  -d, --device         Device ID of OpenRGB (Default: 0)"
    echo "  -m, --mode           OpenRGB Mode (Default: direct)"
    echo "  -v, --version        Show version information and exit"
    exit 0
}


function show_version() {
    echo "$(echo $0 | awk -F '/' '{print $NF}') ${_VERSION}"
    echo "  Author: ${_AUTHOR}"
    echo "  License: MIT"
    exit 0
}


function check() {
    if ! command -v openrgb &> /dev/null
    then
        echo "Abort .. openrgb is not installed"
        exit 1
    fi

    if [ -z $COLOR ]
    then
        echo "ERROR: Color not given .. aborting!"
        exit 1
    fi

    col_found=false
    for col in "${!COLORS[@]}"; do
        if [ "$COLOR" == "$col" ]; then
            col_found=true
            break
        fi
    done

    if ! $col_found
    then
        echo "Color $COLOR not found ... aborting"
	exit 1
    fi
}


function list_colors() {
    echo -e "\nAvailable colors:"
    for col in "${!COLORS[@]}"
    do
        echo "  - $col"
    done
    exit 0
}


function run_openrgb() {
    openrgb ${@} | grep -v -e "Attempting to connect to local OpenRGB server." -e "i2c_smbus_linux" -e "Connection attempt failed" -e "Local OpenRGB server unavailable." -e "Running standalone."
}


function list_devices() {
    run_openrgb --list-devices
    exit 0
}


function colorize() {
run_openrgb --device $DEVICE --mode $MODE --color ${COLORS[${COLOR}]}
}

if [[ $# -eq 0 ]]; then echo "min 1 arg"; exit 1; fi
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_help
      shift
      ;;
    -v|--version)
      show_version
      shift
      ;;
    -lc|--list-colors)
      list_colors
      shift
      ;;
    -ld|--list-devices)
      list_devices
      shift
      ;;
    -c|--color)
      COLOR=${2^^}
      if [ -z "$2" ]; then echo "Error ... The $1 option requires a argument"; exit 1; fi
      shift
      shift
      ;;
    -d|--device)
      DEVICE=${2}
      if [[ -z "$2" || ! "$2" =~ ^[0-9]+$ ]]; then echo "Error ... For the option $1 is a Integer Value required"; exit 1; fi
      shift
      shift
      ;;
    -m|--mode)
      MODE=${2;;}
      if [ -z "$2" ]; then echo "Error ... The option $1 required an argument"; exit 1; fi
      shift
      shift
      ;;
    -*|--*)
      echo "Error: Unknown option: ${1}"
      echo ""
      show_help
      exit 1
      ;;
  esac
done


check
colorize


exit 0
