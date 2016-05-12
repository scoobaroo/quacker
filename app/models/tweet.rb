class Tweet < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :body, length: { minimum: 1 }
  validates :body, length: { maximum: 200 }
end
