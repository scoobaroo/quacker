class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username

  has_secure_password
  mount_uploader :avatar, AvatarUploader

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: (/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/)
  validates :password, presence: true, length: { in: 6..20 }, on: :create

  has_many :tweets,dependent:   :nullify
  has_many :comments,dependent:   :nullify
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "followed_id",
                                 dependent:   :destroy
  has_many :followers, through: :passive_relationships

  def self.confirm(params)
    @user = User.find_by({username: params[:username]})
    @user.try(:authenticate, params[:password])
  end

  def self.search(username)
    if username
      username.downcase!
      where('LOWER(username) LIKE ?', "%#{username}%")
    else
      all
    end
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
  acts_as_votable
end
