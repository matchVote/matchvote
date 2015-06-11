class ContactPresenter < SimpleDelegator
  include ActionView::Helpers

  def contact
    @contact ||= __getobj__
  end

  def phone_numbers
    contact.phone_numbers || []
  end

  def phone_number
    phone_numbers.first
  end

  def emails_or_contact_form_url
    if emails.present?
      emails.map { |email| mail_to(email, email, target: "_blank") }
    elsif contact_form_url.present?
      [link_to(contact_form_url, contact_form_url, target: "_blank")]
    else 
      []
    end
  end
end

