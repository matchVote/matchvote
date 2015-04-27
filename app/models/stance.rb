class Stance < ActiveRecord::Base
  has_many :stance_quotes, dependent: :destroy
  has_many :inference_opinions
  belongs_to :statement
  belongs_to :opinionable, polymorphic: true
end
