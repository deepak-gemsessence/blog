class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  def is_commenter?(user)
    user.id == self.user_id
  end

  def can_modify?(user)
    is_commenter?(user) && !approved
  end

  def is_article_owner?(user)
    self.article.user_id == user.id
  end

  def is_visible_to_user?(user)
    return true if self.approved
    is_commenter?(user) || is_article_owner?(user)
  end

  def authors_comment(user)
      self.update_attribute(:approved, true) if is_article_owner?(user)
  end

end


  # def self.auto_approve_authors_comment(user, current_article)
  #   user.id == current_article.user_id
  # end


# def check_current_user_and_commenter(user)
  #   user.id == self.user_id
  # end

  # def approve_comment(user)
  #   user.id == self.article.user_id
  # end

  # def comments_for_author_and_commenter(user)
  #   binding.pry
  #   (!self.approved && self.user_id == user.id || self.article.user_id == user.id) || self.approved
  # end
