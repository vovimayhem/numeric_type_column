module NumericTypeColumn
  class Railtie < ::Rails::Railtie #:nodoc:
    
    initializer 'numeric_type_column' do |app|
      
      ActiveSupport.on_load(:active_record) do
      
        # Patches para permitir definir columnas UNSIGNED y COMMENTS en MySQL:
        ::ActiveRecord::ConnectionAdapters::ColumnDefinition.send     :include, NumericTypeColumn::ActiveRecord::ColumnDefinitionExtension
        ::ActiveRecord::ConnectionAdapters::TableDefinition.send      :include, NumericTypeColumn::ActiveRecord::TableDefinitionExtension
        ::ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter.send :include, NumericTypeColumn::ActiveRecord::AbstractMysqlAdapterExtension
        
        # Patch para permitir STI con columna numerica:
        ::ActiveRecord::Base.extend NumericTypeColumn::ActiveRecord::BaseExtension
        
        # Patch para permitir polymorphs con columna foreign_type numerica:
        #::ActiveRecord::Associations::BelongsToPolymorphicAssociation.extend NumericTypeColumn::ActiveRecord::BelongsToPolymorphicAssociationExtension
        
        
      end
    end
  end
end