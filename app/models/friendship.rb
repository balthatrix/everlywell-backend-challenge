class Friendship < ApplicationRecord
  belongs_to :member_a, class_name: "Member"
  belongs_to :member_b, class_name: "Member"

  validate :friendship_doesnt_exist
  validate :not_friending_self

  scope :owned_by, ->(member) {
    where(member_a: member).or(where(member_b: member)).last
  }

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

  # NOTE: this should really be run from a background process only
  def self.shortest_path(cursor_member, target_member, running_path = [], already_searched = [])
    next_layer = cursor_member.friendships 

    searchable = next_layer.where.not(id: already_searched)


    # base case #1, we're at a dead end
    return if searchable.empty?

    next_running_path = running_path + [cursor_member]

    # base case #2, found destination
    found_destination = target_member.friendships.where(id: searchable.ids)&.first
    if found_destination
      return next_running_path + [target_member]
    end

    # add searchable connections to already_searched
    already_searched = already_searched + searchable.ids

    #recurse for each searchable connection point
    searchable.map do |friendship|
      next_cursor = friendship.complimenting(cursor_member)
      shortest_path(next_cursor, target_member, next_running_path, already_searched)
    end.compact.sort{ |results| results.size }.last
  end

  def complimenting(member)
    if member_a == member
      member_b
    elsif member_b == member
      member_a
    end
  end
end
