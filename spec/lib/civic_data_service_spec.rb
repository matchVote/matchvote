require "rails_helper"
require "webmock/rspec"

describe CivicDataService do
  subject { described_class }

  describe ".dump_data_for_all_states" do
    let(:json) do
      {
        divisions: { "ocdId" => "some id" },
        offices: [],
        officials: []
      }
    end

    it "creates json dump files for each state" do
      url = "https://www.googleapis.com/civicinfo/v2/representatives/ocdid"
      "ocd-division/country:us/state:al"
      stub_request(:get, ).
        with(query: default_params.merge(titles: "Sherrod Brown")).
        to_return(body: json, headers: { "Content-Type": "application/json" })
      subject.dump_data_for_all_states
    end
  end
end

