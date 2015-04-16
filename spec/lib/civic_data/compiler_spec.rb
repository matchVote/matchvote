require "rails_helper"
require "support/civic_data_spec_helper"
require "#{Rails.root}/lib/civic_data/compiler"

describe CivicData::Compiler do
  let(:official) { CivicDataSpecHelper.mock_alabama_data["officials"].first }
  subject { described_class.new(official) }

  describe "#generate_slug" do
    it "generates a slug of the official's name" do
      expect(subject.generate_slug).to eq "terri-sewell"
    end
  end

  describe "#full_name" do
    it "returns the official's 'name' key" do
      expect(subject.full_name).to eq "Terri A. Sewell"
    end
  end

  describe "#official_hash" do
    it "returns a data hash conforming to the Representative model" do
      keys = subject.official_hash.keys.map(&:to_s)
      expect(Representative.column_names).to include(*keys)
    end
  end

  describe "#external_credentials" do
    it "returns a hash of social media usernames" do
      expect(subject.external_credentials[:facebook_username]).to eq "terrisewell"
      expect(subject.external_credentials[:twitter_username]).to be_nil
    end
  end
end
