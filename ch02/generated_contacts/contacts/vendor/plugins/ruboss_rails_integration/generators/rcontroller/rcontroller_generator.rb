##########################################################################
# Copyright 2008, Ruboss Technology Corporation.
#
# This is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License v3 as
# published by the Free Software Foundation.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License v3 for more details.
#
# You should have received a copy of the GNU General Public
# License v3 along with this software; if not, write to the Free
# Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA, or see the FSF site: http://www.fsf.org.
##########################################################################
class RcontrollerGenerator < Rails::Generator::Base
  include Ruboss::Configuration
  
  attr_reader :project_name, 
              :flex_project_name, 
              :base_package, 
              :base_folder, 
              :command_controller_name,
              :model_names, 
              :command_names

  def initialize(runtime_args, runtime_options = {})
    super
    @project_name, @flex_project_name, @command_controller_name, @base_package, @base_folder = extract_names
    
    @model_names = list_as_files("app/flex/#{base_folder}/models")
    @command_names = list_as_files("app/flex/#{base_folder}/commands")
  end

  def manifest
    record do |m|      
      m.template 'controller.as.erb', File.join("app/flex/#{base_folder}/controllers", 
        "#{command_controller_name}.as")
    end
  end

  protected
    def banner
      "Usage: #{$0} #{spec.name}" 
    end
end
