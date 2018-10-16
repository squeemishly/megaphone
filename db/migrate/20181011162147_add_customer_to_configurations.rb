class AddCustomerToConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_reference :configurations, :customer, foreign_key: true
  end
end
