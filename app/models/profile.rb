class Profile < ActiveRecord::Base
  has_one :contact, dependent: :destroy, inverse_of: :profile
  belongs_to :user, inverse_of: :profile

  validates :first_name, :last_name, presence: true
end
