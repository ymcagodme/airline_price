# == Schema Information
#
# Table name: flight_prices
#
#  id              :integer          not null, primary key
#  price           :float
#  subscription_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class FlightPrice < ActiveRecord::Base
  attr_accessible :price, :subscription_id

  belongs_to :subscription
end
