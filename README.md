# matchVote

matchVote keeps you up-to-date with what's happening in politics by finding 
the politicians that agree and disagree with what's important to you.

#### Development Setup  
    bin/setup
    bundle exec rake import:all_default_data

#### Deployment Process
    bundle exec rake deploy:heroku
    heroku run rake import:all_default_data    # Full data load
    heroku run rake reps:import_default_data   # Just representative data

#### Rep Hierarchy
All ->  
Levels: Federal, State, Municipal ->  
Federal Branches: Executive, Judicial, Legislative ->  
Government Role ->
Profile

#### Rep Data Sources:  
  * Congress Legistators - https://github.com/unitedstates/congress-legislators
  * Federal Donor Data - https://www.opensecrets.org/resources/create/apis.php
  * State Donor Data - http://www.followthemoney.org/our-data/apis/

### TODO
* Directory
    * Sort: 
        * Most Similar/Least similar
        * Approval Rating
        * State
    * Filter  
      * Finalize hierarchy
* Rep profile/admin
    * Follow
    * Read full bio
    * Rate rep
    * Comments
    * Recent News
    * Presentation of absent contact info
* News Feed
  * Articles
    * Author
    * Date
    * News Organization
    * Upvote/Downvote Score
    * Topics Covered (pulled from IssueCategories:Related Keywords)
    * Summary
    * Comments
* Citizen profile/editing
* Misc backend
    * Add TravisCI
    * Setup email for forgotten password
    * Sign in with facebook/twitter (omniauth)
    * Data:
        * Matchdata Files: term_end, took_office for seniority
        * Bio Errors: Evan Jenkins, French Hill, Luis Gutierrez
        * Donor data
* Misc frontend
    * Remove social media links if reps don't have an account
    * New styling of Rep Profile Contact Info
    * Style create account page
    * Style forgot password form
    * Style sign up form
    * Refine Stances/Quiz views
    * Build GUI for admins to edit Representative profiles
* Test
    * LegislatorsDataCompiler

#### NOTES
Rep Terms?  

> * Statements
>   * Declarative text (limit character count?): Limited to 256
  
>   -Rep User Type also has
>   * Supporting Quote URL
>   * Inferred/Verified State
>   * Researcher name who made inferrence
  
>   -Citizen User Type also has
>   * Alignment Importance with Rep (0, 1, 2, 3, 4, 5)
>   * Agreement with Researcher Inferrence
