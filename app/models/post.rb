class Post < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 30 }
  validates :category_name, presence: true

  belongs_to :user
end