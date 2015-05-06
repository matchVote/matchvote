class User < ActiveRecord::Base
  before_save :default_values

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :inference_opinions, dependent: :destroy
  has_many :stances, as: :opinionable
  validates :username, presence: true

  def profile
    @profile ||= profile_type.constantize.find(profile_id)
  end

  private
    def default_values
      self.profile_type ||= "User"
      self.profile_id ||= id
    end
end
