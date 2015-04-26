require "rails_helper"
require "#{Rails.root}/lib/address_parser"

describe AddressParser do
  let(:address) { "713 HART SENATE OFFICE BUILDING WASHINGTON DC 20510" }
  subject { described_class }

  describe ".parse_attributes" do
    let(:result) { subject.parse_attributes(address) }

    it "returns a hash with specific keys" do
      expect(result).to be_a Hash
      expect(result.keys).to eq [:line1, :city, :state, :zip]
    end

    it "parses street address" do
      expect(result[:line1]).to eq "713 Hart Senate Office Building"
    end

    it "parses city" do
      expect(result[:city]).to eq "Washington"
    end

    it "parses state" do
      expect(result[:state]).to eq "DC"
    end

    it "parses zip" do
      expect(result[:zip]).to eq "20510"
    end
  end
end

