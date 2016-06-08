class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true

  validates :title, presence: true,uniqueness: true, length: {in: 5..20}
  validates :description, presence: true, length: {maximum: 500}

  scope :other_authors_articles, -> (user_id) {where("user_id != ?", user_id)}

  def is_approved_comment?
    self.comments.where(approved: true)
  end

end
