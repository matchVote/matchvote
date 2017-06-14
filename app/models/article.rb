class Article < ActiveRecord::Base
  has_many :bookmarks
  has_many :comments, -> { order(created_at: :desc) }, as: :commentable
end
