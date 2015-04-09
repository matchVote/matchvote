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
Branches: Executive, Judicial, Legislative ->  
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
* Rep profile/admin
    * Follow
    * Read full bio
    * Rate rep
    * Comments
    * Recent News
* IssueCategories
  * Keywords
* Stances
* Statements
  * User acceptance: "your conclusion sounds accurate"
* News Feed
  * Articles
    * Summary
    * Comments
* Citizen profile/editing
* Misc backend
    * Add TravisCI
    * Setup email for forgotten password
    * Sign in with facebook/twitter (omniauth)
    * Data:
        * Bio Errors: Evan Jenkins, French Hill, Luis Gutierrez
        * Donor data
* Misc frontend
    * Remove social media links if reps don't have an account
    * Style create account page
    * Style forgot password form
    * Style sign up form
    * Refine Stances/Quiz views
    * Build GUI for admins to edit Representative profiles
* Test
    * CongressLegislatorsDataCompiler

