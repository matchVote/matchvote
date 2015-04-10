class Statement < ActiveRecord::Base
  has_many :stances
  belongs_to :issue_category
end
