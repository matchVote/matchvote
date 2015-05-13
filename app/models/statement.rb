class Statement < ActiveRecord::Base
  has_many :stances, dependent: :destroy
  belongs_to :issue_category
  validates :text, uniqueness: true, presence: true

  def find_stance_for_user(user)
    stances.find_by(opinionable: user)
  end
end
