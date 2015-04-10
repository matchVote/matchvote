class IssueCategory < ActiveRecord::Base
  has_many :statements
  validates :name, uniqueness: true
end
