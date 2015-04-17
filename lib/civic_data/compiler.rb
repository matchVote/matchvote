require "#{Rails.root}/lib/slug"

module CivicData
  class Compiler < SimpleDelegator
    def generate_slug
      Slug.generate(first_name, last_name)
    end

    def first_name
      full_name.split.first
    end

    def last_name
      full_name.split.last
    end

    def full_name
      @full_name ||= fetch("name")
    end

    def official_hash
      { first_name: first_name,
        last_name: last_name,
        official_full_name: full_name,
        party: self["party"] }
    end

    def contact_hash
      { addresses: self["address"],
        phones: self["phones"],
        website_url: self["urls"] }
    end

    def external_credentials
      { "facebook_username" => find_username("facebook"),
        "twitter_username" => find_username("twitter"),
        "youtube_username" => find_username("youtube") }
    end

    private
      def find_username(type)
        username = self["channels"].find { |c| c["type"].downcase == type }
        username.nil? ? nil : username["id"]
      end
  end
end

