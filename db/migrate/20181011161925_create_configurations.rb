class CreateConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :configurations do |t|
      t.string :service_id, null: false
      t.string :service_name, null: false
      t.integer :active_version, null: false
      t.integer :previous_version

      t.timestamps
    end
  end
end
