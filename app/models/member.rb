class Member < ApplicationRecord
  has_secure_password

  has_many :links
  has_many :member_topics
  has_many :topics, through: :member_topics
end
