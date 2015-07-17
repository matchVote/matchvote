class CitizenPresenter < SimpleDelegator
  def initialize(citizen)
    super(CitizenDecorator.new(citizen))
  end

  def contact
    @contact ||= ContactPresenter.new(__getobj__.contact || Contact.new)
  end

  def subtitle
    return "" unless address.state.present?
    "Voter from #{address.state}".tap do |s| 
      s.prepend("#{party_formatted} ") if party_formatted.present?
    end
  end

  def display_all_stances?
    settings(:privacy).display_all_stances == "true"
  end

  # Personal Info

  def name
    full_name.blank? ? username : full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def party_formatted
    (party || "").titleize
  end

  # Contact Info

  def address
    contact.postal_addresses.first || NullObject.new
  end

  def phone_number
    contact.phone_number
  end

  def twitter_username
    contact.twitter_username
  end

  # Forms

  def demographic_options
    @demographic_options ||= DemographicOptions.new
  end
end

