class Stance < ActiveRecord::Base
  has_many :stance_quotes
  belongs_to :profile
  belongs_to :issue
end
