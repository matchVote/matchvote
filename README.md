# matchVote

matchVote keeps you up-to-date with what's happening in politics by finding 
the politicians that agree and disagree with what's important to you.

#### Development Setup  
    bin/setup
    bundle exec rake import:default_data

#### Deployment Process
    git push heroku master
    heroku run rake db:migrate
    heroku run rake import:default_data        # Full data load
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
  * Donor Data - https://www.opensecrets.org/resources/create/apis.php

### TODO
* Directory
    * Filter
    * Sort
    * Search
    * Feature specs
* Rep profile
    * Follow
    * Read full bio
    * Rate rep
    * Comments
    * Recent News
* Stances
* News Feed
* Misc backend
    * Setup email for forgotten password
    * Sign in with facebook/twitter (omniauth)
    * Data:
        * Sanitize Wikipedia bios; add more text for bio expansion
        * Donor data
* Misc frontend
    * View Profile; social media links - hyphen weirdness
    * Remove social media links if reps don't have an account
    * Style create account page
    * Refine Stances/Quiz views
    * Build GUI for admins to edit Representative profiles
* Test
    * CongressLegislatorsDataCompiler


