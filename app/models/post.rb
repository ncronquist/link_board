class Post < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable

  validates :title,
    presence: true,
    length: { in: 10..100 }

  validates :link,
    presence: true,
    url: true

end
