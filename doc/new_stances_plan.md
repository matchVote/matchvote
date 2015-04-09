* IssueCategories  
  has many Statements  
  * name
  * keywords

* Statements
  has many Stances
  belongs to IssueCategory  
  * description

* Stances  
  has many StanceQuotes  
  belongs to Representative as opinionable  
  belongs to Citizen as opinionable  
  * agreeance_value (-3..3)
  * importance_value (1..7)
  * skipped

* StanceQuotes
  * belongs to Stance
    * quote
    * quote_url
    * timestamp
    * added_by

Ex:  
Abortion  
> Statement 1: "Abortion is bad"  
> Statement 2: "Murder of abortion doctors is good"  

Rep  
> Stance on Statement 1: agreeance(3), importance(3)  
> Stance on Statement 2: agreeance(-3), importance(7)
