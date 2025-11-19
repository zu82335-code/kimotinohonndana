class Tweet < ApplicationRecord
  mount_uploader :image, ImageUploader
belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users,  through: :likes, source: :user
  has_many :tweet_tags, dependent: :destroy
  has_many :tags, through: :tweet_tags
end
