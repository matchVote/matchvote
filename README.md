# matchVote

matchVote keeps you up-to-date with what's happening in politics by finding the politicians that agree and disagree with what's important to you.

Models
* Users  
  has one Profile

* Profiles  
  has many PostalAddresses  
  has one ExternalCredential  
  belongs to User  
  * type # STI
  * title
  * first_name
  * last_name
  * birthday
  * gender
  * government_role # senator, representative, president, etc...
  * state
  * district
  * party
  * email, array
  * phone, array
  * biography
  * religion
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

* PostalAddresses
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

