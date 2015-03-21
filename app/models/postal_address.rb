class PostalAddress < ActiveRecord::Base
  belongs_to :contact, inverse_of: :postal_addresses
end
