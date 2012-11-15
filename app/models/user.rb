# == Schema Information
#
# Table name: users
#
#  id                     :integer          primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :timestamp        not null
#  updated_at             :timestamp        not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean          default(FALSE)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :timestamp
#  remember_created_at    :timestamp
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :timestamp
#  last_sign_in_at        :timestamp
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  role_id                :integer
#  country                :string(255)
#  contact_number         :string(255)
#

class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_id, :terms_of_service, :contact_number, :country

  validates_acceptance_of :terms_of_service

  def role
    role ||= Role.find(role_id)
  end

  def is_owner?
    self.role.description == "Owner"
  end

  def active_subscription
    subscription ||= Subscription.find_by_user_id_and_active_profile(self, true)
  end

  def bnb
    bnb ||= Bnb.find_last_by_user_id(self)
  end


end
