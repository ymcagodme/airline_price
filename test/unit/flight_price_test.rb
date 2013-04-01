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

require 'test_helper'

class FlightPriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
