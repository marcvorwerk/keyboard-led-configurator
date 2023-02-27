# Introduction

The Keyboard LED Configurator is my simple tool to switch the keyboard led color based on my currently used laptop.
Currently i work at home and share my keyboard between my work and private laptop. To distinguish betwenn both laptops, i 

To distinguish which laptop I use, I change the led color based on a UDEV rule.


# Requirements

* APT: openrgb


# Installation

To use the Keyboard LED Configurator, clone the repository to your local machine using the following command:

```bash
git clone https://github.com/username/keyboard-led-configurator.git
cd keyboard-led-configurator
(sudo) ./install.sh
```


# Upgrade

To upgrade the swich_keyboard_led.sh script and the udev rules it's enough to run the ./install.sh script again.


# Supported Keyboard Models

The Keyboard LED Configurator currently supports the following keyboard models:

* Ducky One 2 RGB TKL


# Future Work

* Add support for other Devices like Mouse, Cooler, usw
* Reduce script runtime
* Add OpenRGB Profile Support


# License

The Keyboard LED Configurator is licensed under the MIT license. See LICENSE for more information.
