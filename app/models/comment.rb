class Comment < ApplicationRecord

  belongs_to :post, optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id

  validates :content, presence: true
end
