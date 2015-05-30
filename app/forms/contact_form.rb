class ContactForm
  include ActiveModel::Model
  attr_accessor :phone_numbers, :postal_addresses_attributes, :twitter, :external_ids

  def postal_addresses
    @pa ||= [PostalAddress.new]
  end
end

