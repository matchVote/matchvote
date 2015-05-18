class StancesPresenter
  attr_reader :stances

  def initialize(stances)
    @stances = stances
  end

  def issues
    @issues ||= stances.reduce([]) { |issues, stance|
      issues << stance.issue_category
    }.uniq
  end

  def stances_for_issue(issue)
    stances.select { |stance| stance.issue_category == issue }
  end

  def has_stances?
    stances.present?
  end
end

