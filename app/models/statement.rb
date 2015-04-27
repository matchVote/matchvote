class Statement < ActiveRecord::Base
  has_many :stances, dependent: :destroy
  belongs_to :issue_category
  validates :text, uniqueness: true, presence: true
end
