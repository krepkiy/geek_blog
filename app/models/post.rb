class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_votes

  validates_presence_of :title, :body, :user_id
  validates_uniqueness_of :title
  validates_length_of :title, in: 5..140
  validates_length_of :body, minimum: 140
  scope :newest, -> { order('created_at DESC') }
  scope :active, -> { order(:updated_at).reverse }
  scope :popular, -> { order(:rating).reverse }

  after_create :post_touch

  def post_touch
    self.touch
  end

end