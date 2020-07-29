class Friendship < ApplicationRecord
  belongs_to :member_a, class_name: "Member"
  belongs_to :member_b, class_name: "Member"

  validate :friendship_doesnt_exist
  validate :not_friending_self

  def friendship_doesnt_exist
    exists = Friendship.exists?(member_a: self.member_a, member_b: self.member_b) ||
      Friendship.exists?(member_b: self.member_a, member_a: self.member_b) ||
      Friendship.exists?(member_b: self.member_b, member_a: self.member_a)

    if exists
      errors.add(:members, "Already have a friendship")
    end
  end

  def not_friending_self
    if member_a_id == member_b_id
      errors.add(:members, "Cannot friend self")
    end
  end
end
