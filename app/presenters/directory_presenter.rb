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

  def initialize(sort_by: :popularity)
    @sort_by = sort_by
  end

  def reps
    present(RepSorter.send(@sort_by))
  end

  def present(reps)
    reps.map { |rep| RepresentativePresenter.new(rep) }
  end
end

