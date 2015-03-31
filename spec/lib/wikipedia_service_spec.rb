require "rails_helper"
require "webmock/rspec"
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
    let(:json) do
      { query: { pages: { "1234": { extract: "First Paragraph!" } } } }.to_json
    end

    it "retrieves the first paragraph of the wikipedia page content" do
      stub_request(:get, "https://en.wikipedia.org/w/api.php").
        with(query: default_params.merge(titles: "Sherrod Brown")).
        to_return(body: json, headers: { "Content-Type": "application/json" })

      response = subject.new("Sherrod Brown").first_paragraph
      expect(response).to eq "First Paragraph!"
    end
  end
end
