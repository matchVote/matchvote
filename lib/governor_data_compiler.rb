class GovernorDataCompiler
  attr_reader :governor

  def initialize(governor)
    @governor = governor
  end

  def generate_slug
    Slug.generate(governor["first_name"], governor["last_name"])
  end

  def compile_attributes
    { first_name: governor["first_name"],
      last_name: governor["last_name"],
      state: governor["state"],
      title: governor["title"],
      party: find_party(governor["party"]),
      gender: governor["gender"],
      birthday: governor["birthday"],
      religion: governor["religion"],
      orientation: governor["orientation"],
      external_credentials: { 
        facebook_username: governor["facebook"],
        twitter_username: governor["twitter"],
        youtube_username: governor["youtube"],
        wikipedia_id: governor["wiki"].split("/").last },
      contact: Contact.create(
        emails: Array(governor["email"]),
        phone_numbers: [governor["fax"], governor["tel"]],
        website_url: governor["web"],
        postal_addresses: Array(parse_address(governor["address"]))) }
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
      parts = address.split(",")
      PostalAddress.create(
        line1: parts[0],
        line2: parts[1],
        city: parts[2],
        state: parts[3],
        zip: parts[4])
    end
end

