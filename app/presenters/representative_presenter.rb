class RepresentativePresenter < SimpleDelegator
  include ActionView::Helpers

  def self.to_proc
    -> (rep) { self.new(rep) }
  end

  def initialize(rep, match_percent = 0)
    @match_percent = match_percent
    super(rep)
  end

  def rep
    @rep ||= __getobj__
  end

  def react_hash
    rep.as_json.merge(
      full_name: full_name,
      overall_match_percent: overall_match_percent)
  end

  def non_formatted
    rep
  end

  def contact
    @contact ||= ContactPresenter.new(rep.contact)
  end

  def external_ids
    contact.external_ids || {}
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

  def government_role
    if rep.government_role.blank?
      "N/A"
    else
      rep.government_role.split.map(&:capitalize).join(" ")
    end
  end

  def branch
    rep.branch.blank? ? "N/A" : rep.branch.capitalize
  end

  def party
    rep.party.blank? ? "N/A" : rep.party.titleize
  end

  def status
    rep.status.blank? ? "N/A" : rep.status.titleize
  end

  def orientation
    rep.orientation.blank? ? "N/A" : rep.orientation.capitalize
  end

  def religion
    rep.religion.blank? ? "N/A" : rep.religion.titleize
  end

  def gender
    rep.gender.blank? ? "N/A" : rep.gender.capitalize
  end

  def age
    ((Date.current - Date.parse(rep.birthday)) / 365).to_i
  end

  def facebook_url
    "https://facebook.com/#{external_ids["facebook_username"]}"
  end

  def twitter_url
    "https://twitter.com/#{external_ids["twitter_username"]}"
  end

  def youtube_url
    "https://youtube.com/#{external_ids["youtube_username"]}"
  end

  def profile_image_url
    return rep.profile_image_url if rep.profile_image_url
    'default.png'
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
end
