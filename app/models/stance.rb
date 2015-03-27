class Stance < ActiveRecord::Base
  has_many :stance_quotes
  belongs_to :issue
  belongs_to :opinionable, polymorphic: true
end
