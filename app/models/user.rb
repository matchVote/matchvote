class User < ActiveRecord::Base
  before_save :default_values
  mount_uploader :profile_pic, ProfilePicUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact, reject_if: :all_blank
  has_many :inference_opinions, dependent: :destroy
  has_many :stances, as: :opinionable
  validates :username, presence: true, uniqueness: true
  validate :username_has_no_whitespace

  has_settings do |s|
    s.key :privacy, defaults: { display_all_stances: true }
  end

  def profile
    @profile ||= profile_type.constantize.find(profile_id)
  end

  def to_param
    "#{username}"
  end
  
  private
    def default_values
      self.profile_type ||= "User"
      self.profile_id ||= id
    end

    def username_has_no_whitespace
      errors.add(:username, "can't have spaces.") if username.match(/\s/)
    end
end
