# encoding: utf-8

module NumericTypeColumn
  module ActiveRecord
    
    module BelongsToPolymorphicAssociationExtension
    
      def self.included(base)
        #puts "NumericTypeColumn::ActiveRecord::BelongsToPolymorphicAssociationExtension included to #{base.name}!"
        base.send :alias_method_chain, :klass,        :numeric_type_column
        base.send :alias_method_chain, :replace_keys, :numeric_type_column
      end
    
      def klass_with_numeric_type_column
      
        #puts "NumericTypeColumn::ActiveRecord::BelongsToPolymorphicAssociationExtension: klass_with_numeric_type_column"
      
        type = owner[reflection.foreign_type]
        
        # Hack: Llama al metodo en caso de que no exista el atributo con el nombre:
        type = owner.send(reflection.foreign_type) unless !type.nil?
        
        type.presence && type.constantize
      end
      
      private

      def replace_keys_with_numeric_type_column(record)
      
        #puts "NumericTypeColumn::ActiveRecord::BelongsToPolymorphicAssociationExtension: replace_keys_with_numeric_type_column(record: #{record})"
      
        super
        if owner.attribute_names.include?(reflection.foreign_type)
          owner[reflection.foreign_type] = record && record.class.base_class.name
        else
          # Hack: llama al método '=' con .send, para que funcione en caso de que no sea un atributo, sino un método:
          owner.send "#{reflection.foreign_type}=", record && record.class.base_class.name
        end
      end
    end

  end
end