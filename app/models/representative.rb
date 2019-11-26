require "ostruct"

class Representative < ActiveRecord::Base
  self.table_name = "officials"

  include PgSearch
  has_many :stances, as: :opinionable
  has_many :relationships, foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  has_many :article_representatives
  has_many :terms, foreign_key: :official_id

  validates :first_name, :last_name, :slug, presence: true

  pg_search_scope :search_by_name,
    against: %i[first_name last_name middle_name nickname official_name],
    using: { tsearch: { prefix: true } }

  def self.most_mentioned(articles, limit = 10)
    article_ids = articles.map(&:id).join(", ")
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
      JOIN officials R ON R.id = AR.representative_id
      JOIN articles A ON A.id = AR.article_id
      WHERE A.id in (#{article_ids})
      GROUP BY r.id
    )
    SELECT
       R.nickname
      ,R.first_name
      ,R.last_name
      ,most_mentioned.count AS count
      ,R.profile_pic
      ,R.id
    FROM officials R
    JOIN most_mentioned ON R.id = most_mentioned.id
    ORDER BY count DESC
    LIMIT #{limit}
    SQL
  end

  def current_term
    terms.order(start_date: :desc).first
  end
end
