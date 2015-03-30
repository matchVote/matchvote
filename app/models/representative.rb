class Representative < ActiveRecord::Base
  has_one :contact, dependent: :destroy, inverse_of: :representative
  has_many :stances, as: :opinionable
  belongs_to :user

  validates :first_name, :last_name, presence: true

  def profile_id
    "#{first_name}-#{last_name}"
  end
end
