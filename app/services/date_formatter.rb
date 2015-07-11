class DateFormatter
  def initialize(birthday)
    @birthday = birthday || ""
  end

  def datepicker_to_standard
    date = @birthday.split("/")
    "#{date[2]}-#{date[0]}-#{date[1]}"
  end

  def datepicker_format
    date = @birthday.split("-")
    "#{date[1]}/#{date[2]}/#{date[0]}"
  end

  def pretty_format
    Date.parse(@birthday).strftime("%B %-d, %Y")
  end
end

