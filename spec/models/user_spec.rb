require "rails_helper"

describe User do
  describe "#profile" do
    let(:rep) { create(:representative) }

    it "finds the assigned profile entity" do
      user = build(:user, profile_id: rep.id, profile_type: "Representative")
      expect(user.profile).to eq rep
    end
  end
end

