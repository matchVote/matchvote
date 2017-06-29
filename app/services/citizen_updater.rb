class CitizenUpdater
  attr_reader :citizen

  def initialize(citizen)
    @citizen = citizen
  end

  def update_contact_info(contact_params)
    citizen.build_contact unless citizen.contact
    contact_params[:external_ids].reverse_merge!(citizen.contact.external_ids || {})
    citizen.contact.update!(contact_params)
  end

  def update_personal_info(personal_info)
    personal_info.reverse_merge!(citizen.personal_info || {})
    citizen.update!(personal_info: personal_info)
  end

  def update_settings(settings)
    type = settings.delete(:type).to_sym
    citizen.settings(type).update!(settings)
  end

  def upgrade_account
    citizen.account.update!(account_type: :premium)
    :premium
  end
end

