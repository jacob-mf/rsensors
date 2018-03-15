Gem::Specification.new do |s|
  s.name = 'rsensors'
  s.version = '0.2.82'
  s.date = '2018-03-15' # 1st '2017-01-21'
  s.summary = 'A gem to display system hardware temperature | Gema para mostrar la termperatura del sistema: microprocesador(es) y disco(s) duro(s)'
  s.description = 'Show a notification of your computer\'s temperature. It can be programmed as a cronjob, so you can be notified when the temperature is high | Muestra la temperatura del sistema, puede igual actuar en segundo plano para alertar de alta temperatura'
  s.authors = ['L. Jacob Mariscal Fernández']
  s.email = 'l.jacob.m.f@gmail.com'
  s.files = ['lib/rsensors.rb']
  s.homepage = 'https://github.com/jacob-mf/rsensors'
  s.licenses = ['GPL-3.0']
  s.post_install_message = "Gracias por probar la gema rsensors | Thanks for installing and trying rsensors gem"
  s.executables << 'rsensors'
  s.add_runtime_dependency 'libnotify', '~> 0.9.3'
  s.add_development_dependency 'minitest', '~> 5.3'
  s.add_development_dependency 'rubocop', '~> 0.47.1'
end
