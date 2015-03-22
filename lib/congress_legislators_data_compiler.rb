class CongressLegislatorsDataCompiler
  def initialize(rep_data, social_ids)
    @rep_data = rep_data
    @external_ids = find_external_ids(social_ids, rep_data["id"])
    @latest_term = find_latest_term(rep_data["terms"])
  end

  def compile_attributes
    name.merge!(bio).
      merge!(terms).
      merge!(external_credentials).
      merge!(contact)
  end

  def name
    { middle_names: rep_data["name"]["middle"], 
      nickname: rep_data["name"]["nickname"],
      suffix: rep_data["name"]["suffix"] }
  end

  def contact
    { contact: Contact.create(
        contact_form_url: latest_term["contact_form"],
        phone_numbers:    Array(latest_term["phone"]))
    }
        # postal_addresses: Array(PostalAddress.parse(latest_term["address"]))) }
  end

  def bio
    { birthday: rep_data["bio"]["birthday"],
      gender:   genderize(rep_data["bio"]["gender"]),
      biography: "To Be Added...",
      religion: sanitize(rep_data["bio"]["religion"]) }
  end

  def terms
    { party: latest_term["party"], 
      state: latest_term["state"],
      status: "In Office",
      state_rank: latest_term["state_rank"],
      branch: "Legislative",
      government_role: expand_type(latest_term["type"]) }
  end

  def external_credentials
    { external_credentials: { 
        bioguide_id: rep_data["id"]["bioguide"],
        thomas_id: rep_data["id"]["thomas"],
        lis_id: rep_data["id"]["lis"],
        govtrack_id: rep_data["id"]["govtrack"],
        opensecrets_id: rep_data["id"]["opensecrets"],
        votesmart_id: rep_data["id"]["votesmart"],
        fec_ids: Array(rep_data["id"]["fec"]),
        cspan_id: rep_data["id"]["cspan"],
        wikipedia_id: rep_data["id"]["wikipedia"],
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
        instagram_id: external_ids["instagram_id"] } }
  end

  private
    attr_reader :rep_data, :external_ids, :latest_term

    def sanitize(value)
      value.nil? ? "N/A" : value
    end

    def find_external_ids(social_ids, rep_ids)
      hash = social_ids.find do |id| 
        id["id"]["bioguide"] == rep_ids["bioguide"] &&
          id["id"]["thomas"] == rep_ids["thomas"] &&
          id["id"]["govtrack"] == rep_ids["govtrack"]
      end
      hash ? hash["social"] : {}
    end

    def genderize(gender)
      case gender
      when /M/i then "Male"
      when /F/i then "Female"
      else "Unicorn"
      end
    end

    def find_latest_term(terms)
      terms.sort { |a, b| b["start"] <=> a["start"] }.first
    end

    def expand_type(type)
      case type
      when "sen" then "Senator"
      when "rep" then "Representative"
      else "N/A"
      end
    end
end

