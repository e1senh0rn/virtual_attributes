require 'active_record/base'
require 'active_record/connection_adapters/abstract/schema_definitions'

module VirtualAttributes
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def virtual_attribute(name, options)
      name_equals = "#{name.to_s}="
      inst_var = "@#{name.to_s}"
      
      define_method(name_equals) do |value|
        attr = ActiveRecord::ConnectionAdapters::Column.new(name, options[:default], options[:type].to_s)
        instance_variable_set inst_var, (attr.type_cast(value) || attr.default)
      end

      define_method(name) do
        if instance_variable_defined?(inst_var)
          instance_variable_get(inst_var)
        else
          instance_variable_set inst_var, ActiveRecord::ConnectionAdapters::Column.new(name, options[:default], options[:type].to_s).default
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, VirtualAttributes)