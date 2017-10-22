class User < ApplicationRecord

  has_many :posts
  has_many :tutoriels
  has_many :likes
  has_many :friends

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true

  def to_session
    {id: id}
  end
end
