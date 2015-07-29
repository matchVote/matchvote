class MatchCalculator
  WEIGHTS = { 0 => 1, 1 => 10, 2 => 25 }

  def initialize(stances1, stances2)
    @one = stances1
    @two = stances2
  end

  def overall_percent
    results = calculate_totals_for_shared_stances
    one_percent_match = results[:one][:score] / results[:one][:importance_total].to_f
    two_percent_match = results[:two][:score] / results[:two][:importance_total].to_f
    match = (one_percent_match * two_percent_match) ** (1.0 / results[:stance_count])
    match.nan? ? 0 : match
  end

  def calculate_totals_for_shared_stances
    shared_stances.reduce(initial_hash) do |acc, stances|
      if stances.count == 2
        one = stances.first
        two = stances.last

        acc[:one][:importance_total] += two_weighted = WEIGHTS[two.importance_value]
        acc[:two][:importance_total] += one_weighted = WEIGHTS[one.importance_value]

        if one.agreeance_value == two.agreeance_value
          acc[:one][:score] += two_weighted
          acc[:two][:score] += one_weighted
        end

        acc[:stance_count] += 1
      end
      acc
    end
  end

  def shared_stances
    (@one + @two).group_by(&:statement_id).values
    # Stance.where(opinionable_id: [@one.id, @two.id]).
    #   group_by(&:statement_id).values
  end

  private
    def initial_hash
      { one: { importance_total: 0, score: 0 },
        two: { importance_total: 0, score: 0 },
        stance_count: 0 }
    end
end

