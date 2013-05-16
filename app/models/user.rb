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
#  surname                :string(255)
#  authentication_token   :string(255)
#  slug                   :string(255)
#

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :subscriptions

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_id ,:terms_of_service, :contact_number, :country, :surname
  validates_acceptance_of :terms_of_service

  after_create :create_subscription

  include RoleModel
  roles_attribute :role_id

  roles :guest, :owner, :admin

  def bnb
    @bnb ||= Bnb.where(user_id: self).last
  end


  def after_token_authentication
    reset_authentication_token!
  end

  def timeout_in
    8.hours
  end


  private
  def create_subscription
    if is_owner?
     plan = Plan.free_trial.first
     subscription = subscriptions.build(plan: plan)
     subscription.save!
    end
  end
end
