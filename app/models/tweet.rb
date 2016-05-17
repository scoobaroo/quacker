class Tweet < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  validates :body, length: { minimum: 1 }
  validates :body, length: { maximum: 200 }
  acts_as_votable
end
