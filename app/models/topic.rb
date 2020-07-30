class Topic < ApplicationRecord
  has_many :member_topics
  has_many :members, through: :member_topics

  scope :search, -> (text) {
    where("topics.name LIKE ?", "%#{text}%")
  }

  # creates topics from h1, h2, and h3 tags
  # this should definitely be in a background or some kind of worker process asap
  # this should also have some hardening/validation for proper web address probably
  def self.create_member_topics(for_member, web_addr)
    doc = HTTParty.get(web_addr)
    parsed_doc = Nokogiri::HTML(doc)

    all_tags = parsed_doc.xpath(".//h1") + 
      parsed_doc.xpath(".//h2") + 
      parsed_doc.xpath(".//h3")

    all_tags.each do |tag|
      # worth checking what this does when the tag is empty... when it's not empty children is a one-element array representing the string 
      new_topic_name = tag.children.first.to_s.strip

      for_member.topics.find_or_create_by(name: new_topic_name)
    end
  end
end
