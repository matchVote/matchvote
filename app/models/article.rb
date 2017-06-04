class Article < ActiveRecord::Base
  has_many :bookmarks
end
