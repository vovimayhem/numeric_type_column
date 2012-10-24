# encoding: utf-8

module NumericTypeColumn

  module ActiveRecord
    
    module MysqlColumnPatch  
    
      def self.included(base)
        #puts "NumericTypeColumn::ActiveRecord::MysqlColumnPatch included to #{base.name}!"
        base.send :alias_method_chain, :initialize,  :comment
      end
      
      attr_reader :comment
      
      def initialize_with_comment(name, default, sql_type = nil, null = true, collation = nil, comment = nil)
        # puts "NumericTypeColumn::ActiveRecord::MysqlColumnPatch#initialize_with_comment - comment: #{comment}"
        initialize_without_comment(name, default, sql_type, null, collation)
        @comment = comment if comment.present?
      end
      
    end
  
    module MysqlAdapterPatch  
    
      def self.included(base)
        #puts "NumericTypeColumn::ActiveRecord::MysqlAdapterPatch included to #{base.name}!"
        base::NATIVE_DATABASE_TYPES[:primary_key] = 'INT UNSIGNED DEFAULT NULL auto_increment PRIMARY KEY'
        base.send :alias_method_chain, :add_column_sql,       :unsigned
        base.send :alias_method_chain, :type_to_sql,          :unsigned
        base.send :alias_method_chain, :add_column_options!,  :comment
        base.send :alias_method_chain, :columns,              :comment
        base.send :alias_method_chain, :new_column,           :comment
        #base.send :alias_method_chain, :create_table,         :mysql_options
        
        # Incluir patch a self::Column:
        "#{base.name}::Column".constantize.send :include, NumericTypeColumn::ActiveRecord::MysqlColumnPatch
      end

=begin
      def create_table_with_mysql_options(table_name, options = {}) #:nodoc:
        puts "NumericTypeColumn::ActiveRecord::MysqlAdapterPatch: create_table(table_name: #{table_name}, options: #{options})"
        create_table_without_mysql_options(table_name, options.reverse_merge(options: options[:mysql_options] ? options[:mysql_options] : "ENGINE=InnoDB"))
      end
=end
      def new_column_with_comment(field, default, type, null, collation, comment) # :nodoc:
        #puts "NumericTypeColumn::ActiveRecord::MysqlAdapterPatch#new_column_with_comment: '#{comment}'"
        "#{self.class.name}::Column".constantize.new(field, default, type, null, collation, comment)
      end
      
      def table_options(table_name)
        sql = "SHOW TABLE STATUS "
        sql << "IN #{quote_table_name(current_database)} "
        sql << "LIKE #{quote(table_name)}"
        ohmy = execute_and_free(sql, 'SCHEMA') do |result|
          each_hash(result).map do |field|
            "ENGINE=#{field[:Engine]} COLLATE=#{field[:Collation]} COMMENT='#{field[:Comment]}'"
          end
        end
        ohmy.first
      end
      
      # Returns an array of +Column+ objects for the table specified by +table_name+.
      def columns_with_comment(table_name, name = nil)#:nodoc:
        sql = "SHOW FULL FIELDS FROM #{quote_table_name(table_name)}"
        execute_and_free(sql, 'SCHEMA') do |result|
          each_hash(result).map do |field|
            new_column_with_comment(field[:Field], field[:Default], field[:Type], field[:Null] == "YES", field[:Collation], field[:Comment])
          end
        end
      end
      
      protected
      
      def add_column_sql_with_unsigned(table_name, column_name, type, options = {})
        #puts "NumericTypeColumn::ActiveRecord::MysqlAdapterPatch: add_column_sql_with_unsigned(table_name: #{table_name}, column_name: #{column_name}, type: #{type}, options: #{options})"
        is_unsigned_valid = (((options.has_key? :unsigned) && (options[:unsigned] == true)) && (['integer', 'decimal', 'float', 'boolean'].include? type.to_s))
        add_column_sql = "ADD #{quote_column_name(column_name)} #{type_to_sql(type, options[:limit], options[:precision], options[:scale], is_unsigned_valid)}"
        add_column_options!(add_column_sql, options)
        add_column_position!(add_column_sql, options)
        add_column_sql
      end
      
      def type_to_sql_with_unsigned(type, limit = nil, precision = nil, scale = nil, unsigned = false)
        #puts "NumericTypeColumn::ActiveRecord::MysqlAdapterPatch: type_to_sql_with_unsigned(type: #{type}, limit: #{limit}, precision: #{precision}, scale: #{scale}, unsigned: #{unsigned})..."
        sql = type_to_sql_without_unsigned(type, limit, precision, scale)
        sql << ' UNSIGNED' if unsigned && (['integer', 'decimal', 'float', 'boolean'].include? type.to_s)
        sql
      end
      
      def add_column_options_with_comment!(sql, options = {})
        #puts "NumericTypeColumn::ActiveRecord::MysqlAdapterPatch: add_column_options_with_comment!(sql: #{sql}, options: #{})"
        add_column_options_without_comment!(sql, options)
        sql << " COMMENT '#{options[:comment]}'" if options[:comment]
        sql
      end
      
    end
  
  end

end