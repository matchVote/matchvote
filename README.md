# matchVote

matchVote keeps you up-to-date with what's happening in politics by finding 
the politicians that agree and disagree with what's important to you.

# Development Setup  
    bin/setup

### NOTES

Models
* Users - devise  
  has one Profile
  * username

* Profiles  
  has one Contact
  belongs to User  
  * type # STI ex: Representative, Citizen
  * title --notdone:data_import
  * first_name
  * last_name
  * middle_names
  * suffix
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

* Stances
  * issue_name
  * quote_url
  Track skipped questions from quiz
  -3 to 3
  Privacy controls; From profile account, show stance.


# Rep Hierarchy
All |> 
Levels: Federal, State, Municipal |>
Branches: Executive, Judicial, Legislative |>
Profile

APIs  
OpenSecrets.org

