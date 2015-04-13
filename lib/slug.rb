module Slug
  module_function

  def generate(first_name, last_name)
    first = sanitize(first_name)
    last = sanitize(last_name)
    "#{first}-#{last}".downcase.gsub(/[\s']/, "-").tr(".", "")
  end

  def sanitize(name)
    I18n.transliterate(name)
  end
end

