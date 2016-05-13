class User < ActiveRecord::Base
  has_secure_password

  def self.confirm(params)
    @user = User.find_by({username: params[:username]})
    @user.try(:authenticate, params[:password])
  end
  has_many :tweets
  has_many :comments
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "followed_id",
                                 dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  def following?(other_user)
    following.include?(other_user)
  end

end
