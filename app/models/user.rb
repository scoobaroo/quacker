class User < ActiveRecord::Base
  has_secure_password

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

  has_many :tweets
  has_many :comments
end
