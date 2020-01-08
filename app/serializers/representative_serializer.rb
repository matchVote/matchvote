class RepresentativeSerializer
  attr_reader :data

  def initialize(official)
    @official = RepresentativePresenter.new(official)
    @added = {}
  end

  def add(values)
    added.merge(values)
    self
  end

  def as_json
    official.as_json
      .merge(added)
      .merge(
        full_name: official.full_name,
        overall_match_percent: official.overall_match_percent,
        role: official.role,
        state: official.state,
        profile_image: official.profile_image,
      )
  end

  private

  attr_reader :official, :added
end
