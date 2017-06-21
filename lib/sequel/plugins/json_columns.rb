require "sequel/json_columns/version"

module Sequel::Plugins
  module JsonColumns
    module ClassMethods
      def json_column(column_name)
        column_name = column_name.to_sym

        define_method column_name do
          @serialized_data ||= {}
          modified! column_name
          @serialized_data[column_name] ||= JSON.parse(values[column_name] || '{}', symbolize_names: true) || {}
        end
        
        define_method "#{column_name}=" do |v|
          @serialized_data ||= {}
          modified! column_name
          @serialized_data[column_name] = v
          values[column_name] = v.to_json
        end
      end
    end

    module InstanceMethods
      def before_save
        (@serialized_data || {}).keys.each do |k|
          values[k] = @serialized_data[k].to_json
        end

        super
      end
    end
  end
end
