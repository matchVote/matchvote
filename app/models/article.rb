class Article < ActiveRecord::Base
  has_many :bookmarks, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, as: :commentable
  has_many :user_article_changes, dependent: :destroy
  has_many :article_representatives
end
