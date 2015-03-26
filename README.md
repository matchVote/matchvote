# matchVote

matchVote keeps you up-to-date with what's happening in politics by finding 
the politicians that agree and disagree with what's important to you.

#### Development Setup  
    bin/setup
    bundle exec rake import:default_data

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
  belongs to Representative
  belongs to Citizen
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

### TODO
* Backend
    * Setup email for forgotten password
    * Sign in with facebook/twitter (omniauth)
    * Directory filter
    * Follow profile functionality
    * Sort reps in Directory
    * Data:
        * Fix Stances data model
        * Present capitalized gender, party
        * Wikipedia bios
        * Donor data
* Frontend
    * View Profile - hyphen weirdness
    * Rep profile photos
    * Style create account page
* Test
    * CongressLegislatorsDataCompiler
    * Directory feature specs
    * Rep profile feature specs



