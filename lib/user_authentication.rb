module UserAuthentication
  extend self

  def new_token
    SecureRandom.urlsafe_base64
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # @param user [User] the User to check against
  # @param token [String] the inbound token to authenticate
  # @return [true, false]
  def correct_token?(user, token)
    return false unless token.present?
    BCrypt::Password.new(user.remember_digest).is_password?(token)
  end
end
