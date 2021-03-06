# -*- coding: utf-8 -*-
#!/usr/bin/ruby

# @title Rsensors module
# A module to provide info about system temperatures, and cronify and triggers if conditions are fulfilled
# Available submodules:
# Sensor : Return all requested info from system sensors: CPU(s) and hard disk(s) temperatures
# Notification : Launch temperature notification on GUI and console text
# Cronify : Schedule notification by a crontab on selected conditions and limits

#Gem name 	Require statement 	Main class or module
#rsensors 	require 'libnotify' 	Rsensors
# more info Rsensors = Ruby Sensors https://github.com/jacob-mf/rsensors
# @version 0.2.945 @date 19-2-2020  # 0.2.8  @date 15-3-2018
# @author Luis Jacob Mariscal Fernández
 # Currently works/tests only over Linux, on kernel above 3

require 'libnotify'

module Rsensors
  # Temperature Sensor interface.

  module Sensor
    # == Returns:
    # A float value of the system's temperature (one CPU value available)
    # @param void
	# @return [Float] cpu temperature or [False] if not available
	# @raise none
	# @advice good to check other sources on next developments
    def self.temperature1
     if File.exists?('/sys/class/hwmon/hwmon0/temp1_input')
      File.read('/sys/class/hwmon/hwmon0/temp1_input').to_f / 1000
     else false
     end
    end
    def self.temperature2
     if File.exists?('/sys/class/hwmon/hwmon0/device/temp2_input')
      File.read('/sys/class/hwmon/hwmon0/device/temp2_input').to_f / 1000
     elsif  File.exists?('/sys/class/hwmon/hwmon0/temp2_input')
      File.read('/sys/class/hwmon/hwmon0/temp2_input').to_f / 1000
     else false
     end
    end
    def self.temperature4
     if File.exists?('/sys/class/hwmon/hwmon0/device/temp4_input')
      File.read('/sys/class/hwmon/hwmon0/device/temp4_input').to_f / 1000
     elsif File.exists?('/sys/class/hwmon/hwmon0/temp4_input')
      File.read('/sys/class/hwmon/hwmon0/temp4_input').to_f / 1000 
     else false
     end
    end
    def self.temperature_hd # need superuser or privileges with apps
     # 1st try hddtemp
     temp =  %x( hddtemp -uC /dev/?d? )
     if $?.exitstatus != 0 # hddtemp not works, try hdparm
		temp = %x( hdparm -Hi /dev/?d? )
		temp = format_hdparm(temp) if $?.exitstatus == 0 # works fine
     end   #dtemp -n /dev/?d? ) # good for one line, one hard disk
     return temp
    end
    def self.format_hdparm(text)
     sol = ""
     text.each_line { |line|
      if /^\/dev/.match(line)  # hard disk detected
       sol[0] += line
      elsif /^ drive temperature/.match(line) # info detected
       sol += line
      elsif /^ Model=(\w+),*/.match(line) # model detected
       m1 = /^ Model=(\w+\s+\w+),*/.match(line)
       #p m1
       sol += m1[1]
      end
     }
     return sol # return
    end
    def self.temperatureHd # return float of hd temperature or array if more disk(s) present
     # need superuser or privileges with apps
     # 1st try hddtemp, temp = -20 error temp
     temp = -20
     temp =  %x( hddtemp -n /dev/?d? )
     if $?.exitstatus != 0 # hddtemp not works, try hdparm
		temp = %x( hdparm -H /dev/?d? )
		temp = formatHdparm(temp) if $?.exitstatus == 0 # works fine
     else # hddtemp ok
       temp = formatHddtemp(temp) if temp.is_a? Array
     end
     return temp if temp.is_a? Array
     return temp.to_f
    end
    def self.hdparmInfoOk(line)
      /^ drive temperature \(celsius\) is:\s+(d+)/.match(line) # info detected
    end
    def self.hdparmProblem(line)
      /^SG_IO: bad\/missing sense data/.match(line) # sense problem detected
    end
    def self.hdDetect(line)
      return /^\/dev/.match(line)  # hard disk detected 
    end
    def self.hdParmOutput(sol)
     return sol[0].to_f if sol.size == 1
	 return sol
    end
    def self.hdparmLine(line, ol, ok_sense)
      if hdDetect(line)
          ok_sense = true # activate sense
      elsif m1= hdParmInfoOk(line) # info detected
          sol << m1[1] if ok_sense
      elsif hdparmProblem(line) # sense problem detected
          ok_sense = false
      end
      return sol, ok_sense
    end
    def self.formatHdparm(entry)
	  sol = []
	  ok_sense = true
	  entry.each_line { |line|
	    sol, ok_sense = hdparmLine(line,sol,ok_sense)
              }
	  hdParmOutput(sol)
	end
    def self.formatHddtemp(entry)
	 sol = []
	 entry.each_line { |line|
     if m1 = /\w+(\/?d?\/):(\w+) not available/.match(line)  # error detected
      puts "**warning** drive /dev/#{m1[1]} sensor not available"
     elsif m1 = /^(d+)/.match(line) # info detected
       sol << m1[1]
     end
     }
	 return sol[0].to_f if sol.size == 1
	 return sol
    end
    def self.maxTemperatureHd
      temp = temperatureHd  # float or array of temperatures
      return temp if temp.is_a? Float
      return temp.max # return max temp from available hard disks 
    end
    def self.temperature
     if temperature1
      return temperature1
     elsif temperature2
      return temperature2
     elsif temperature4
      return temperature4
     else return 0 # to perform float test, give a correct answer
     end
    end
  end

  # Uses system notification to notify of current temperature.
  # Currently works/tested only on Linux
  module Notification
	def self.create_notification()
	 return Libnotify.new(
       summary: 'Temperature',
       timeout: 2.5,
       append: true
       )
	end
	def self.text4cores(t2, t4, t_hd)
	  return "Your computer's temperature is now:\n Core 2 #{t2} °C, Core 4: #{t4} °C\n Average temperature: #{(t4+t2)/2} °C\n" + t_hd
	end
	def self.text1cpu(t, t_hd)
	  return "Your computer's temperature is now: #{t} °C\n" + t_hd
	end
	def self.textHdOnly(t_hd)
	  return "Your computer's temperature is currently unknown by this app, sorry. Wait for a brilliant update. Peace\n" + temp_hd
	end
	def self.notifyOutput(n)
	  puts n.body #sentence # check exit, now nothing on console
      puts "URGENT!" if n.urgency == :critical
      puts "Normal temperatures" if n.urgency == :normal
      n.show!
    end
    def self.notifyInit
      return Sensor.temperature1, Sensor.temperature2, Sensor.temperature4, Sensor.temperature_hd, create_notification()
    end
    def self.notify(max_temp_cpu = 77, max_temp_hd = 46) # optional max_temperature CPU hard disk values
      # change to multiple assignation
      temp, temp2, temp4, temp_hd, n = notifyInit
      n.urgency = Sensor.maxTemperatureHd > max_temp_hd ? :critical : :normal # temp_hd[1] store number
      if temp2 && temp4
       n.body = text4cores(temp2, temp4, temp_hd) #code climate refactor
       n.urgency = temp2 > max_temp_cpu ? :critical : :normal
       n.urgency = temp4 > max_temp_cpu ? :critical : :normal
      elsif temp
        n.body = text1cpu(temp, temp_hd)
        n.urgency = temp > max_temp ? :critical : :normal
      else
         n.body = textHdOnly(temp_hd) 
      end
	  notifyOutput(n)
      exit (0)
    end
  end

  # Module to write the cronjob
  module Cronify
    # Tries to write the crontab and exits with the appropiate code
    # you can edit the file with command  $ crontab -e
    def self.schedule(max_cpu = 76, max_hd = 44, cron_value = "22,44 * * * *") # first cron_value = 0,10,20,30,40,50 * * * *
      cron = <<-END.gsub(/^ {8}/, '')  # Heredoc try
        # Rsensors temperature notification
        #{cron_value} /bin/bash -l -c 'rsensors job #{max_cpu} #{max_hd}'
        # End Rsensors temperature notification
      END

      require 'tempfile'
      file = Tempfile.new('temp_cronfile')
      file.write(cron)
      file.close

      run(file)
    end

    def self.run(file)
      if system("crontab #{file.path}")
        puts 'INFO: Wrote rsensors on the crontab file'
        file.unlink
        exit(0)
      else
        warn 'ERROR: Failed to write rsensors on crontab'
        file.unlink
        exit(1)
      end
    end

    def self.reset
	  if system("crontab -r")
		 puts 'INFO: Erase rsensors on the crontab file'
		 file.unlink
		 exit(0)
	  else
		 warn 'ERROR: Failed to delete rsensors on crontab'
		 file.unlink
		 exit(1)
      end
    end
  end
end
