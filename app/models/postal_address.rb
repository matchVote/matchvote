class PostalAddress < ActiveRecord::Base
  belongs_to :contact, inverse_of: :postal_addresses

  def self.parse(address_string)
    AddressParser.parse(address_string)
  end

  def city_state_zip
    "#{city}, #{state} #{zip}"
  end
end

