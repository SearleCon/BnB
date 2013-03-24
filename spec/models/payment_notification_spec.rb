# == Schema Information
#
# Table name: payment_notifications
#
#  id             :integer          primary key
#  params         :text
#  user_id        :integer
#  status         :string(255)
#  transaction_id :string(255)
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#

require 'spec_helper'

describe PaymentNotification do
  pending "add some examples to (or delete) #{__FILE__}"
end
