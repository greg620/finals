class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user, optional: true
  has_many :likes
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true
end
