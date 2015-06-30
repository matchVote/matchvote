require "rails_helper"
require "support/helpers/stance_helper"

describe Representative do
  subject { create(:representative) }
  let(:contact_params) do
    { emails: ["one@email.com", "two@emails.com"], 
      phone_numbers: ["(123) 999-9999", "535-353-5353"],
      postal_addresses: [build(:postal_address, zip: "hey"), build(:postal_address)],
      website_url: "http://www.heythere.com" }
  end
  
  describe "#update_or_create_contact" do
    context "when rep does not have a contact" do
      it "creates one" do
        rep = create(:representative, contact: nil)
        rep.update_or_create_contact(contact_params)
        expect(rep.reload.contact.postal_addresses.size).to eq 2
        expect(rep.contact.phone_numbers.size).to eq 2
        expect(rep.contact.emails.size).to eq 2
      end
    end

    context "when rep has a contact" do
      it "updates the contact" do
        subject.update_or_create_contact(contact_params)
        expect(subject.contact.phone_numbers.first).to eq "(123) 999-9999"
        expect(subject.contact.website_url).to eq "http://www.heythere.com"
        expect(subject.contact.postal_addresses.first.zip).to eq "hey"
      end
    end
  end

  describe "#update_external_ids" do
    context "when rep has no external ids" do
      it "creates them" do
        subject.contact.external_ids = nil
        subject.update_external_ids(test_cred: "what you say?")
        expect(subject.reload.contact.external_ids).
          to eq({ "test_cred" => "what you say?" })
      end
    end

    context "when rep has external ids" do
      it "updates the present keys" do
        ids = { "twitter_username"  => "a new one", 
                "facebook_username" => "facebook", 
                "youtube_username"  => "youtubes" }
        subject.contact.update(external_ids: ids)
        subject.update_external_ids("twitter_username" => "a new one")
        expect(subject.reload.contact.external_ids).to eq ids
      end
    end
  end

  describe "#overall_match_percent" do
    let(:user) { build(:user) }
    let(:rep) { build(:representative) }

    it "returns the overall match percent of user and rep" do
      values = { one: [[1, 3], [-1, 0], [0, 2], [-2, 2]],
                 two: [[1, 1], [-2, 4], [0, 3], [ 3, 4]] }
      StanceHelper.new.create_stances_for(user, rep, values)
      expect(rep.overall_match_percent(user)).to eq 0.53
    end
  end
end

