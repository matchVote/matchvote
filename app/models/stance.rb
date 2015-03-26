class Stance < ActiveRecord::Base
  has_many :stance_quotes
  belongs_to :representative
  belongs_to :issue
end
