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

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
