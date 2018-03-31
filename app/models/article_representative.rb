class ArticleRepresentative < ActiveRecord::Base
  self.table_name = 'articles_representatives'

  belongs_to :article
  belongs_to :representative
end
