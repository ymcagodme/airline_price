class DeleteBoundaryToSubscription < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :upper_priceline
    remove_column :subscriptions, :lower_priceline
    add_column :subscriptions, :priceline, :float
  end
end
