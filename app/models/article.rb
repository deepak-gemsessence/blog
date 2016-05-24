class Article < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true,uniqueness: true, length: {in: 5..20}
  validates :description, presence: true, length: {maximum: 500}
end
