class RepSorter
  def self.method_missing(*args)
    []
  end

  def self.default
    Representative.all
  end

  def self.alphabetically
    Representative.order(:last_name, :first_name)
  end

  def self.popularity
    Representative.order(name_recognition: :desc)
  end

  def self.age
    Representative.order(birthday: :desc)
  end

  def self.seniority
    Representative.order(:seniority_date, :slug)
  end
end

