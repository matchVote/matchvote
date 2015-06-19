class Contact < ActiveRecord::Base
  has_many :postal_addresses, dependent: :destroy, inverse_of: :contact
  accepts_nested_attributes_for :postal_addresses, reject_if: :all_blank
  belongs_to :contactable, polymorphic: true
end
