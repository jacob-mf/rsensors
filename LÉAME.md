# Rsensors

>Rsensors es una aplicación escrita en Ruby para la notificación de las
temperaturas de las CPUs (unidades centrales de proceso) y discos duros

Se distribuye como una gema de Ruby para notificar las temperaturas del procesador
y discos duros mediante notificaciones del sistema. Tenga en cuenta que los comandos
de consulta del disco duro suelen necesitar acceso como super usuario.
El siguiente comando daría el permiso necesario para el uso de la herramienta
''hddtemp'' sin tener que pedir privilegios de superusuario cada vez:
$ chmod u+s /usr/sbin/hddtemp
Sería igual para aplicación ''hdparm''
El programa rsensors necesita al menos
una de las dos aplicaciones: 'hddtemp' o ''hdparm''
 
```bash
$ gem install rsensors
$ rsensors          # notifica las temperaturas actuales del sistema
$ rsensors schedule # añade tarea al ''crontab'' para avisar cuando las
                 # temperaturas del ordenador y/o disco duro son altas
```

Probado en portátiles Fujitsu Lifebook E-750, Toshiba Tecra A-11 con:
 * **Ubuntu 14.04** - Cinnamon
 * **Guadalinex 9 rc2** - Cinnamon
 * **GParted 3.5.3** - 25-12-12 Lxde
 * **Mint 19.3 Tricia** - Cinnamon, Fluxbox (sin notificación de sistema)
 * Así parece funcionar en Linux con versión de kernel >= 3 
 
Por ahora consulta los siguientes archivos para las temperaturas:
 * /sys/class/hwmon/hwmon0/temp1_input -> CPU
 * /sys/class/hwmon/hwmon0/device/temp2_input
 * o /sys/class/hwmon0/temp2_input  -> Núcleo 2
 * /sys/class/hwmon/hwmon0/device/temp4_input
 * o /sys/class/hwmon0/temp4_input  -> Núcleo 4
 
Dependencias:
 * [Ruby] (https://www.ruby-lang.org/) versión >= 2.0
 * [libnotify](https://github.com/splattael/libnotify) - adaptadores Ruby 
   para ''libnotify''.
 * [hddtemp](https://linux.die.net/man/8/hddtemp) - Hddtemp es la primera
   opción para la consulta de las temperaturas de disco duro
 * [hdparm](https://linux.die.net/man/8/hdparm) - Hdparm es la segunda
   elección para la consulta de disco duro     
