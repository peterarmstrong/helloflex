# Uninstall hook code here
require 'fileutils'

# Allows you to run this script from RAILS_ROOT without using script/plugin install
RAILS_ROOT = `pwd`.chomp unless defined?(RAILS_ROOT)

%w(multiscaffold yamlscaffold).each do |script|
  path = File.join(::RAILS_ROOT, 'script', script)
  if (File.exist?(path))
    puts "removing #{script} script"
    FileUtils.rm(path)
  end
end
