class Stance < ActiveRecord::Base
  DEFAULT_AGREEANCE = 0
  DEFAULT_IMPORTANCE = 2

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

  enum importance_value: { "Very Important" => 4,
                           "Important"      => 3,
                           "Neutral"           => 2,
                           "Somewhat Important"  => 1,
                           "Not Very Important"  => 0 }

  def agreeance_integer_value
    self[:agreeance_value] || DEFAULT_AGREEANCE
  end

  def importance_integer_value
    self[:importance_value] || DEFAULT_IMPORTANCE
  end
end
