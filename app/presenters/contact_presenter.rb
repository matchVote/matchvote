class ContactPresenter < SimpleDelegator
  include ActionView::Helpers

  def emails_or_contact_form_url
    if emails.present?
      emails.map { |email| mail_to(email, email, target: "_blank") }
    elsif contact_form_url.present?
      [link_to(contact_form_url, contact_form_url, target: "_blank")]
    end
  end
end

