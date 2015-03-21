class Contact < ActiveRecord::Base
  has_many :postal_addresses, dependent: :destroy, inverse_of: :contact
  belongs_to :profile, inverse_of: :contact
end
