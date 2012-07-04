module NumericTypeColumn
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'numeric_type_column' do |app|
      ActiveSupport.on_load(:active_record) do
        # Patch para permitir definir columnas UNSIGNED y COMMENTS en MySQL:
        require 'numeric_type_column/abstract_mysql_adapter_extension'
        ::ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter.send :include, NumericTypeColumn::AbstractMysqlAdpaterExtension
        
        # Patch para permitir polymorphs con columna foreign_type numerica:
        require 'numeric_type_column/belongs_to_polymorphic_association_extension'
        ::ActiveRecord::Associations::BelongsToPolymorphicAssociation.send :include, NumericTypeColumn::BelongsToPolymorphicAssociationExtension
        
        # Patch para permitir STI con columna numerica:
        require 'numeric_type_column/inheritance_extension'
        ::ActiveRecord::Base.extend NumericTypeColumn::HasNumericInheritanceColumn
      end
    end
  end
end