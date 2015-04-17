require "rails_helper"
require "support/civic_data_spec_helper"
require "#{Rails.root}/lib/civic_data/importer"
require "#{Rails.root}/lib/civic_data/compiler"

describe CivicData::Importer do
  let(:helper) { CivicDataSpecHelper }
  let(:parsed_json) { helper.mock_alabama_data }
  let(:office) { parsed_json["offices"].first }
  let(:officials) { parsed_json["officials"] }
  
  subject { described_class.new(office, officials) }

  describe "#import" do
    pending
  end

  describe "#update_contact" do
    let(:rep) { build(:representative) }

    it "capitalizes the address city" do
      subject.update_contact(rep, helper.mock_contact_hash)
      expect(rep.contact.postal_addresses.first.city).to eq "Fake City"
    end

    it "upcases the address state abbreviation" do
      subject.update_contact(rep, helper.mock_contact_hash)
      expect(rep.contact.postal_addresses.first.state).to eq "NC"
    end

    context "when rep doesn't have a contact" do
      it "creates one" do
        rep = build(:representative, contact: nil)
        subject.update_contact(rep, helper.mock_contact_hash)
        expect(rep.contact.postal_addresses.size).to eq 1
        expect(rep.contact.phone_numbers.size).to eq 1
      end
    end

    context "when rep does have a contact" do
      it "updates the contact" do
        subject.update_contact(rep, helper.mock_contact_hash)
        expect(rep.contact.phone_numbers.first).to eq "(123) 999-9999"
        expect(rep.contact.postal_address.first.zip).to eq "69696"
        expect(rep.contact.website_url).to eq "http://www.heythere.com"
      end
    end
  end
end

