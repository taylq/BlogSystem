class User < ApplicationRecord
  has_many :blogs, dependent: :destroy

  before_save :email_downcase
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  
  has_secure_password

  def feed
    Blog.where "user_id = ?", id
  end

  def gravatar_url options = {size: 50}
    gravatar_id = Digest::MD5.hexdigest email.downcase
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  private

  def email_downcase
    email.downcase!
  end
end
