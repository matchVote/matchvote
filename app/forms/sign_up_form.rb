require "#{Rails.root}/lib/us_states"

class SignUpForm
  include ActiveModel::Model
  attr_accessor :username, :email, :contact_attributes, :personal_info, :profile_pic

  def contact
    @contact ||= ContactForm.new
  end

  def demographic_options
    @demographic_options ||= DemographicOptions.new
  end

  def us_states
    USStates.all
  end

  def genders
    demographic_options.genders
  end

  def ethnicities
    demographic_options.ethnicities
  end

  def parties
    demographic_options.parties
  end

  def education_levels
    demographic_options.education_levels
  end

  def religions
    demographic_options.religions
  end

  def relationships
    demographic_options.relationships
  end
end

