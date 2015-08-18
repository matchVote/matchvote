class Representative < ActiveRecord::Base
  include PgSearch
  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact, reject_if: :all_blank
  has_many :stances, as: :opinionable

  validates :first_name, :last_name, :slug, presence: true

  pg_search_scope :search_by_name,
    against: [:first_name, :last_name, :middle_name, :nickname, :official_full_name],
    using: { tsearch: { prefix: true } }

  def update_or_create_contact(contact_params)
    contact ? contact.update!(contact_params) : create_contact!(contact_params)
  end

  def update_external_ids(hash)
    if contact
      ids = contact.external_ids || {}
      contact.update!(external_ids: ids.merge(hash))
    end
  end
end

