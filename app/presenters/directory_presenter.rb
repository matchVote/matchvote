class DirectoryPresenter
  def self.sort_list
    [["Sort by Name Recognition", "populatity"],
     ["Sort Alphabetically", "alphabetically"],
     ["Sort by Most Similar Views", "similarity"],
     ["Sort by Least Similar Views", "difference"],
     ["Sort by Approval Rating", "approval"],
     ["Sort by Seniority", "seniority"],
     ["Sort by Age", "age"],
     ["Sort by State", "state"]]
  end
end
