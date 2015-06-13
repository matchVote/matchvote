class CitizenUpdater
  attr_reader :citizen

  def initialize(citizen)
    @citizen = citizen
  end

  def update_contact(contact_params)
    contact_params[:external_ids].reverse_merge!(citizen.contact.external_ids || {})
    citizen.contact.update!(contact_params)
  end
end

