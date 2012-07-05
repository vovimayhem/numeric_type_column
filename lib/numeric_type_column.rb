# encoding: utf-8

module NumericTypeColumn
  autoload :ActiveRecord, 'numeric_type_column/active_record'
end

require 'numeric_type_column/railtie' if defined?(Rails)
