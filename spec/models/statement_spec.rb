require "rails_helper"

describe Statement do
  let(:user) { create(:user) }
  let(:statement) { create(:statement) }
  let(:stance) { create(:stance, opinionable: user, statement: statement) }

  describe "#find_stance_for_user" do
    it "returns the stance belonging to the given user" do
      expect(stance.statement.find_stance_for_user(user)).to eq stance
    end

    it "returns nil when no stance is found" do
      expect(statement.find_stance_for_user(user)).to be_nil
    end
  end
end

