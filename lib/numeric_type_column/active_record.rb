# encoding: utf-8

module NumericTypeColumn
  
  module ActiveRecord
    autoload :AbstractMysqlAdapterExtension,            'numeric_type_column/active_record/abstract_mysql_adapter_extension'
    autoload :BaseExtension,                            'numeric_type_column/active_record/base_extension'
    autoload :BelongsToPolymorphicAssociationExtension, 'numeric_type_column/active_record/belongs_to_polymorphic_association_extension'
    autoload :ColumnDefinitionExtension,                'numeric_type_column/active_record/column_definition_extension'
    autoload :TableDefinitionExtension,                 'numeric_type_column/active_record/table_definition_extension'
    autoload :SchemaDumperExtension,                    'numeric_type_column/active_record/schema_dumper_extension'
    #autoload :MysqlColumnExtension,                     'numeric_type_column/active_record/mysql_column_extension'
  end

end