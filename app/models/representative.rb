class Representative < ActiveRecord::Base
  include PgSearch
  has_one :contact, dependent: :destroy, inverse_of: :representative
  has_many :stances, as: :opinionable
  belongs_to :user

  validates :first_name, :last_name, :slug, presence: true

  pg_search_scope :search_by_name, 
    against: [:first_name, :last_name, :nickname, :official_full_name],
    using: { tsearch: { prefix: true } }
end

