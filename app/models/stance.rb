class Stance < ActiveRecord::Base
  has_many :stance_quotes, dependent: :destroy
  has_many :inference_opinions
  belongs_to :statement
  belongs_to :opinionable, polymorphic: true

  AGREEANCE_VALUES = {
     3 => "Very Strongly Agree",
     2 => "Strongly Agree",
     1 => "Agree",
     0 => "Neutral",
    -1 => "Disagree",
    -2 => "Strongly Disagree",
    -3 => "Very Strongly Disagree"
  }

  IMPORTANCE_VALUES = { 
    4 => "Very Important",
    3 => "Important",
    2 => "Neutral",
    1 => "Somewhat Important",
    0 => "Not Very Important"
  }

  def self.importance_values
    IMPORTANCE_VALUES.invert
  end

  def self.agreeance_values
    AGREEANCE_VALUES.invert
  end

  def self.stances_for_entity(entity)
    includes(statement: :issue_category).where(opinionable: entity).
      order("issue_categories.name")
  end

  def agreeance_value
    self[:agreeance_value] || 0
  end

  def importance_value
    self[:importance_value] || 2
  end

  def agreeance_value_string
    AGREEANCE_VALUES[agreeance_value]
  end

  def importance_value_string
    IMPORTANCE_VALUES[importance_value]
  end

  def issue_category
    statement.issue_category
  end
end

