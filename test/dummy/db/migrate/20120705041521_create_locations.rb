class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :type, unsigned: true, comment: "llave foranea a location_type"
      t.string :name, limit: 45, comment: "Nombre de la locacion."
    end
    add_index :locations, [:type_id], name: :FK_location_type
  end
end
