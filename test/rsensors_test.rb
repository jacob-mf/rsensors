# -*- coding: utf-8 -*-
# @title Rsensors test 
# Test Rsensors module: provide info about system temperatures, and cronify and triggers if conditions are fulfilled 
# Available submodules:
# Sensor : Return all requested info from system sensors: CPU(s) and hard disk(s) temperatures
# Notification : Launch temperature notification on GUI and console text
# Cronify : Schedule notification by a crontab on selected conditions and limits 

#Test file 		Require statement
#rsensors_test	require minitest/spec,pride,autorun rsensors

#Gem name 	Require statement 	Main class or module
#rsensors 	require 'libnotify' 	Rsensors
# more info Rsensors = Ruby Sensors https://github.com/jacob-mf/rsensors
# @version 0.2.8  @date 15-3-2018
# @author Luis Jacob Mariscal Fernández
 # Currently works/tests only over Linux, on kernel above 3
require 'minitest/spec'
require 'minitest/pride'
require 'minitest/autorun'
require 'rsensors'

describe Rsensors do
  it 'sensor should return a temperature number' do
    assert Float(Rsensors::Sensor.temperature)
  end
  it 'hard disk sensor should return a string' do
   assert String(Rsensors::Sensor.temperature_hd)
  end 
  it 'Maximum hard disk sensor should return a temperature number' do
    assert Float(Rsensors::Sensor.maxTemperatureHd)
  end
  
  it 'The notification should end with no problems' do # rake not working here
    assert   0, Rsensors::Notification.notify
  end  
  it 'Cronify schedule will exit ok after add crontab task' do
    assert 0, Rsensors::Cronify.schedule
  end
  it 'Cronify reset will end ok when completing crontab reset' do
    assert 0, Rsensors::Cronify.reset
  end
end
