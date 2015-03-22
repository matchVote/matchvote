# matchVote

matchVote keeps you up-to-date with what's happening in politics by finding 
the politicians that agree and disagree with what's important to you.

#### Development Setup  
    bin/setup

#### Notes

Models
* Users - devise  
  has one Profile
  * username  

* Profiles  
  has one Contact  
  has many Stances  
  belongs to User
  * type # STI ex: Representative, Citizen
  * title --notdone:data_import
  * first_name
  * last_name
  * middle_names
  * suffix
  * nick_name
  * birthday
  * gender
  * government_role # senator, representative, president, etc...
  * state
  * district --notdone:data_import
  * party
  * biography --notdone:data_import
  * religion
  * status  EX: In Office, Running For Office, Out of Office
  * profile_image_url --notdone:data_import
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

* Representatives < Profiles

* Contact  
  has many PostalAddresses  
  belongs to Profile
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
  belongs to Profile
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
* Setup email for forgotten password
* Sign in with facebook/twitter (omniauth)
* Directory filter
* View Profile - hyphen weirdness
* Follow profile functionality
* Rep profile photos
* Sort reps in Directory
* Data:
  * Normalize rep names
  * Parse postal address from file
  * Present capitalized gender, party
  * Wikipedia bios
  * Donor data

