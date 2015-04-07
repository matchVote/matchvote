class RepSorter
  attr_reader :reps

  def initialize(reps = nil)
    @reps = reps || Representative.all
  end

  def alphabetically
    reps.order(:last_name, :first_name)
  end

  def popularity
    reps.order(name_recognition: :desc)
  end

  def age
    reps.order(birthday: :desc)
  end

  def seniority
    reps.order(:seniority_date, :slug)
  end

  def method_missing(*args)
    []
  end
end

