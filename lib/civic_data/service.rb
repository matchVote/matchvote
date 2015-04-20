module CivicData
  class Service
    API_KEY = ENV["CIVIC_DATA_API_KEY"]

    def initialize
      @base_url = "https://www.googleapis.com/civicinfo/v2"
      @reps_url = "#{@base_url}/representatives"
      @divisions_url = "#{@base_url}/divisions"
      @key = "key=#{API_KEY}"
      @query = "?recursive=true&#{@key}"
    end

    def dump_data_for_all_states
      state_abbreviations.each { |state| fetch_officials_for(state: state) }
    end

    def fetch_officials_for(state:)
      resource = CGI.escape("/ocd-division/country:us/state:#{state.downcase}")
      json = fetch_json("#{@reps_url}#{resource}#{@query}").body
      path = "#{Rails.root}/db/data/civic_data/#{state.upcase}_civic_data.json"
      save_file(json, path)
    end

    def fetch_officials_by_division_for(state:)
      fetch_divisions_for(state: state).each_with_index do |division, index|
        resource = CGI.escape(division["ocdId"])
        official_json = fetch_json("#{@divisions_url}/#{resource}?#{@key}")

        path = "#{Rails.root}/db/data/civic_data/#{state.upcase}/"+
          "#{state.upcase}_civic_data_div#{index}.json"
        save_file(official_json.to_json, path)
      end
    end

    def fetch_divisions_for(state:)
      json = fetch_json("#{@divisions_url}?query=#{state.downcase}&#{@key}").body
      JSON.parse(json)["results"]
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
end

