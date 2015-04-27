class IssueCategory < ActiveRecord::Base
  has_many :statements, dependent: :destroy
  validates :name, uniqueness: true, presence: true
end
