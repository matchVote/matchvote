require "rails_helper"
require_relative "../../lib/wikipedia_service"

describe WikipediaService do
  let(:default_params) do
    { format: "json", 
      action: "query", 
      prop: "extracts", 
      exintro: "", 
      explaintext: "" }
  end

  subject { described_class }

  describe "#first_paragraph" do
    it "retrieves the first paragraph of the wikipedia page content" do
      stub_request(:get, "https://en.wikipedia.org/w/api.php").
        with(query: default_params.merge(titles: "Sherrod Brown")).
        to_return(body: "{'hey':'you'}", headers: { "Content-Type": "application/json" })

      response = subject.new("Sherrod Brown").first_paragraph
      # expect(response).to eq 
    end
  end
end
