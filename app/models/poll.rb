class Poll < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  belongs_to :representative
end
