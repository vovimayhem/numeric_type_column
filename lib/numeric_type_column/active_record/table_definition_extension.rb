# encoding: utf-8

module NumericTypeColumn

  module ActiveRecord
  
    module TableDefinitionExtension
      
      def self.included(base)
        #puts "NumericTypeColumn::ActiveRecord::TableDefinitionExtension included to #{base.name}!"
        base.send :alias_method_chain, :column, :unsigned_and_comment
      end
    
      def column_with_unsigned_and_comment(name, type, options = {})
        #puts "NumericTypeColumn::ActiveRecord::TableDefinitionExtension: column_with_unsigned_and_comment(name: #{name}, type: #{type}, options = {})..."
        ret_column = column_without_unsigned_and_comment(name, type, options)
        ret_column[name].unsigned = options[:unsigned]
        ret_column[name].comment = options[:comment]
        ret_column
      end
      
    end
    
  end

end