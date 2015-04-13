require "rails_helper"
require "support/civic_data_spec_helper"
require "#{Rails.root}/lib/civic_data/official_decorator"

describe CivicData::OfficialDecorator do
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
end
