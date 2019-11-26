class ArticleRepresentative < ActiveRecord::Base
  self.table_name = "articles_officials"

  belongs_to :article
  belongs_to :representative, foreign_key: :official_id
end
