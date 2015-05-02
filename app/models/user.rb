class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :inference_opinions, dependent: :destroy
  validates :username, presence: true

  def profile
    @profile ||= profile_type.constantize.find(profile_id)
  end
end
