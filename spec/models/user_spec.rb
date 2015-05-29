require "rails_helper"

describe User do
  describe "#profile" do
    let(:rep) { create(:representative) }

    it "finds the assigned profile entity" do
      user = build(:user, profile_id: rep.id, profile_type: "Representative")
      expect(user.profile).to eq rep
    end
  end

  describe "custom validations" do
    it "does not allow username to have whitespace" do
      user = build(:user, username: "hey bob")
      expect(user.save).to eq false
      expect(user.errors.messages).to eq username: ["can't have spaces."]
    end
  end
end

