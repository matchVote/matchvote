class CivicDataService
  API_KEY = ENV["CIVIC_DATA_API_KEY"]

  def initialize
    @base_url = "https://www.googleapis.com/civicinfo/v2/representatives/"
    @query = "?recursive=true&key=#{API_KEY}"
  end

  def dump_data_for_all_states
    state_abbreviations.each do |state|
      resource = CGI.escape("ocd-division/country:us/state:#{state}")
      json = fetch_json("#{@base_url}#{resource}#{@query}").body
      path = "#{Rails.root}/db/data/civic_data/#{state.upcase}_civic_data.json"
      save_file(json, path)
    end
  end

  def save_file(string, path)
    File.open(path, "w") { |f| f.write(string) }
  end

  def state_abbreviations
    ["al", "ak", "az", "ar", "ca", "co", "ct", "de", "fl", "ga", "hi", "id", "il", 
     "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo", "mt", 
     "ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd", "oh", "ok", "or", "pa", "ri", 
     "sc", "sd", "tn", "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy"]
  end

  private
    def fetch_json(url)
      HTTParty.get(url)
    end
end
