class Representative < ActiveRecord::Base
  has_one :contact, dependent: :destroy, inverse_of: :representative
  has_many :stances, as: :opinionable
  belongs_to :user

  validates :first_name, :last_name, :slug, presence: true

  def self.search_name(string)
    query_string = "first_name @@ :str or last_name @@ :str or nickname @@ :str "+ 
                   "or official_full_name @@ :str"
    where(query_string, str: string) if string.present?
  end
end

