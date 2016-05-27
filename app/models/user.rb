class User < ActiveRecord::Base

  has_many :articles, dependent: :destroy
  has_many :comments

  validates :first_name, :last_name, :contact, presence: true
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :username, uniqueness: true

  def self.search_user(user, password)
    User.where(username: user, password: password)
  end

  # def self.match_current_user(user, current_user)
  #   user==current_user
  # end

  def match_current_user(current_user)
    self == current_user
  end

end
