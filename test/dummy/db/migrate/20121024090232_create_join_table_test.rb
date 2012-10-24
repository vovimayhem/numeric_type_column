class CreateJoinTableTest < ActiveRecord::Migration
  def change
    create_table :join_table_tests, :id => false, :options => "COMMENT='Pruebas de join_table (:id => false).'" do |t|
      
      t.references :object_a,
        :limit => 2,
        :unsigned => true,
        :comment => "Prueba con columna tipo References Unsigned (A)."
        
      t.references :object_b,
        :limit => 2,
        :unsigned => true,
        :comment => "Prueba con columna tipo References Unsigned (B)."
        
    end
    add_index :join_table_tests, [:object_a_id], :name => :FK_join_table_test_a
    add_index :join_table_tests, [:object_b_id], :name => :FK_join_table_test_b
  end
end
