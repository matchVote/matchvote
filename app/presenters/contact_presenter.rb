class ContactPresenter < SimpleDelegator
  include ActionView::Helpers

  def contact
    @contact ||= __getobj__
  end

  def phone_numbers
    contact.phone_numbers || []
  end

  def external_ids
    contact.external_ids || {}
  end

  def phone_number
    phone_numbers.first
  end

  def twitter_username
    external_ids["twitter_username"]
  end

  def contact_url
    emails.present? ? emails.first : contact_form_url
  end
end

