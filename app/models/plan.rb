# == Schema Information
#
# Table name: plans
#
#  id         :integer          primary key
#  duration   :integer
#  price      :decimal(, )
#  active     :boolean
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  name       :string(255)
#  free       :boolean
#

class Plan < ActiveRecord::Base

  has_many :subscriptions

  attr_accessible :duration, :price, :active, :name, :free

  scope :free_trial, ->  {where(free: true)}

end
