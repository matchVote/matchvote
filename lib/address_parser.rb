class AddressParser
  ADDRESS_REGEX = /\A(\w+)\s(.+)\s(\w+)\s(\w{2})\s(\d{5}(-\d{4})?)\z/

  def self.parse_attributes(address_string)
    match = address_string.downcase.match(ADDRESS_REGEX)

    { street_number: match[1].upcase,
      street_name: match[2].split.map(&:capitalize).join(" "),
      city: match[3].capitalize,
      state: match[4].upcase,
      zip: match[5] }
  end
end

