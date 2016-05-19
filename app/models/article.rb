class Article < ActiveRecord::Base

  validates :user, presence: true, length: {in: 4..20}
  validates :title, presence: true,uniqueness: true, length: {in: 5..20}
  validates :description, presence: true, length: {maximum: 500}

end
