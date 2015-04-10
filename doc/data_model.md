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
  has many InferenceOpinions
  belongs to Representative as opinionable  
  belongs to Citizen as opinionable  
  * agreeance_value (-3..3)
  * importance_value (0..5)
  * inferred_by
  * verified : boolean
  * skipped : boolean

* InferenceOpinions
  belongs to Stance
  belongs to User
  * agrees : boolean

* StanceQuotes  
  belongs to Stance
    * quote
    * quote_url
    * quote_timestamp

