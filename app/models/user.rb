class User < ActiveRecord::Base
  before_save :default_values
  after_create :create_default_account  # because user creation is handled by Devise
  mount_uploader :profile_pic, ProfilePicUploader

  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact, reject_if: :all_blank
  has_many :inference_opinions, dependent: :destroy
  has_many :stances, as: :opinionable
  has_many :comments, dependent: :destroy
  has_one :account, dependent: :destroy
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_reps, through: :relationships, source: :followed

  validates :username, presence: true, uniqueness: true
  validate :username_has_no_whitespace

  has_settings do |s|
    s.key :privacy, defaults: { display_all_stances: "true" }
  end

  def profile
    @profile ||= profile_type.constantize.find(profile_id)
  end

  def to_param
    "#{username}"
  end

  def account_type
    account.account_type
  end

  def following?(rep)
    Relationship.exists?(follower: self, followed: rep)
  end

  private

  def default_values
    self.profile_type ||= "User"
    self.profile_id ||= id
  end

  def username_has_no_whitespace
    errors.add(:username, "can't have spaces.") if username.match(/\s/)
  end

  def create_default_account
    create_account(account_type: :standard)
  end
end
