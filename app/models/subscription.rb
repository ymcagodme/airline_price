# == Schema Information
#
# Table name: subscriptions
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  depart_date   :date
#  return_date   :date
#  is_subscribed :boolean          default(TRUE)
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  priceline     :float
#

class Subscription < ActiveRecord::Base
  attr_accessible :depart_date, :is_subscribed, :priceline, :name, :return_date, :user_id

  belongs_to :user
  has_many :flight_prices, :dependent => :delete_all

  def current_price
    return 'N/A' if flight_prices.empty?
    flight_prices.order('created_at').last.price
  end

  def highest_price
    return 'N/A' if flight_prices.empty?
    flight_prices.order('price').last.price
  end

  def lowest_price
    return 'N/A' if flight_prices.empty?
    flight_prices.order('price').first.price
  end
end
