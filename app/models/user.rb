class User < ActiveRecord::Base
  # extend FriendlyId
  # friendly_id :username, use: :slugged

  has_secure_password

  mount_uploader :avatar, AvatarUploader

  has_many :tweets
  has_many :comments
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
  def liked?(tweet)
    self.liked? tweet
  end

  def slug
    username.downcase.gsub(" ", "-")
  end

  def to_param
    "#{id}-#{slug}"
  end

end
