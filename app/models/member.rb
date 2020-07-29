class Member < ApplicationRecord
  has_secure_password

  has_many :links
  has_many :member_topics
  has_many :topics, through: :member_topics

  has_many :friendships, ->(member) {}

  def friendships
    Friendship.where(member_a_id: self.id).or(Friendship.where(member_b_id: self.id))
  end

  def friends
    # to optimize this should be a custom query to select just the 'other' ids
    member_ids = friendships.select(:member_a_id, :member_b_id).map{|fs| fs.member_a_id != self.id ? fs.member_a_id : fs.member_b_id }
    Member.where(id: member_ids)
  end

  def add_friend other_member
    return if other_member.id == self.id

    return if Friendship.exists?(member_a: self) || Friendship.exists?(member_b: self)

    Friendship.create(member_a_id: self.id, member_b_id: other_member.id)
  end
end
