class RepSorter
  attr_reader :reps

  def initialize(reps)
    @reps = reps
  end

  def alphabetically
    reps.reorder(:last_name, :first_name)
  end

  def popularity
    reps.reorder(name_recognition: :desc)
  end

  def age
    reps.reorder(birthday: :desc)
  end

  def seniority
    reps.reorder(:seniority_date, :slug)
  end

  def method_missing(*args)
    []
  end
end

