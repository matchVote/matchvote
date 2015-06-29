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
       nickname:   nil,
       name_recognition: 1234,
       birthday: "1944-12-03",
       seniority_date: "1967-03-01",
       state: "NC"
     }, {
       first_name: "Alice", 
       last_name:  "Carpenter",
       nickname:   nil,
       name_recognition: 0,
       birthday: "1967-03-01",
       seniority_date: "1944-12-03",
       state: "WY"
     }, { 
       first_name: "David", 
       last_name:  "Krusty",
       nickname:   nil,
       name_recognition: 44,
       birthday: "1973-11-11",
       seniority_date: "1967-03-02",
       state: "AK"
     }, { 
       first_name: "Buddy", 
       last_name:  "Rich",
       nickname:   nil,
       name_recognition: 2,
       birthday: "1967-03-02",
       seniority_date: "1973-01-09",
       state: "OK"
     }, { 
       first_name: "Gene", 
       last_name:  "Krupa",
       nickname:   nil,
       name_recognition: 923,
       birthday: "1973-01-09",
       seniority_date: "1973-11-11",
       state: "OK"
     }].each { |rep| create(:representative, rep) }
  end
end

