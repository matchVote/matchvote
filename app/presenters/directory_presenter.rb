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

  def initialize(sort_by: :popularity, search_name: nil)
    @sort_by = sort_by
    @name = search_name
  end

  def search_reps
    Representative.search_name(@name)
  end

  def sort_reps(reps)
    RepSorter.new(reps).send(@sort_by)
  end

  def reps
    present(sort_reps(search_reps))
  end

  def present(reps)
    reps.map { |rep| RepresentativePresenter.new(rep) }
  end

  private
    def query_string
      "first_name @@ :name or last_name @@ :name or nickname @@ :name "+ 
        "or official_full_name @@ :name"
    end
end

