class Contact < ActiveRecord::Base
  has_many :postal_addresses, dependent: :destroy, inverse_of: :contact
  belongs_to :representative, inverse_of: :contact
end
