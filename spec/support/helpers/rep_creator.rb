module RepCreator
  include FactoryGirl::Syntax::Methods

  def create_searchable_reps
    [{ 
       first_name: "Jackson", 
       last_name:  "Franklin",
       nickname:   nil 
     }, {
       first_name: "Barbara", 
       last_name:  "Walters",
       nickname:   nil
     }, { 
       first_name: "David", 
       last_name:  "Sanders",
       nickname:   "Mannie" 
     }, { 
       first_name: "Louis", 
       last_name:  "Armstrong",
       nickname:   "Mannie" 
     }, { 
       first_name: "Albert", 
       last_name:  "Nunkle",
       nickname:   "Mannie" 
     }].each { |rep| create(:representative, rep) }
  end

  def create_sortable_reps
    [{ 
       first_name: "Bob", 
       last_name:  "Carpenter",
       nickname:   nil 
     }, {
       first_name: "Alice", 
       last_name:  "Carpenter",
       nickname:   nil
     }, { 
       first_name: "David", 
       last_name:  "Krusty",
       nickname:   nil
     }, { 
       first_name: "Buddy", 
       last_name:  "Rich",
       nickname:   nil 
     }, { 
       first_name: "Gene", 
       last_name:  "Krupa",
       nickname:   nil
     }].each { |rep| create(:representative, rep) }
  end
end

