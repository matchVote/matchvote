class CivicDataSpecHelper
  def self.url(state)
    resource = CGI.escape("ocd-division/country:us/state:#{state}")
    query = "?recursive=true&key=#{CivicDataService::API_KEY}"
    "https://www.googleapis.com/civicinfo/v2/representatives/#{resource}#{query}"
  end

  def self.mock_response(state)
    { body: send("mock_#{state}_json"), 
      headers: { "Content-Type": "application/json" } }
  end

  def self.mock_alabama_data
    { 
      "divisions" => { 
        "ocd-division/country:us/state:wy/place:vina" => { "name" => "Vina town" }
      },
      "offices" => [{
        "name" => "United States House of Representatives AL-07",
        "divisionId" => "ocd-division/country:us/state:al/cd:7",
        "levels" => [ "country" ],
        "roles" => [ "legislatorLowerBody" ],
        "officialIndices" => [ 0 ]
      }],
      "officials" => [{
        "name" => "Terri A. Sewell",
        "address" => [
          { "line1" => "1133 longworth hob",
            "city" => "washington",
            "state" => "DC",
            "zip" => "20515" }
        ],
        "party" => "Democratic",
        "phones" => [ "(202) 225-2665" ],
        "urls" => [ "http://sewell.house.gov/" ],
        "photoUrl" => "n/a",
        "channels" => []
      }] 
    }
  end

  def self.mock_alabama_json
    mock_alabama_data.to_json
  end

  def self.mock_wyoming_json
    { 
      "divisions" => { 
       "ocd-division/country:us/state:wy/place:bar_nunn": { "name": "Bar Nunn town" }
      },
      "offices" => [{
        "name" => "United States Senate",
        "divisionId" => "ocd-division/country:us/state:wy",
        "levels" => ["country"],
        "roles" => ["legislatorUpperBody"],
        "officialIndices" => [0, 1]
      }],
      "officials" => [{
        "name" => "John Barrasso",
        "address" => [
          { "line1" => "307 Dirksen Senate Office Building",
            "city" => "washington",
            "state" => "DC",
            "zip" => "20510" }
        ],
        "party" => "Republican",
        "phones" => ["(202) 224-6441"],
        "urls" => ["http://www.barrasso.senate.gov/public/"],
        "photoUrl" => "http://bioguide.congress.gov/bioguide/photo/B/B001261.jpg",
        "channels" => []
      }] 
    }.to_json
  end
end

