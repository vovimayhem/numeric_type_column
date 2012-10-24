# encoding: utf-8

module NumericTypeColumn

  module ActiveRecord
  
    module TableDefinitionPatch
      
      def self.included(base)
        #puts "NumericTypeColumn::ActiveRecord::TableDefinitionPatch included to #{base.name}!"
        base.send :alias_method_chain, :column, :unsigned_and_comment
      end
    
      def column_with_unsigned_and_comment(name, type, options = {})
        #puts "NumericTypeColumn::ActiveRecord::TableDefinitionPatch: column_with_unsigned_and_comment(name: #{name}, type: #{type}, options = {})..."
        ret_column = column_without_unsigned_and_comment(name, type, options)
        ret_column[name].unsigned = options[:unsigned]
        ret_column[name].comment = options[:comment]
        ret_column
      end
      
    end
    
  end

end