# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean          default(FALSE)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  role_id                :integer
#  country                :string(255)
#  contact_number         :string(255)
#  surname                :string(255)
#

class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_id ,:terms_of_service, :contact_number, :country, :surname
  validates_acceptance_of :terms_of_service

  after_create :create_subscription, :if => :subscription_required
  after_commit :send_welcome_mail, :if => :created?

  include RoleModel
  roles_attribute :role_id

  roles :guest, :owner

  def active_subscription
    @subscription ||= Subscription.where(user_id: self).first
  end

  def bnb
    @bnb ||= Bnb.where(user_id: self).last
  end

  def reload(options = nil)
    super
    @subscription = nil
  end

  def after_token_authentication
    reset_authentication_token!
  end

  private
  def send_welcome_mail
    UserMailer.delay.welcome(self)
  end

  def subscription_required
    self.is_owner?
  end

  def create_subscription
    plan = Plan.free_trial.first
    subscription = plan.subscriptions.build(user_id: self.id)
    subscription.save!
  end

end
