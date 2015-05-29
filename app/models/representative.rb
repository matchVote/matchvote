class Representative < ActiveRecord::Base
  include PgSearch
  has_one :contact, as: :contactable, dependent: :destroy
  has_many :stances, as: :opinionable

  validates :first_name, :last_name, :slug, presence: true

  pg_search_scope :search_by_name, 
    against: [:first_name, :last_name, :nickname, :official_full_name],
    using: { tsearch: { prefix: true } }

  def update_or_create_contact(contact_params)
    if contact
      contact.update_attributes(contact_params)
    else
      update_attribute(:contact, Contact.create(contact_params))
    end
  end

  def update_credentials(hash)
    if external_credentials
      external_credentials.merge!(hash)
      save
    else
      update_attribute(:external_credentials, hash)
    end
  end
end

