class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.date :depart_date
      t.date :return_date
      t.float :upper_priceline
      t.float :lower_priceline
      t.boolean :is_subscribed
      t.integer :user_id

      t.timestamps
    end
  end
end
