class Article < ActiveRecord::Base
  has_many :bookmarks
  has_many :comments, as: :commentable
end
