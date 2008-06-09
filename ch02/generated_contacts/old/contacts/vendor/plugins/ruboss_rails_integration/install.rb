# Install hook code here
require 'ftools'

# Allows you to run this script from RAILS_ROOT without using script/plugin install
RAILS_ROOT = `pwd`.chomp unless defined?(RAILS_ROOT)

puts "-----------------"
%w(multiscaffold yamlscaffold).each do |script|
  File.copy(File.dirname(__FILE__) + "/script/#{script}", RAILS_ROOT + '/script')
  File.chmod(0755, ::RAILS_ROOT + "/script/#{script}")
  puts "installing #{script} into script folder"
end

config_file = File.join(File.dirname(__FILE__), 'config', 'ruboss.yml')
target_file = File.join(::RAILS_ROOT, 'config', 'ruboss.yml')
unless File.exist?(target_file)
  File.copy(config_file, target_file)
  puts "copying ruboss.yml into config folder, customize if necessary"
end