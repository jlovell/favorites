require 'user_authentication'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  has_many :ratings
  has_many :user_auths

  attr_accessor :remember_token

  def self.from_omniauth(auth_data)
    user = find_or_initialize_by(auth_uid: auth_data['uid'],
                                 auth_provider: auth_data['provider'])
    user.name  = auth_data['info']['name']
    user.email = auth_data['info']['email']

    user.save! if user.new_record? || user.changed?
    user
  end

  def remember
    self.remember_token = UserAuthentication.new_token
    update_attribute :remember_digest, UserAuthentication.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end
end
