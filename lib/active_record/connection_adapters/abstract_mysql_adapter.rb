# encoding: utf-8

module ActiveRecord

  module ConnectionAdapters
  
    class AbstractMysqlAdapter
      
      # Override: toma en cuenta la opcion :mysql_options, para definir opciones propias de MySQL sin 'molestar' otros adapters...
      def create_table(table_name, options = {}) #:nodoc:
        super(table_name, options.reverse_merge(:options => options[:mysql_options] ? options[:mysql_options] : "ENGINE=InnoDB"))
      end

=begin

      class Column < ConnectionAdapters::Column # :nodoc:
        attr_reader :unsigned

        def initialize_with_unsigned(name, default, sql_type = nil, null = true)
          initialize_without_unsigned(name, default, sql_type, null)
          @unsigned = extract_unsigned(sql_type)
        end
        alias_method_chain :initialize, :unsigned
  
        def extract_unsigned(sql_type)
          false
        end
      end
=end
      
      def add_column_sql_with_unsigned(table_name, column_name, type, options = {})
        is_unsigned_valid = (((options.has_key? :unsigned) && (options[:unsigned] == true)) && (['integer', 'boolean'].include? type.to_s))
        add_column_sql = "ADD #{quote_column_name(column_name)} #{type_to_sql(type, options[:limit], options[:precision], options[:scale], is_unsigned_valid)}"
        add_column_options!(add_column_sql, options)
        add_column_position!(add_column_sql, options)
        add_column_sql
      end
      alias_method_chain :add_column_sql, :unsigned
      
      def type_to_sql_with_unsigned(type, limit = nil, precision = nil, scale = nil, unsigned = false)
        sql = type_to_sql_without_unsigned(type, limit, precision, scale)
        sql << ' UNSIGNED' if unsigned && (['integer', 'boolean'].include? type.to_s)
        sql
      end
      alias_method_chain :type_to_sql, :unsigned

      def add_column_options_with_comment!(sql, options = {})
        add_column_options_without_comment!(sql, options)
        sql << " COMMENT '#{options[:comment]}'" if options[:comment]
        sql
      end
      alias_method_chain :add_column_options!, :comment
      
    end
  
  end

end