module RepresentativeHelper
  def emails_or_contact_form_url(contact)
    ContactPresenter.new(contact).emails_or_contact_form_url
  end
end

