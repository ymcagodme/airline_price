class Subscription < ActiveRecord::Base
  attr_accessible :depart_date, :is_subscribed, :lower_priceline, :name, :return_date, :upper_priceline, :user_id
  belongs_to :user
end
