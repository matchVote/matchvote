class CitizenPresenter < SimpleDelegator
  def personal_info
    __getobj__.personal_info || {}
  end

  def contact
    @contact ||= ContactPresenter.new(__getobj__.contact || Contact.new)
  end

  def name
    full_name.blank? ? username : full_name
  end

  def full_name
    "#{personal_info["first_name"]} #{personal_info["last_name"]}"
  end

  def bio
    personal_info["bio"]
  end

  def party
    (personal_info["party"] || "").capitalize
  end

  def subtitle
    return "" unless address.state.present?
    "Voter from #{address.state}".tap do |s| 
      s.prepend("#{party} ") if party.present?
    end
  end

  def address
    contact.postal_addresses.first || NullObject.new
  end
end

