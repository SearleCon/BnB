# == Schema Information
#
# Table name: guests
#
#  id             :integer          primary key
#  name           :string(255)
#  surname        :string(255)
#  contact_number :string(255)
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#  bnb_id         :integer
#  user_id        :integer
#  email          :string(255)
#  slug           :string(255)
#

require 'spec_helper'

describe Guest do
  pending "add some examples to (or delete) #{__FILE__}"
end
