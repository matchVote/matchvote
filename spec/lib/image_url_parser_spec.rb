require "rails_helper"
require_relative "../../lib/image_url_parser"

describe ImageURLParser do
  let(:urls) do
    ["http://data.matchvote.com/images/2015/senators/Al_Franken.png",
     "http://data.matchvote.com/images/2015/senators/Shelley_Moore_Capito.png",
     "http://data.matchvote.com/images/2015/senators/Cory_Booker.png",
     "http://data.matchvote.com/images/2015/senators/Bob_Casey_Jr.png"]
  end

  subject { described_class.new(urls) }

  describe "#find_url" do
    it "returns the url that matches the given rep's first and last name" do
      rep = build(:representative, first_name: "shelley", last_name: "capito")
      expect(subject.find_url(rep)).to eq(
        "http://data.matchvote.com/images/2015/senators/Shelley_Moore_Capito.png")
    end

    it "returns the url that matches the rep's nickname and last name" do
      rep = build(:representative, nickname: "al", last_name: "franken")
      expect(subject.find_url(rep)).to eq(
        "http://data.matchvote.com/images/2015/senators/Al_Franken.png")
    end

    it "returns the matching url when it contains a suffix" do
      rep = build(:representative, nickname: "bob", last_name: "casey")
      expect(subject.find_url(rep)).to eq(
        "http://data.matchvote.com/images/2015/senators/Bob_Casey_Jr.png")
    end

    it "returns nil if nothing matches" do
      rep = build(:representative, nickname: "jorge", last_name: "gonzalez")
      expect(subject.find_url(rep)).to be_nil

      rep = build(:representative, first_name: "ala", last_name: "franken")
      expect(subject.find_url(rep)).to be_nil
    end
  end
end

