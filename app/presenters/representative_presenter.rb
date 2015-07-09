class RepresentativePresenter < SimpleDelegator
  include ActionView::Helpers

  def initialize(rep, user = nil)
    @user = user
    super(rep)
  end

  def rep
    @rep ||= __getobj__
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

  def birthday_formatted
    Date.parse(birthday).strftime("%B %-d, %Y")
  end

  def birthday_datepicker_format
    birthday.split("-").reverse.join("/") if birthday
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
    rep.party.blank? ? "N/A" : rep.party.capitalize
  end

  def status
    rep.status.blank? ? "N/A" : rep.status.titleize
  end

  def orientation
    rep.orientation.blank? ? "N/A" : rep.orientation.capitalize
  end

  def religion
    rep.religion.blank? ? "N/A" : rep.religion.split.map(&:capitalize).join(' ')
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

  def overall_match_percent
    (rep.overall_match_percent(@user) * 100).round.to_s << "%"
  end

  # Forms
   
  def demographic_options
    @demographic_options ||= DemographicOptions.new
  end
end

