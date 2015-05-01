class Post < ActiveRecord::Base

  # Each post is created by 1 user
  belongs_to :user
  # Posts can be voted on by many users
  has_many :votes, as: :votable
  # Comments for that post
  has_many :comments

  validates :title,
    presence: true,
    length: { in: 10..100 }

  validates :link,
    presence: true,
    url: true

end
