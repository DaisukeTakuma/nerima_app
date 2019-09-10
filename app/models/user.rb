class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy

  # ユーザーをフォローするこれ必要？？
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除するこれ必要？？
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返すこれ必要？？
  def following?(other_user)
    following.include?(other_user)
  end
end