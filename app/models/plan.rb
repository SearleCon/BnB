# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  duration   :integer
#  price      :decimal(, )
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  free       :boolean
#

class Plan < ActiveRecord::Base
  has_many :subscriptions

  scope :free_trial, where(free: true)


end
