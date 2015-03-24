class AddressParser
  def self.parse_attributes(address_string)
    match = address_string.downcase.match(/\A(\d+\w*)\s(.+)\s(.+)\s(.+)\s(\d{5})\z/i)
    p address_string if match.nil?

    { street_number: match[1],
      street_name: match[2].split.map(&:capitalize).join(" "),
      city: match[3].capitalize,
      state: match[4].upcase,
      zip: match[5] }
  end
end

