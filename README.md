# Rsensors
[![Code Climate](https://codeclimate.com/github/jacob-mf/rsensors.png)](https://codeclimate.com/github/jacob-mf/rsensors)
[![Gem Version](https://badge.fury.io/rb/rsensors.svg)](http://badge.fury.io/rb/rsensors)

>Rsensors is a simple Ruby app to notify CPUs and hard disks temperatures

It's distributed as a Ruby gem to notify your computer's and hard disks temperature using the system's
notifications. Mind that hard disks commands may need admin privileges or run as superuser
So the following command could fix the problem to use the ''hddtemp'' program without
superuser privileges:
$ chmod u+s /usr/sbin/hddtemp
 
```bash
$ gem install rsensors
$ rsensors          # It will notify you of your computer's temperature
$ rsensors schedule # it will add a crontab task that will be active when the
                 # computer's and/or hard disks temperatures are too high
```

Tested on Fujitsu Lifebook E-750, Toshiba Tecra A-11 laptops with:
 * **Ubuntu 14.04** - Cinnamon
 * **Guadalinex 9 rc2** - Cinnamon
 * **Mint 19.3 Tricia** - Cinnamon, Fluxbox (no system notification)
 * **GParted 3.5.3** - 25-12-12 - Lxde
 * So it looks like is working good on Linux kernel above version 3
 
By now check following files for CPU & cores temperatures:
 * /sys/class/hwmon/hwmon0/temp1_input -> CPU
 * /sys/class/hwmon/hwmon0/device/temp2_input OR  /sys/class/hwmon0/temp2_input -> Core 2
 * /sys/class/hwmon/hwmon0/device/temp4_input OR  /sys/class/hwmon0/temp2_input -> Core 4
 
Uses (required):
 * [Ruby](https://www.ruby-lang.org) version >= 2.0
 * [libnotify](https://github.com/splattael/libnotify) - Ruby bindings
   for libnotify.
 * [hddtemp](https://linux.die.net/man/8/hddtemp) - Hddtemp as first
   choice for check hard disk(s) temperatures
 * [hdparm](https://linux.die.net/man/8/hdparm) - Hdparm as second
   choice for hard disk(s) check     
