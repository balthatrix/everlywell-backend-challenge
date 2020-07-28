class MemberTopic < ApplicationRecord
  belongs_to :member
  belongs_to :topic
end
