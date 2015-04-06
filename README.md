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
    

#### Notes

Models
* Users - devise  
  has one Profile
  * username  

* Representatives  
  has one Contact  
  has many Stances  
  belongs to User
  * bioguide_id
  * title --notdone:data_import
  * first_name
  * last_name
  * middle_name
  * suffix
  * official_full_name
  * nickname
  * birthday
  * gender
  * orientation
  * government_role # senator, representative, president, etc...
  * state
  * state_rank
  * district --notdone:data_import
  * party
  * branch
  * religion
  * status  EX: In Office, Running For Office, Out of Office
  * verified - boolean
  * profile_image_url
  * slug
  * biography --notdone:data_import
  * external_credentials  
    * bioguide_id
    * thomas_id 
    * lis_id
    * govtrack_id
    * opensecrets_id 
    * votesmart_id
    * fec_ids
    * cspan_id
    * wikipedia_id
    * house_history_id
    * ballotpedia_id
    * maplight_id
    * washington_post_id
    * icpsr_id
    * facebook_id
    * facebook_username
    * twitter_username
    * youtube_id
    * youtube_username
    * instagram_id
    * instagram_username

* Citizens
  has many Stances  
  belongs to User
  * first_name
  * last_name
  * birthday
  * gender
  * party
  * religion

* Contact  
  has many PostalAddresses  
  belongs to Representative
  * emails # Array
  * phone_numbers # Array

* PostalAddresses  
  belongs to Contact
  * street_number
  * street_name
  * city
  * state
  * zip

* Issues  
  has many Stances
  * name

* Stances  
  has_many StanceQuotes  
  belongs to Issue  
  belongs to Representative as opinionable  
  belongs to Citizen as opinionable  
  * description
  * agreeance_value (-3..3)
  * importance_value (1..7)
  * skipped

* StanceQuotes
  * belongs to Stance
    * quote
    * quote_url


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
        * NameRecognition (Facebook counts issue)
        * Most Similar/Least similar
        * Approval Rating
        * State
    * Search: Int/Unit Test, refactor presenter
    * Filter
    * Feature specs
* Rep profile/admin
    * Follow
    * Read full bio
    * Rate rep
    * Comments
    * Recent News
* Stances
* News Feed
* Citizen profile/editing
* Misc backend
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


