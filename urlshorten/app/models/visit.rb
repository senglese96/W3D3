# == Schema Information
#
# Table name: visits
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  url_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Visit < ApplicationRecord
    def self.record_visit!(user, shortened_url)
        Visit.create!(user_id: user.id, url_id: shortened_url.id)
    end

    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    belongs_to(
        :shortened_url,
        class_name: 'ShortenedUrl',
        foreign_key: :url_id,
        primary_key: :id
    )
end
