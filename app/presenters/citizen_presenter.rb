class CitizenPresenter < SimpleDelegator
  def initialize(user)
    super(CitizenDecorator.new(user))
  end

  def citizen
    @citizen ||= __getobj__
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

  def address
    contact.postal_addresses.first || NullObject.new
  end

  # Personal Info

  def name
    full_name.blank? ? username : full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def party_formatted
    (citizen.party || "").capitalize
  end

  # Forms

  def personal_info_form
    @personal_info_form ||= PersonalInfoForm.new
  end
end

