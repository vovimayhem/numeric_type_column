module NumericTypeColumn
  class Railtie < ::Rails::Railtie #:nodoc:
    
    initializer 'numeric_type_column' do |app|
      
      ActiveSupport.on_load(:active_record) do
      
        # Patches para permitir definir columnas UNSIGNED y COMMENTS en MySQL:
        adaptr_module = "::ActiveRecord::ConnectionAdapters"
        "#{adaptr_module}::ColumnDefinition".constantize.send             :include, NumericTypeColumn::ActiveRecord::ColumnDefinitionPatch
        "#{adaptr_module}::TableDefinition".constantize.send              :include, NumericTypeColumn::ActiveRecord::TableDefinitionPatch
        ["MysqlAdapter", "Mysql2Adapter", 'Mysql2SpatialAdapter'].each do |mysql_adapter_name|
          if adaptr_module.constantize.const_defined? mysql_adapter_name
            "#{adaptr_module}::#{mysql_adapter_name}".constantize.send :include, NumericTypeColumn::ActiveRecord::MysqlAdapterPatch
          end
        end
        ::ActiveRecord::SchemaDumper.send :include, NumericTypeColumn::ActiveRecord::SchemaDumperPatch
        
        # Patch para permitir STI con columna numerica:
        ::ActiveRecord::Base.extend NumericTypeColumn::ActiveRecord::BasePatch
        
        # Patch para permitir polymorphs con columna foreign_type numerica:
        #::ActiveRecord::Associations::BelongsToPolymorphicAssociation.extend NumericTypeColumn::ActiveRecord::BelongsToPolymorphicAssociationPatch
        
        
      end
    end
  end
end