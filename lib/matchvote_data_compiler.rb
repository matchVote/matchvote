class MatchvoteDataCompiler
  attr_reader :rep

  def initialize(rep)
    @rep = rep
  end

  def generate_slug
    Slug.generate(rep["first_name"], rep["last_name"])
  end

  def compile_attributes
    { first_name: rep["first_name"],
      last_name: rep["last_name"],
      state: rep["state"],
      title: rep["title"],
      party: find_party(rep["party"]),
      gender: rep["gender"],
      birthday: rep["birthday"],
      religion: rep["religion"],
      orientation: rep["orientation"],
      profile_image_url: rep["profile_pic"],
      status: rep["rep_status"],
      external_credentials: { 
        facebook_username: parse_id(rep["facebook"]),
        twitter_username: parse_id(rep["twitter"]),
        youtube_username: parse_id(rep["youtube"]),
        wikipedia_id: parse_id(rep["wiki"]) },
      contact: Contact.create(
        emails: Array(rep["email"]),
        phone_numbers: [rep["fax"], rep["tel"]],
        website_url: rep["web"],
        postal_addresses: Array(parse_address(rep["address"]))) }
  end

  private
    def find_party(party)
      case party.upcase
      when "R" then "Republican"
      when "D" then "Democrat"
      when "I" then "Independent"
      else "Unknown"
      end
    end

    def parse_address(address)
      parts = NullObject.nullify(address, []).split(",").map(&:strip)
      PostalAddress.create(
        line1: parts[0],
        line2: parts[1],
        city: parts[2],
        state: parts[3],
        zip: parts[4])
    end

    def parse_id(url)
      NullObject.nullify(url).split("/").last
    end
end

