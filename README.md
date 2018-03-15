# Rsensors
[![Code Climate](https://codeclimate.com/github/jacob-mf/rsensors.png)](https://codeclimate.com/github/jacob-mf/rsensors)
[![Gem Version](https://badge.fury.io/rb/rsensors.svg)](http://badge.fury.io/rb/rsensors)

>Rsensors is a simple app to notify CPU and hard disk temperature

A gem to notify your computer's and hard disks temperature using the system's
notifications. Mind that hard disks commands may need priliges or run as superuser

```bash
$ gem install rsensors
$ rsensors          # Will notify you of your computer's temperature
$ rsensors schedule # Will add a crontab for notifying you when the
                 # computer's and/or hard disk temperature is too high
```

Tested on Fujitsu Lifebook E-750, Fujitsu Tecra A-11 laptops with:
 * **Ubuntu 14.04** - Cinnamon
 * **Guadalinex 9 rc2** - Cinnamon
 * **GParted  - Gnome
 * So looks is working good on Linux kernel above 3
 
By now check following files for CPU & cores temperatures:
 * /sys/class/hwmon/hwmon0/temp1_input -> CPU
 * /sys/class/hwmon/hwmon0/device/temp2_input -> Core 2
 * /sys/class/hwmon/hwmon0/device/temp4_input -> Core 4
 
Uses:
 * [libnotify](https://github.com/splattael/libnotify) - Ruby bindings
   for libnotify.
 * [hddtemp](https://linux.die.net/man/8/hddtemp) - Hddtemp as first
   choice for check hard disk(s) temperatures
 * [hdparm](https://linux.die.net/man/8/hdparm) - Hdparm as second
   choice for hard disk(s) check     
