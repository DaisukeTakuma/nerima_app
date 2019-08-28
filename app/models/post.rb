class Post < ApplicationRecord
  has_one_attached :image
  
  validates :title, presence: true
  validates :title, length: { maximum: 30 }
  validates :category_name, presence: true

  belongs_to :user
  paginates_per 10
  scope :recent, -> { order(updated_at: :desc) }
end