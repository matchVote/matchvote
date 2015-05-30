require "#{Rails.root}/lib/us_states"

class SignUpForm
  include ActiveModel::Model
  attr_accessor :username, :email, :contact_attributes

  def contact
    @contact ||= ContactForm.new
  end

  def us_states
    USStates.all
  end
end

