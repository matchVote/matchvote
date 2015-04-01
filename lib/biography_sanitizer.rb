class BiographySanitizer
  def initialize(bio_string)
    @bio = bio_string
  end

  def sanitize
    @bio.split("\n").reject { |line| line.match(/\^/) }.join("\n")
  end
end

