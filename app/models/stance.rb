class Stance < ActiveRecord::Base
  has_many :stance_quotes, dependent: :destroy
  has_many :inference_opinions
  belongs_to :statement
  belongs_to :opinionable, polymorphic: true

  enum agreeance_value: { "Very Strongly Agree"    =>  3,
                          "Strongly Agree"         =>  2,
                          "Agree"                  =>  1,
                          "Neutral"                =>  0,
                          "Disagree"               => -1,
                          "Strongly Disagree"      => -2,
                          "Very Strongly Disagree" => -3 }

  enum importance_value: { "Extremely Important" => 4,
                           "Very Important"      => 3,
                           "Important"           => 2,
                           "Somewhat Important"  => 1,
                           "Not Very Important"  => 0 }
end
