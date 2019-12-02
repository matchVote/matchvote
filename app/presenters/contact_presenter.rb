class ContactPresenter < SimpleDelegator
  include ActionView::Helpers

  delegate :phone_number, :contact_form, to: :term

  def term
    @term ||= __getobj__ || NullTerm.new
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
end

class NullTerm
  def address
    {}
  end

  def phone_number
    nil
  end

  def contact_form
    nil
  end
end
