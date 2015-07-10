class BirthdayFormatter
  def initialize(birthday)
    @birthday = birthday || ""
  end

  def datepicker_to_standard
    @birthday.split("/").reverse.join("-")
  end

  def datepicker_format
    @birthday.split("-").reverse.join("/")
  end

  def pretty_format
    Date.parse(@birthday).strftime("%B %-d, %Y")
  end
end

