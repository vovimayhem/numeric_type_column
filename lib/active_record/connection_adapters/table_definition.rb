# encoding: utf-8

module ActiveRecord

  module ConnectionAdapters
  
    class TableDefinition
      def column_with_unsigned_and_comment(name, type, options = {})
        ret_column = column_without_unsigned_and_comment(name, type, options)
        ret_column[name].unsigned = options[:unsigned]
        ret_column[name].comment = options[:comment]
        ret_column
      end
      alias_method_chain :column, :unsigned_and_comment
    end
    
  end

end