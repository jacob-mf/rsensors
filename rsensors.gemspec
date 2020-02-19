Gem::Specification.new do |s|
  s.name = 'rsensors'
  s.version = '0.2.94'
  s.date = '2020-02-19' # 1st '2017-01-21'
  s.summary = 'A gem to display system hardware temperatures | Gema para mostrar la termperatura del sistema: microprocesador(es) y disco(s) duro(s)'
  s.description = 'Show a notification of your computer\'s temperature. It can be programmed as a cronjob, so you can be notified when the temperature is high | Muestra la temperaturas del sistema, puede igual actuar en segundo plano para alertar de altas temperaturas'
  s.authors = ['L. Jacob Mariscal Fernández']
  s.email = 'l.jacob.m.f@gmail.com'
  s.files = ['lib/rsensors.rb']
  s.homepage = 'https://github.com/jacob-mf/rsensors'
  s.licenses = ['GPL-3.0']
  s.post_install_message = "Gracias por probar la gema rsensors | \nThanks for installing and trying the rsensors gem"
  s.executables << 'rsensors'
  s.required_ruby_version = '~> 2.0'
  s.add_runtime_dependency 'libnotify', '~> 0.9.3'
  s.add_development_dependency 'minitest', '~> 5.3'
 #ffi requires Ruby version >= 2.0.
 # s.add_development_dependency 'rubocop', '~> 0.47.1' # security warning github
end
