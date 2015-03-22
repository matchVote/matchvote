require "spec_helper"
require_relative "../../lib/address_parser"

describe AddressParser do
  let(:address) { "713 HART SENATE OFFICE BUILDING WASHINGTON DC 20510" }
  subject { described_class }

  describe ".parse" do
    it "returns a hash with specific keys" do
      result = described_class.parse(address)
      expect(result).to be_a Hash
      expect(result.keys).to eq %w(street_number street_name city state zip)
    end
  end
end

