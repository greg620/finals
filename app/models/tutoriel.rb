class Tutoriel < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :content, presence: true

  belongs_to :category
  belongs_to :user
end
