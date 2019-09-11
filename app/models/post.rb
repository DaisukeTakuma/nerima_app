class Post < ApplicationRecord
  has_one_attached :image
  
  validates :title, presence: false, length: { maximum: 30 }
  validates :description, presence: false
  validates :category_name, presence: false
  
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  has_many :comments, dependent: :destroy

  belongs_to :user

  paginates_per 10
  scope :recent, -> { order(updated_at: :desc) }

  def like(user)
    likes.create(user_id: user.id)
  end

  def like?(user)
    like_users.include?(user)
  end
      
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end
end