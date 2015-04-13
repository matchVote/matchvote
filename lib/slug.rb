module Slug
  module_function

  def generate(string1, string2)
    first = sanitize(string1)
    last = sanitize(string2)
    "#{first}-#{last}".downcase.gsub(/[\s']/, "-").tr(".", "")
  end

  def sanitize(string)
    I18n.transliterate(string)
  end
end

