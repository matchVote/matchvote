class Stance < ActiveRecord::Base
  has_many :stance_quotes, dependent: :destroy
  has_many :inference_opinions
  belongs_to :statement
  belongs_to :opinionable, polymorphic: true

  enum agreeance_value: ["Very Strongly Agree", 
                         "Strongly Agree", 
                         "Agree", 
                         "Neutral", 
                         "Disagree", 
                         "Strongly Disagree", 
                         "Very Strongly Disagree"]

  enum importance_value: ["Extremely Important", 
                          "Very Important", 
                          "Important", 
                          "Somewhat Important", 
                          "Not Very Important"]
end
