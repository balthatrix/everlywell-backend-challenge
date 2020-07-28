class Link < ApplicationRecord
  belongs_to :member

  def self.from_url(member, url)
    create!(member: member, url: url, code: SecureRandom.uuid.first(5))
  end

  def short_url
    "#{ENV['APP_URL']}l/#{code}"
  end
end
