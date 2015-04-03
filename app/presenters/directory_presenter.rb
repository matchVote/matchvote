class DirectoryPresenter
  def self.sort_list
    [["Sort by Name Recognition", "popularity"],
     ["Sort Alphabetically", "alphabetically"],
     ["Sort by Most Similar Views", "similarity"],
     ["Sort by Least Similar Views", "difference"],
     ["Sort by Approval Rating", "approval"],
     ["Sort by Seniority", "seniority"],
     ["Sort by Age", "age"],
     ["Sort by State", "state"]]
  end

  def initialize(sort_reps_by: :popularity)
    @reps = present(RepSorter.send(sort_reps_by))
  end

  def all_reps
    @reps
  end

  def present(reps)
    reps.map { |rep| RepresentativePresenter.new(rep) }
  end
end

