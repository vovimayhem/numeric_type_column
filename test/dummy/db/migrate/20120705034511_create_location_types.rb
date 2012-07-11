class CreateLocationTypes < ActiveRecord::Migration
  def change
    create_table :location_types do |t|
      t.string :name, limit: 45, comment: "Nombre del tipo."
    end
  end
end
