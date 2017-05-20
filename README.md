# matchVote    
[![Build Status](https://travis-ci.org/matchVote/matchvote.svg?branch=master)](https://travis-ci.org/matchVote/matchvote)

matchVote lets you automatically follow the political positions and news for elected officials in the US

#### Docker Setup
    bin/build              # creates containers
    bin/setup              # creates DB, migrates, seeds
    docker-compose up web  # starts containers

#### Development Setup  
    brew install phantomjs                     # needed for tests
    bin/setup
    bundle exec rake import:all_default_data
    rspec                                      # to make sure all is well

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
        * Approval Rating - Tied to Census Pulse
    * Filter  
      * Finalize hierarchy
* Rep profile/admin
    * Follow
    * Rate Rep / Approval Rating
    * Comments
    * Recent News - Pulled from News Feeder
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
  * Profile image
* Misc backend
    * Send email to admin if user signs up as rep/admin
    * Setup email for forgotten password
    * Sign in with facebook/twitter (omniauth)
    * Data:
        * Matchdata Files: term_end, took_office for seniority
        * Bio Errors: Evan Jenkins, French Hill, Luis Gutierrez
* Misc frontend
    * add SweetAlerts
    * Remove social media links if reps don't have an account
    * New styling of Rep Profile Contact Info
    * Style create account page
    * Style forgot password form
    * Refine Stances/Quiz views
    * Build GUI for admins to edit Representative profiles
* Test
    * LegislatorsDataCompiler

#### NOTES
Rep Terms?  

> * Statements
>   * Declarative text (limit character count?): Limited to 256
  
>   -Citizen User Type also has
>   * Alignment Importance with Rep (0, 1, 2, 3, 4, 5)
>   * Agreement with Researcher Inferrence
