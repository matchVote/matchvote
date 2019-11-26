require "spec_helper"
require "#{Rails.root}/app/serializers/representative_serializer"

describe RepresentativeSerializer do
  let(:official) { FactoryGirl.build(:official, first_name: "Bob") }

  describe "#data" do
    it "returns a hash value of the serialized official" do
      serializer = RepresentativeSerializer.new(official)
      expect(serializer.data["first_name"]).to eq("Bob")
    end
  end

  describe "#add" do
    it "merges arbitrary hash values to serialized official" do
      serializer = RepresentativeSerializer.new(official)
      serializer.add(awesome_key: "super value")
      expect(serializer.data["awesome_key"]).to eq("super value")
    end
  end
end
