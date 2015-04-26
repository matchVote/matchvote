class AddressParser
  ADDRESS_REGEX = /\A(.+)\s(\w+)\s(\w{2})\s(\d{5}(-\d{4})?)\z/

  def self.parse_attributes(address_string)
    match = address_string.downcase.match(ADDRESS_REGEX)

    { line1: capitalize_words(match[1]),
      city: capitalize_words(match[2]),
      state: match[3].upcase,
      zip: match[4] }
  end

  def self.capitalize_words(string)
    string.split.map(&:capitalize).join(" ")
  end
end

