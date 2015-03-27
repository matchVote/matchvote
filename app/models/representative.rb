class Representative < ActiveRecord::Base
  has_one :contact, dependent: :destroy, inverse_of: :representative
  has_many :stances, as: :opinionable
  belongs_to :user

  validates :first_name, :last_name, presence: true

  def full_name
    "#{nickname_or_first_name.capitalize} #{last_name.capitalize}"
  end

  def profile_id
    "#{first_name}-#{last_name}"
  end

  def nickname_or_first_name
    nickname.blank? ? first_name : nickname
  end
end
