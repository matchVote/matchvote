class PostalAddress < ActiveRecord::Base
  belongs_to :contact, inverse_of: :postal_addresses

  def self.parse(address_string)
  end
end
