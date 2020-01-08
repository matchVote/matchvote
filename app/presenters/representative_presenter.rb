class RepresentativePresenter < SimpleDelegator
  include ActionView::Helpers

  delegate :current_term, to: :rep

  def self.to_proc
    ->(rep) { new(rep) }
  end

  def initialize(rep, match_percent = 0)
    @match_percent = match_percent
    super(rep)
  end

  def rep
    @rep ||= __getobj__
  end

  def non_formatted
    rep
  end

  def contact
    @contact ||= ContactPresenter.new(rep.current_term)
  end

  def identifiers
    rep.identifiers || {}
  end

  def full_name
    "#{nickname_or_first_name} #{last_name}"
  end

  def nickname_or_first_name
    nickname.blank? ? first_name.split.map(&:capitalize).join(' ') : nickname
  end

  def citizen_ratings_total
    number_with_delimiter(Random.rand(10_000), delimiter: ",")
  end

  def birthday_formatter
    @birthday_formatter ||= DateFormatter.new(birthday)
  end

  def birthday_formatted
    birthday_formatter.pretty_format
  end

  def birthday_datepicker_format
    birthday_formatter.datepicker_format
  end

  def role
    if current_term&.role.blank?
      "N/A"
    else
      current_term.role.split.map(&:capitalize).join(" ")
    end
  end

  def branch
    current_term&.branch.blank? ? "N/A" : current_term.branch.capitalize
  end

  def party
    current_term&.party.blank? ? "N/A" : current_term.party.titleize
  end

  def state
    current_term&.state
  end

  def status
    rep.status.blank? ? "" : rep.status.titleize
  end

  def orientation
    rep.sexual_orientation.blank? ? "N/A" : rep.sexual_orientation.capitalize
  end

  def religion
    rep.religion.blank? ? "N/A" : rep.religion.titleize
  end

  def gender
    rep.gender.blank? ? "N/A" : rep.gender.capitalize
  end

  def age
    return "N/A" if rep.birthday.blank?

    ((Date.current - Date.parse(rep.birthday.to_s)) / 365).to_i
  end

  def facebook_url
    "https://facebook.com/#{identifiers['facebook']}"
  end

  def twitter_url
    "https://twitter.com/#{identifiers['twitter']}"
  end

  def youtube_url
    "https://youtube.com/#{identifiers['youtube']}"
  end

  def profile_image
    rep.profile_pic || default_image
  end

  def overall_match_percent
    (@match_percent * 100).round.to_s << "%"
  end

  # Forms

  def rep_options
    @rep_options ||= RepresentativeOptions.new
  end

  def demographic_options
    rep_options.demographic_options
  end

  def status_options
    rep_options.status_options
  end

  private

  def default_image
    ActionController::Base.helpers.asset_path("default.png")
  end
end
