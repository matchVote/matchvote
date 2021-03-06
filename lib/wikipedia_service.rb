class WikipediaService
  attr_reader :base_url, :subject

  def initialize(search_string)
    @subject = sanitize_for_url(search_string)
    @base_url = "https://en.wikipedia.org/w/api.php?format=json&action=query"
  end

  def first_paragraph
    r = get("#{base_url}#{query_options}&titles=#{subject}")
    r["query"]["pages"].first.last["extract"] if r
  end

  def query_options
    "&redirects=true&prop=extracts&exintro=&explaintext="
  end

  private
    def get(url)
      HTTParty.get(url)
    end

    def sanitize_for_url(string)
      I18n.transliterate(string || "").gsub(" ", "%20")
    end
end

