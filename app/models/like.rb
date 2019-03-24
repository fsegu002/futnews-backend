class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self.user_liked_post(postId, userId)
    if Like.where(post_id: postId).where(user_id: userId).length > 0
      return true
    else
      return false
    end
  end
end
