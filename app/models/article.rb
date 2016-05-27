class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true,uniqueness: true, length: {in: 5..20}
  validates :description, presence: true, length: {maximum: 500}

  scope :other_authors_articles, -> (user_id) {where("user_id != ?", user_id)}

end
