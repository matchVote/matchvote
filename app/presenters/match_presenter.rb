class MatchPresenter
  def initialize(user, rep)
    @calculator = MatchCalculator.new(user, rep)
  end

  def overall_percent
    (@calculator.overall_percent * 100).round.to_s << "%"
  end
end

