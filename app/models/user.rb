class User < ActiveRecord::Base
  has_secure_password

  def self.confirm(params)
    @user = User.find_by({username: params[:username]})
    @user.try(:authenticate, params[:password])
  end
  has_many :tweets
  has_many :comments
end
