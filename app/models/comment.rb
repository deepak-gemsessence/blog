class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  # validates :body, presence: true, length: { in: 5..100 }

  def is_commenter?(user)
    user.id == self.user_id unless user.nil?
  end

  def can_modify?(user)
    is_commenter?(user) && !approved
  end

  def is_article_owner?(user)
    self.article.user_id == user.id unless user.nil?
  end

  def is_visible_to_user?(user)
    return true if self.approved
    is_commenter?(user) || is_article_owner?(user)
  end

  def authors_comment(user)
      self.update_attribute(:approved, true) if is_article_owner?(user)
  end

end
