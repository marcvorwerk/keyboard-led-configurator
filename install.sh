#!/usr/bin/env bash


set -euo pipefail


UDEV_RULES_DEST_DIR="/etc/udev/rules.d"
UDEV_RULES="udev_rules/99_custom_keyboard_*.rules"


if [ "$EUID" -ne 0 ]
then
    echo "Please run as root"
    exit 1
fi


read -p "Color: " KEYBOARD_LED_COLOR


if [[ -z ${KEYBOARD_LED_COLOR} ]]
then
    echo "KEYBOARD_LED_COLOR var not set" exit 1
fi


echo "Installing led control script"

install --mode 777 --owner root swich_keyboard_led.sh /usr/local/bin/

echo "Installing UDEV rules..."
echo ${UDEV_RULES}

for file in $UDEV_RULES
do
    install --mode 644 --owner root $file ${UDEV_RULES_DEST_DIR}
done

sed "s/<COLOR>/${KEYBOARD_LED_COLOR}/g" -i ${UDEV_RULES_DEST_DIR}/99_custom_keyboard_*.rules
udevadm control --reload-rules

exit 0
