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
    before(:each) { subject.import }

    it "saves or updates all the officials of the office" do
      expect(Representative.count).to eq 1
      expect(Contact.count).to eq 1
      expect(PostalAddress.count).to eq 1
    end
    
    it "saves the office name to the rep" do
      office = "United States House of Representatives AL-07"
      expect(Representative.first.office).to eq office
    end
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

    it "expands HOBs and capitalizes words" do
      subject.update_contact(rep, helper.mock_contact_hash)
      expanded_line1 = "69 Fake Street House Office Building"
      expect(rep.contact.postal_addresses.first.line1).to eq expanded_line1
    end

    it "updates or creates the contact" do
      expect(rep).to receive(:update_or_create_contact).and_call_original
      subject.update_contact(rep, helper.mock_contact_hash)
      expect(rep.contact.phone_numbers.first).to eq "(123) 999-9999"
      expect(rep.contact.postal_addresses.first.zip).to eq "69696"
      expect(rep.contact.website_url).to eq "http://www.heythere.com"
    end
  end
end

