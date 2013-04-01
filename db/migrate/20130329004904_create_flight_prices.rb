class CreateFlightPrices < ActiveRecord::Migration
  def change
    create_table :flight_prices do |t|
      t.float :price
      t.integer :subscription_id
      t.timestamps
    end
  end
end
