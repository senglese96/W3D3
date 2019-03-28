# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true
    validates :long_url, :user_id, presence: true
    
    belongs_to(
        :submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(
        :visits,
        class_name: 'Visit',
        foreign_key: :url_id,
        primary_key: :id
    )

    has_many :visitors, through: :visits, source: :user
    has_many :distinct_visitors, Proc.new{ distinct }, through: :visits, source: :user

    def self.create_short_url(user, long_url)
        ShortenedUrl.create!(long_url: long_url, short_url:self.random_code, user_id: user.id)
    end

    def self.random_code
        new_url = SecureRandom.urlsafe_base64
        while self.exists?(new_url)
            new_url = SecureRandom.urlsafe_base64
        end
        new_url
    end

    def num_clicks
        visitors.length

    end

    def num_uniques
        Visit.select(:user_id).distinct.length
    end

    def num_recent_uniques
        Visit.select(:user_id).distinct.where("created_at > ?", 10.minutes.ago).length
    end
end
