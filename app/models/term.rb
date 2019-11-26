class Term < ActiveRecord::Base
  belongs_to :representative, foreign_key: :official_id
end
