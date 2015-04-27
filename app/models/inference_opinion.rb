class InferenceOpinion < ActiveRecord::Base
  # when a user agrees/disagrees that this is a valid stance
  belongs_to :stance
  belongs_to :user
end
