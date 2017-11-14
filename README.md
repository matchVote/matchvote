# matchVote    
[![Build Status](https://travis-ci.org/matchVote/matchvote.svg?branch=master)](https://travis-ci.org/matchVote/matchvote)

matchVote lets you automatically follow the political positions and news for elected officials in the US

#### Development Setup
    bin/build              # creates containers
    bin/setup              # creates DB, migrates, seeds
    docker-compose up web  # starts containers

#### Deployment Process
    bin/deploy <ENV>
Initial data population will need to happen when an environment is deployed to for the first time: `rake import:all_default_data`

#### Updating version
* config/application.rb `VERSION`

### TODO
* News Feed
  * Articles
    * Newsworthiness vote doesn't visually indicate a previous vote
    * Topics Covered (pulled from IssueCategories:Related Keywords)
    * Share
    * Pulse Poll
  * Filtering
    * Bookmark
    * Topic/Category
    * Mentioned Official
    * Publisher
    * Author (not current priority)
    * Publish Date
    * Newsworthiness
    * Add filter
  * Sorting
    * Most Read
    * Most Shared
    * Most Bookmarked
  * Comments
    * Edit - talk to Brad first
    * Locking
    * Report
    * View more -- link to Article show page
    * Change comment timestamps to reflect local time
    * Upgrade -- Temp implementation until Account Upgrade feature is done
* Account Upgrade (payments)
* Directory
  * Sort:
    * Most Similar/Least similar
    * Approval Rating - Tied to Census Pulse
    * Name Recognition currently broken due to Virility using ruby version 2.3
  * Filter  
    * Finalize hierarchy
* Rep profile/admin
  * Follow
  * Rate Rep / Approval Rating
  * Comments
  * Recent News - Pulled from News Feeder
  * Presentation of absent contact info
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

#### NOTES
Rep Terms?  

> * Statements
>   * Declarative text (limit character count?): Limited to 256

>   -Citizen User Type also has
>   * Alignment Importance with Rep (0, 1, 2, 3, 4, 5)
>   * Agreement with Researcher Inferrence
