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

  def initialize(reps: nil, sort_by: default_sort)
    @sort_by = sort_by.present? ? sort_by : default_sort
    @reps = reps
  end

  def reps
    present(sort_reps(@reps))
  end

  def sort_reps(reps)
    RepSorter.new(reps).send(@sort_by)
  end

  def present(reps)
    reps.map { |rep| RepresentativePresenter.new(rep) }
  end

  private
    def default_sort
      :popularity
    end
end

