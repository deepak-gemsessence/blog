require 'digest/sha1'

class User < ActiveRecord::Base

  has_many :articles, dependent: :destroy
  has_many :comments

  validates :first_name, :last_name, :contact, presence: true
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :username, uniqueness: true

  before_save :encrypt_password, on: :create

  def encrypt_password
    encrypted_password= Digest::SHA1.hexdigest(password)
    self.password = encrypted_password
  end

  def self.match_password?(user, password)
    encrypted_password = Digest::SHA1.hexdigest(password)
    User.where(username: user, password: encrypted_password)
  end

  # def self.search_user(user, password)
  #   User.where(username: user, password: password)
  # end

  def match_current_user(current_user)
    self == current_user
  end

end
