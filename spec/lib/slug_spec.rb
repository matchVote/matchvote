require "rails_helper"
require "#{Rails.root}/lib/slug"

describe Slug do
  describe "#generate"do
    it "joins two strings with a hyphen and downcases" do
      expect(Slug.generate("HR", "Giger")).to eq "hr-giger"
    end

    it "transliterates both strings" do
      expect(Slug.generate("Urï", "Péron")).to eq "uri-peron"
    end

    it "replaces whitespace and apostrophes with hyphens" do
      expect(Slug.generate("C H", "O'Malley")).to eq "c-h-o-malley"
    end

    it "removes periods" do
      expect(Slug.generate("J.K.", "Rowling")).to eq "jk-rowling"
    end
  end
end

