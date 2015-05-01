class User < ActiveRecord::Base
  has_secure_password

  # posts created by the user
  has_many :posts
  # votes ABOUT this user (via votable)
  has_many :votes, as: :votable
  # votes cast by the user (via user_id foreign key)
  has_many :ratings, class_name: 'Vote'
  # comments created by the user
  has_many :comments

  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    email: true

  validates :password,
    presence: true,
    :on => :create,
    length: { minimum: 8 }

  validates :name,
    presence: true,
    length: { maximum: 20 }

  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

end
