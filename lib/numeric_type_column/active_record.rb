# encoding: utf-8

module NumericTypeColumn
  
  module ActiveRecord
    autoload :MysqlAdapterPatch,      'numeric_type_column/active_record/mysql_adapter_patch'
    autoload :ColumnDefinitionPatch,  'numeric_type_column/active_record/column_definition_patch'
    autoload :TableDefinitionPatch,   'numeric_type_column/active_record/table_definition_patch'
    autoload :SchemaDumperPatch,      'numeric_type_column/active_record/schema_dumper_patch'
    
    
    autoload :BasePatch,                            'numeric_type_column/active_record/base_patch'
    autoload :BelongsToPolymorphicAssociationPatch, 'numeric_type_column/active_record/belongs_to_polymorphic_association_patch'
  end

end