# encoding: utf-8

module NumericTypeColumn

  module ActiveRecord
  
    module AbstractMysqlAdapterExtension  
    
      def self.included(base)
        #puts "NumericTypeColumn::ActiveRecord::AbstractMysqlAdapterExtension included to #{base.name}!"
        base::NATIVE_DATABASE_TYPES[:primary_key] = 'INT UNSIGNED DEFAULT NULL auto_increment PRIMARY KEY'
        base.send :alias_method_chain, :add_column_sql,       :unsigned
        base.send :alias_method_chain, :type_to_sql,          :unsigned
        base.send :alias_method_chain, :add_column_options!,  :comment
        #base.send :alias_method_chain, :create_table,         :mysql_options
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
=begin
      def create_table_with_mysql_options(table_name, options = {}) #:nodoc:
        puts "NumericTypeColumn::ActiveRecord::AbstractMysqlAdapterExtension: create_table(table_name: #{table_name}, options: #{options})"
        create_table_without_mysql_options(table_name, options.reverse_merge(options: options[:mysql_options] ? options[:mysql_options] : "ENGINE=InnoDB"))
      end
=end
      protected
      
      def add_column_sql_with_unsigned(table_name, column_name, type, options = {})
        #puts "NumericTypeColumn::ActiveRecord::AbstractMysqlAdapterExtension: add_column_sql_with_unsigned(table_name: #{table_name}, column_name: #{column_name}, type: #{type}, options: #{options})"
        is_unsigned_valid = (((options.has_key? :unsigned) && (options[:unsigned] == true)) && (['integer', 'decimal', 'float', 'boolean'].include? type.to_s))
        add_column_sql = "ADD #{quote_column_name(column_name)} #{type_to_sql(type, options[:limit], options[:precision], options[:scale], is_unsigned_valid)}"
        add_column_options!(add_column_sql, options)
        add_column_position!(add_column_sql, options)
        add_column_sql
      end
      
      def type_to_sql_with_unsigned(type, limit = nil, precision = nil, scale = nil, unsigned = false)
        #puts "NumericTypeColumn::ActiveRecord::AbstractMysqlAdapterExtension: type_to_sql_with_unsigned(type: #{type}, limit: #{limit}, precision: #{precision}, scale: #{scale}, unsigned: #{unsigned})..."
        sql = type_to_sql_without_unsigned(type, limit, precision, scale)
        sql << ' UNSIGNED' if unsigned && (['integer', 'decimal', 'float', 'boolean'].include? type.to_s)
        sql
      end
      
      def add_column_options_with_comment!(sql, options = {})
        #puts "NumericTypeColumn::ActiveRecord::AbstractMysqlAdapterExtension: add_column_options_with_comment!(sql: #{sql}, options: #{})"
        add_column_options_without_comment!(sql, options)
        sql << " COMMENT '#{options[:comment]}'" if options[:comment]
        sql
      end
      
    end
  
  end

end