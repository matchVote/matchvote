require "rails_helper"
require "webmock/rspec"
require "support/civic_data_spec_helper"
require_relative "../../lib/civic_data_service"

describe CivicDataService do
  let(:helper) { CivicDataSpecHelper }
  subject { described_class.new }

  describe "#dump_data_for_all_states" do
    let(:query) { { recursive: true, key: described_class::API_KEY } }
    let(:alabama_file) { "#{Rails.root}/db/data/civic_data/AL_civic_data.json" }
    let(:wyoming_file) { "#{Rails.root}/db/data/civic_data/WY_civic_data.json" }
    after(:each) { File.delete(alabama_file, wyoming_file) }

    it "creates json files for each state" do
      allow(subject).to receive(:state_abbreviations).and_return(["al", "wy"])
      stub_request(:get, helper.url("al")).to_return(helper.mock_response("alabama"))
      stub_request(:get, helper.url("wy")).to_return(helper.mock_response("wyoming"))

      subject.dump_data_for_all_states

      expect(File.exist?(alabama_file)).to eq true
      expect(File.exist?(wyoming_file)).to eq true
      expect(File.read(alabama_file)).to eq helper.mock_alabama_json
      expect(File.read(wyoming_file)).to eq helper.mock_wyoming_json
    end
  end

  describe "#save_file" do
    it "saves a string with the given filename" do
      test_file = "#{Rails.root}/tmp/test.txt"
      subject.save_file("hey there", test_file)
      expect(File.exist?(test_file)).to eq true
      File.delete(test_file)
    end
  end

  describe "#state_abbreviations" do
    it "returns any array of all the state abbreviations" do
      expect(subject.state_abbreviations.size).to eq 50
    end
  end
end

