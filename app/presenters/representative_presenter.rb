class RepresentativePresenter < SimpleDelegator
  include ActionView::Helpers

  def rep
    @rep ||= __getobj__
  end

  def full_name
    "#{nickname_or_first_name} #{last_name}"
  end

  def nickname_or_first_name
    nickname.blank? ? first_name.capitalize : nickname
  end

  def citizen_ratings_total
    number_with_delimiter(Random.rand(10_000), delimiter: ",")
  end

  def birthday_formatted
    Date.parse(birthday).strftime("%B %-d, %Y")
  end

  def government_role
    rep.government_role.blank? ? "N/A" : rep.government_role.capitalize
  end

  def branch
    rep.branch.blank? ? "N/A" : rep.branch.capitalize
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
    "https://facebook.com/#{rep.external_credentials["facebook_username"]}"
  end

  def twitter_url
    "https://twitter.com/#{rep.external_credentials["twitter_username"]}"
  end

  def youtube_url
    "https://youtube.com/#{rep.external_credentials["youtube_username"]}"
  end
end

