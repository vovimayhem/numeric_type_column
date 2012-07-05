# encoding: utf-8

module NumericTypeColumn

  module ActiveRecord
    
    module BaseExtension
      
      # http://yehudakatz.com/2009/11/12/better-ruby-idioms/
          
      attr_accessor :inheritance_map
      
      def has_numeric_sti_column(sti_column, options = {})
        self.inheritance_column = sti_column
        self.store_full_sti_class = options[:store_full_sti_class] if options.has_key?(:store_full_sti_class)
        self.inheritance_map = options[:inheritance_map] if options.has_key?(:inheritance_map)
        
        extend ClassMethods
        include InstanceMethods
      end
      
      module ClassMethods
        private
        
        # ActiveRecord::Inheritance::ClassMethods#find_sti_class
        def find_sti_class(type_id)
          #puts "(MonkeyPatch) VovCore::HasNumericInheritanceColumn::ClassMethods#find_sti_class"
          base_class.inheritance_map[type_id].constantize
        end
        
        # ActiveRecord::Inheritance::ClassMethods#type_condition
        def type_condition(table = arel_table)
          #puts "(MonkeyPatch) VovCore::HasNumericInheritanceColumn::ClassMethods#type_condition"
          sti_column = table[inheritance_column.to_sym]
          sti_values  = ([self] + descendants).map { |model| base_class.inheritance_map.key(model.sti_name) }
          sti_column.in(sti_values)
        end
        
        # ActiveRecord::Base
        def relation #:nodoc:
          #puts "(MonkeyPatch) VovCore::HasNumericInheritanceColumn::ClassMethods#relation"
          @relation ||= ActiveRecord::Relation.new(self, arel_table)
          if finder_needs_type_condition?
            sti_numeric_value = base_class.inheritance_map.key(sti_name)
            @relation.where(type_condition).create_with(inheritance_column.to_sym => sti_numeric_value)
          else
            @relation
          end
        end
        
      end
      
      module InstanceMethods
        
        private
        
        # ActiveRecord::Persistence::ClassMethods
        def create_or_update
          #puts "(MonkeyPatch) VovCore::HasNumericInheritanceColumn::InstanceMethods#create_or_update - self.class.inheritance_column.to_sym: #{self.class.inheritance_column.to_sym}"
          
          # Setear el atributo de inheritance_column:
          send("#{self.class.inheritance_column.to_sym}=", self.class.base_class.inheritance_map.key(self.class.sti_name))
          
          raise ReadOnlyRecord if readonly?
          result = new_record? ? create : update
          result != false
        end
        
      end
    
    end

  end
end