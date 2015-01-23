class PostVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :user_id, scope: :post_id # это не даст создать дубль, то есть при попытке сохранить пойдет ошибка и сработает второй сценарий, т.к. сейв не пройдет
  after_create :update_post_votes # оно выполнится, если валидацию прошло

  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, 'is the author of the post' if post.user_id == user_id
  end

  private
  def update_post_votes
    self.post.update_attributes(rating: self.post.rating += self.value)
  end
end