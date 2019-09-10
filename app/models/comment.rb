class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  scope :recent, -> { order(updated_at: :desc) }
end
