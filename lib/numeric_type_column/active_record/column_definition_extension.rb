# encoding: utf-8


module NumericTypeColumn

  module ActiveRecord
  
    # Basado en http://thewebfellas.com/blog/2008/6/2/unsigned-integers-for-mysql-on-rails
    module ColumnDefinitionExtension
    
      attr_accessor :unsigned, :comment
      
      def self.included(base)
        #puts "NumericTypeColumn::ActiveRecord::ColumnDefinitionExtension included to #{base.name}!"
        base.send :alias_method_chain, :sql_type, :unsigned
        base.send :alias_method_chain, :to_sql,   :extra_options
      end

      # Override de #sql_type
      def sql_type_with_unsigned
        #puts "NumericTypeColumn::ActiveRecord::ColumnDefinitionExtension: sql_type_with_unsigned"
        # Cambio: signature de call base.type_to_sql:
        if base.method(:type_to_sql).parameters.include?([:opt, :unsigned])
          base.type_to_sql(type.to_sym, limit, precision, scale, unsigned) rescue type
        else
          base.type_to_sql(type.to_sym, limit, precision, scale) rescue type
        end
        
      end
      
      # Override de #to_sql
      def to_sql_with_extra_options
        #puts "NumericTypeColumn::ActiveRecord::ColumnDefinitionExtension: to_sql_with_extra_options"
        column_sql = "#{base.quote_column_name(name)} #{sql_type}"
        column_options = {}
        column_options[:null] = null unless null.nil?
        column_options[:default] = default unless default.nil?
        
        # Cambio: column_options[:comment]
        column_options[:comment] = comment unless comment.nil?
        
        add_column_options!(column_sql, column_options) unless type.to_sym == :primary_key
        column_sql
      end
      
    end
  
  end

end