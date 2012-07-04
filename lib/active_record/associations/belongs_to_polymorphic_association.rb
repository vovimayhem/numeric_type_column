# encoding: utf-8

module ActiveRecord
  module Associations
    class BelongsToPolymorphicAssociation
      def klass
        type = owner[reflection.foreign_type]
        
        # Hack: Llama al metodo en caso de que no exista el atributo con el nombre:
        type = owner.send(reflection.foreign_type) unless !type.nil?
        
        type.presence && type.constantize
      end
      
      private

        def replace_keys(record)
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