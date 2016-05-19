class Tweet < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  validates :body, length: { minimum: 1 }
  validates :body, length: { maximum: 200 }
  acts_as_votable

  self.per_page = 2
end
