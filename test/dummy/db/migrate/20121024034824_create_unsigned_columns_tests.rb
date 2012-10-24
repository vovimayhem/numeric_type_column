class CreateUnsignedColumnsTests < ActiveRecord::Migration
  def change
    create_table :unsigned_columns_tests, :options => "COMMENT='Pruebas de unsigned columns.'" do |t|
      
      t.integer :integer_unsigned_column,
        :limit => 2,
        :unsigned => true,
        :comment => "Prueba con columna tipo Integer Unsigned."
        
      t.integer :integer_signed_column,
        :limit => 2,
        :comment => "Prueba con columna tipo Integer."
      
      t.string :string_column,
        :limit => 24,
        :comment => "Prueba con columna tipo String."
      
      t.decimal :decimal_unsigned_column,
        :precision => 4,
        :scale => 2,
        :unsigned => true,
        :comment => "Prueba con columna tipo Decimal Unsigned."
        
      t.float :unsigned_float_column,
        :unsigned => true,
        :comment => "Prueba con columna tipo Float Unsigned."
      
      t.boolean :boolean_unsigned_column,
        :unsigned => true,
        :comment => "Prueba con columna tipo Boolean Unsigned."
      
      t.references :references_unsigned_column,
        :unsigned => true,
        :comment => "Prueba con columna tipo References Unsigned."

      t.timestamps
    end
    add_index :unsigned_columns_tests, [:references_unsigned_column_id], :name => :FK_unsigned_references_column_test
  end
end
