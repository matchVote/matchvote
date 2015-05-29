class ContactForm
  include ActiveModel::Model

  attr_accessor :phone_numbers

  def postal_addresses
    @pa ||= [PostalAddress.new]
  end

  def postal_addresses_attributes=(attrs)
  end
end
