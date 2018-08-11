require 'ostruct'

class Representative < ActiveRecord::Base
  include PgSearch
  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact, reject_if: :all_blank
  has_many :stances, as: :opinionable
  has_many :relationships, foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  has_many :article_representatives

  validates :first_name, :last_name, :slug, presence: true

  pg_search_scope :search_by_name,
    against: [:first_name, :last_name, :middle_name, :nickname, :official_full_name],
    using: { tsearch: { prefix: true } }

  def self.most_mentioned(articles, limit=10)
    article_ids = articles.map { |a| a.id }.join(', ')
    return [] if article_ids.empty?
    data = connection.execute(most_mentioned_sql(article_ids, limit))
    data.as_json.map do |rep_data|
      OpenStruct.new(rep_data)
    end
  end

  def self.most_mentioned_sql(article_ids, limit)
    <<-SQL
    WITH most_mentioned AS (
      SELECT
         R.id AS id
        ,count(1) AS count
      FROM articles_representatives AR
      JOIN representatives R ON R.id = AR.representative_id
      JOIN articles A ON A.id = AR.article_id
      WHERE A.id in (#{article_ids})
      GROUP BY r.id
    )
    SELECT
       R.nickname
      ,R.first_name
      ,R.last_name
      ,most_mentioned.count AS count
      ,R.profile_image_url
    FROM representatives R
    JOIN most_mentioned ON R.id = most_mentioned.id
    ORDER BY count DESC
    LIMIT #{limit}
    SQL
  end

  def update_or_create_contact(contact_params)
    contact ? contact.update!(contact_params) : create_contact!(contact_params)
  end

  def update_external_ids(hash)
    if contact
      ids = contact.external_ids || {}
      contact.update!(external_ids: ids.merge(hash))
    end
  end
end
