require "#{Rails.root}/lib/us_states"

class SignUpForm
  include ActiveModel::Model
  attr_accessor :username, :email, :contact_attributes, :personal_info, :profile_pic

  def contact
    @contact ||= ContactForm.new
  end

  def personal_info_form
    @personal_info_form ||= PersonalInfoForm.new
  end

  def us_states
    USStates.all
  end

  def genders
    personal_info_form.genders
  end

  def ethnicities
    personal_info_form.ethnicities
  end

  def parties
    personal_info_form.parties
  end

  def education_levels
    personal_info_form.education_levels
  end

  def religions
    personal_info_form.religions
  end

  def relationships
    personal_info_form.relationships
  end
end

