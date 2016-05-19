class Comment < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :user

  validates :body, length: { minimum: 1 }
  validates :body, length: { maximum: 100 }
end
