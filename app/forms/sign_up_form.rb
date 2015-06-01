require "#{Rails.root}/lib/us_states"

class SignUpForm
  include ActiveModel::Model
  attr_accessor :username, :email, :contact_attributes, :personal_info, :profile_pic

  def contact
    @contact ||= ContactForm.new
  end

  def us_states
    USStates.all
  end

  def genders
    { Female: :female, Male: :male, Other: :other }
  end

  def ethnicities
    { White: :white,
      Hispanic: :hispanic,
      Black: :black,
      Asian: :asian,
      Native: :native,
      Mixed: :mixed,
      Other: :other }
  end

  def parties
    { "No Affiliation": :no_affiliation,
      Democrat: :democrat,
      Republican: :republican,
      Independent: :independent,
      Libertarian: :libertarian,
      Green: :green,
      Constitution: :constitution,
      Other: :other }
  end

  def education_levels
    { "Middle School": :middle_schoole,
      "Some High School": :some_high_school,
      "High School Diploma": :high_school_diploma,
      "Some College": :some_college,
      "Bachelors Degree": :bachelors_degree,
      "Masters Degree": :masters_degree,
      "Professional Degree": :professional_degree }
  end

  def religions
    { "No Affiliation": :no_affiliation,
      Protestant: :protestant,
      Catholic: :catholic,
      "Christian (other)": :christian,
      Agnostic: :agnostic,
      Atheist: :atheist,
      Jewish: :jewish,
      Muslim: :muslin,
      Buddhist: :buddhist,
      Hindu: :hindu,
      Other: :other }
  end

  def relationships
    { Single: :single,
      Married: :married,
      Widowed: :widowed,
      Divorced: :divorced,
      Separated: :separated,
      Other: :other }
  end
end

