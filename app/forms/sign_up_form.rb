require "#{Rails.root}/lib/us_states"

class SignUpForm
  include ActiveModel::Model
  attr_accessor :username, :email

  def contact
    @contact ||= ContactForm.new
  end

  def contact_attributes=(attrs)
  end

  def us_states
    USStates.all
  end
end

