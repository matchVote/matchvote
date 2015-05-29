class Contact < ActiveRecord::Base
  has_many :postal_addresses, dependent: :destroy, inverse_of: :contact
  accepts_nested_attributes_for :postal_addresses
  belongs_to :contactable, polymorphic: true
end
