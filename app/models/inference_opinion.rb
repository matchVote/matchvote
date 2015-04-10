class InferenceOpinion < ActiveRecord::Base
  belongs_to :stance
  belongs_to :user
end
