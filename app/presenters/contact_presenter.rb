class ContactPresenter < SimpleDelegator
  include ActionView::Helpers

  delegate :phone_number, to: :term

  def term
    @term ||= __getobj__
  end

  def address
    term.address || {}
  end

  def address_line1
    address["line1"]
  end

  def address_city_state_zip
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end

  def contact_url
    emails.present? ? emails.first : contact_form
  end
end

