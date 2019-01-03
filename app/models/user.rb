class User < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save :email_downcase
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  
  has_secure_password

  def feed
    following_ids = "SELECT followed_id FROM relationships 
      WHERE  follower_id = :user_id"
    Blog.where "user_id IN (#{following_ids}) OR user_id = :user_id",
      user_id: id
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

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  private

  def email_downcase
    email.downcase!
  end
end
