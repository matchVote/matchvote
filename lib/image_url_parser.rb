class ImageURLParser
  def initialize(urls)
    @urls = urls
  end

  def find_url(rep)
    @urls.find do |url|
      first_name, last_name = parse_rep_names(url)
      first_or_nickname_matches(rep, first_name) && last_name_matches(rep, last_name)
    end
  end

  private
    def parse_rep_names(url)
      names = url.split("/").last.split(".").first.split("_").map(&:downcase)
      names.pop if suffixes.include?(names.last)
      [names.first, names.last]
    end

    def first_or_nickname_matches(rep, first_name)
      rep.first_name.downcase == first_name || rep.nickname.downcase == first_name
    end

    def last_name_matches(rep, last_name)
      rep.last_name.downcase.split.last == last_name
    end

    def suffixes
      ["jr"]
    end
end

