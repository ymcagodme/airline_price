class AddDefaultToSubscription < ActiveRecord::Migration
  def change
    change_column :subscriptions, :is_subscribed, :boolean, :default => true
  end
end
