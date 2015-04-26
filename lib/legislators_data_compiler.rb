require_relative "address_parser"
require_relative "wikipedia_service"
require_relative "slug"

class LegislatorsDataCompiler
  def initialize(rep_data, social_ids)
    @rep_data = rep_data
    @external_ids = extract_ids(social_ids)
    @latest_term = find_latest_term(rep_data["terms"])
  end

  def compile_attributes
    name.merge!(bio).
      merge!(terms).
      merge!(contact).
      merge!(external_credentials)
  end

  def generate_slug
    first_name = rep_data["name"]["nickname"] || rep_data["name"]["first"]
    Slug.generate(first_name, rep_data["name"]["last"])
  end

  def first_name_sanitized
    I18n.transliterate(rep_data["name"]["first"])
  end

  def last_name_sanitized
    I18n.transliterate(rep_data["name"]["last"])
  end

  def name
    { official_full_name: rep_data["name"]["official_full"],
      first_name: first_name_sanitized,
      last_name: last_name_sanitized,
      middle_name: rep_data["name"]["middle"], 
      nickname: rep_data["name"]["nickname"],
      suffix: rep_data["name"]["suffix"] }
  end

  def bio
    { birthday: rep_data["bio"]["birthday"],
      gender: genderize(rep_data["bio"]["gender"]),
      religion: sanitize(rep_data["bio"]["religion"]) }
  end

  def terms
    { party: latest_term["party"], 
      state: latest_term["state"],
      status: :in_office,
      state_rank: latest_term["state_rank"],
      branch: :legislative,
      seniority_date: find_first_term(rep_data["terms"])["start"],
      government_role: expand_type(latest_term["type"]) }
  end

  def contact
    { contact: Contact.create(
        contact_form_url: latest_term["contact_form"],
        phone_numbers: Array(latest_term["phone"]),
        emails: [],
        website_url: latest_term["url"],
        postal_addresses: Array(create_postal_address(latest_term["address"]))) }
  end

  def external_credentials
    { bioguide_id: rep_data["id"]["bioguide"],
      external_credentials: { 
        thomas_id: rep_data["id"]["thomas"],
        lis_id: rep_data["id"]["lis"],
        govtrack_id: rep_data["id"]["govtrack"],
        opensecrets_id: rep_data["id"]["opensecrets"],
        votesmart_id: rep_data["id"]["votesmart"],
        fec_ids: rep_data["id"]["fec"].join(","),
        cspan_id: rep_data["id"]["cspan"],
        wikipedia_id: find_wikipedia_search_string,
        house_history_id: rep_data["id"]["house_history"],
        ballotpedia_id: rep_data["id"]["ballotpedia"],
        maplight_id: rep_data["id"]["maplight"],
        washington_post_id: rep_data["id"]["washington_post"],
        icpsr_id: rep_data["id"]["icpsr"],
        twitter_username: external_ids["twitter"],
        youtube_username: external_ids["youtube"],
        youtube_id: external_ids["youtube_id"],
        facebook_username: external_ids["facebook"],
        facebook_id: external_ids["facebook_id"],
        instagram_username: external_ids["instagram"],
        instagram_id: external_ids["instagram_id"],
        rss_url: external_ids["rss_url"] } }
  end

  private
    attr_reader :rep_data, :external_ids, :latest_term

    def extract_ids(social_ids)
      social_ids.reduce({}) { |hash, id| hash.merge!(id["social"]) }
    end

    def find_latest_term(terms)
      terms.sort { |a, b| b["start"] <=> a["start"] }.first
    end

    def find_first_term(terms)
      terms.sort { |a, b| a["start"] <=> b["start"] }.first
    end

    def sanitize(value)
      value.downcase unless value.nil?
    end

    def find_wikipedia_search_string
      search_string = rep_data["id"]["wikipedia"]
      if search_string.blank?
        "#{first_name_sanitized.capitalize} #{last_name_sanitized.capitalize}"
      else
        search_string
      end
    end

    def genderize(gender)
      case gender
      when /M/i then "Male"
      when /F/i then "Female"
      else "Unicorn"
      end
    end

    def expand_type(type)
      case type
      when "sen" then "Senator"
      when "rep" then "Representative"
      end
    end

    def create_postal_address(address_string)
      PostalAddress.create(AddressParser.parse_attributes(address_string))
    end
end

