class PostalAddress < ActiveRecord::Base
  belongs_to :contact, inverse_of: :postal_addresses

  def full_street
    "#{street_number} #{street_name}"
  end

  def city_state_zip
    "#{city}, #{state} #{zip}"
  end
end
