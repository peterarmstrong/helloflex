# Ruboss Patches

# Flex specific XML mime-type
Mime::Type.register_alias "application/xml", :fxml
Mime::Type.unverifiable_types << :fxml

# Flex friendly date, datetime formats
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:flex => "%Y/%m/%d")
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:flex => "%Y/%m/%d %H:%M:%S")

Hash::XML_FORMATTING['date'] = Proc.new { |date| date.to_s(:flex) }
Hash::XML_FORMATTING['datetime'] = Proc.new { |datetime| datetime.to_s(:flex) }

class String
  def capitalize_without_downcasing
    self[0,1].capitalize + self[1..-1]
  end
  def downcase_first_letter
    self[0,1].downcase + self[1..-1]
  end
end

module Ruboss
  module Configuration
    def extract_names
      project_name = ::RAILS_ROOT.split("/").last.capitalize
      project_name_downcase = project_name.downcase

      begin      
        config = YAML.load(File.open("#{RAILS_ROOT}/config/ruboss.yml"))
        base_package = config['base-package'] || project_name_downcase
        base_folder = base_package.sub('.', '/')
        controller_name = config['controller-name'] || "#{project_name}Controller"
      rescue
        base_folder = base_package = project_name_downcase
        controller_name = "#{project_name}Controller"
      end
      [project_name, project_name_downcase, controller_name, base_package, base_folder]
    end

    def list_as_files(dir_name)
      Dir.entries(dir_name).grep(/\.as$/).map { |name| name.sub(/\.as$/, "") }.join(", ")
    end

    def list_mxml_files(dir_name)
      Dir.entries(dir_name).grep(/\.mxml$/).map { |name| name.sub(/\.mxml$/, "") }
    end
  end
end

module ActiveSupport
  module CoreExtensions
    module Hash
      module Conversions
        unless method_defined? :old_to_xml 
          alias_method :old_to_xml, :to_xml
          def to_xml(options = {})
            options.merge!(:dasherize => false)
            old_to_xml(options)
          end
        end
      end
    end
    module Array
      module Conversions
        unless method_defined? :old_to_xml 
          alias_method :old_to_xml, :to_xml
          def to_xml(options = {})
            options.merge!(:dasherize => false)
            old_to_xml(options)
          end
        end
      end
    end
  end
end

module ActiveRecord
  # Flex friendly XML serialization patches
  module Serialization
    unless method_defined? :old_to_xml 
      alias_method :old_to_xml, :to_xml
      def to_xml(options = {})
        options.merge!(:dasherize => false)
        default_except = [:crypted_password, :salt, :remember_token, :remember_token_expires_at]
        options[:except] = (options[:except] ? options[:except] + default_except : default_except)
        options[:methods] = (options[:methods] ? Array(options[:methods]) + 
          default_xml_methods : default_xml_methods) if default_xml_methods
          old_to_xml(options)
      end
    end
  end
  
  # Change the xml serializer so that '?'s are stripped from attribute names.
  # This makes it possible to serialize methods that end in a question mark, like 'valid?' or 'is_true?'
  class XmlSerializer
    def add_tag(attribute)
      builder.tag!(
        dasherize? ? attribute.display_name.dasherize : attribute.display_name,
        attribute.value.to_s,
        attribute.decorations(!options[:skip_types])
      )
    end    
    class Attribute
      def display_name
        @name.gsub('?','')
      end
    end
  end
  
  # Add more extensive reporting on errors including field name along with a message
  # when errors are serialized to XML
  class Errors
    unless method_defined? :old_to_xml 
      alias_method :old_to_xml, :to_xml
      def to_xml(options={})
        options[:root] ||= "errors"
        options[:indent] ||= 2
        options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])
        options[:builder].instruct! unless options.delete(:skip_instruct)
        options[:builder].errors do |e|
          # The @errors instance variable is a Hash inside the Errors class
          @errors.each_key do |attr|
            @errors[attr].each do |msg|
              next if msg.nil?
              if attr == "base"
                options[:builder].error("message" => msg)
              else
                fullmsg = @base.class.human_attribute_name(attr) + ' ' + msg
                options[:builder].error("field" => attr, "message" => fullmsg)
              end
            end
          end
        end
      end
    end  
  end
  
  class Base
    # Add a 'default_xml_methods' method to ActiveRecord::Base
    # This is used to send a set of default :methods to #to_xml
    # for this class.
    # Like this:
    #
    # class SomeModel < ActiveRecord::Base
    #   default_xml_methods :one, :is_true?
    #
    #   def one
    #     1
    #   end
    #   
    #   def is_true?
    #     true
    #   end
    #
    # end
    #
    # In the example above, .to_xml is now equivalent to writing .to_xml(:methods => [:one, :is_true?])
    #
    # $> script/console
    # >> s = SomeModel.find(:first)
    # >> puts s.to_xml
    # <someModel>
    #   ..... (regular old to_xml output goes here)
    #   <one type="integer">one</always_true>
    #   <is_true type="boolean">true</is_true>
    # </someModel>
    # >>
    def self.default_xml_methods(*args)
      @@default_xml_methods = args      
    end
    
    def default_xml_methods
      @@default_xml_methods if defined?(@@default_xml_methods)
    end
  end
end