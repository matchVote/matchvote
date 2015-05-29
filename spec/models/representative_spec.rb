require "rails_helper"

describe Representative do
  subject { build(:representative) }
  let(:contact_params) do
    { emails: ["one@email.com", "two@emails.com"], 
      phone_numbers: ["(123) 999-9999", "535-353-5353"],
      postal_addresses: [build(:postal_address, zip: "hey"), build(:postal_address)],
      website_url: "http://www.heythere.com" }
  end
  
  describe "#update_or_create_contact" do
    context "when rep does not have a contact" do
      it "creates one" do
        rep = build(:representative, contact: nil)
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

  describe "#update_credentials" do
    context "when rep has no external credentials" do
      it "creates them" do
        subject.external_credentials = nil
        subject.update_credentials(test_cred: "what you say?")
        expect(subject.reload.external_credentials).
          to eq({ "test_cred" => "what you say?" })
      end
    end

    context "when rep has external credentials" do
      it "updates the present keys" do
        new_creds = { "twitter_username"  => "a new one", 
                      "facebook_username" => "facebook", 
                      "youtube_username"  => "youtubes" }
        subject.update_credentials("twitter_username" => "a new one")
        expect(subject.reload.external_credentials).to eq new_creds
      end
    end
  end
end
