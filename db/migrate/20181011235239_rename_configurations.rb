class RenameConfigurations < ActiveRecord::Migration[5.2]
  def change
    rename_table :configurations, :services
  end
end
