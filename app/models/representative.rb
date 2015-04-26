class Representative < ActiveRecord::Base
  include PgSearch
  has_one :contact, dependent: :destroy, inverse_of: :representative
  has_many :stances, as: :opinionable
  belongs_to :user

  validates :first_name, :last_name, :slug, presence: true

  pg_search_scope :search_by_name, 
    against: [:first_name, :last_name, :nickname, :official_full_name],
    using: { tsearch: { prefix: true } }

  def update_or_create_contact(contact_params)
    if contact
      contact.update_attributes(contact_params)
    else
      self.contact = Contact.create(contact_params)
      save
    end
  end

  def update_credentials(hash)
    if external_credentials
      external_credentials.merge!(hash)
    else
      self.external_credentials = hash
    end
    save
  end
end

