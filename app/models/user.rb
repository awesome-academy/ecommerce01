class User < ApplicationRecord
  has_many :suggests, dependent: :destroy
  has_many :comment_raitings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order, dependent: :destroy
  validates :name, presence: true, length:
    {maximum: Settings.user.names.max_length}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.max_length},
    uniqueness: {case_sensitive: false}
  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
end
