require "rails_helper"
require "support/helpers/stance_helper"

describe StanceEvent do
  let(:user) { create(:user) }
  let(:helper) { StanceHelper.new }
  let(:stance) { helper.create_one_stance(user, agreeance: 3) }
  subject { described_class }

  describe "#log" do
    it "creates a stance event when given a valid action" do
      expect { subject.log(:created, stance, user) }.to change(subject, :count).by(1)
      expect(subject.first.agreeance_value).to eq 3
    end

    it "raises ArgumentError when given an invalid action" do
      expect { subject.log(:bad, stance, user) }.to raise_error(ArgumentError)
    end

    it "handles a deleted stance" do
      expect { 
        subject.log(:deleted, stance.destroy, user) 
      }.to change(subject, :count).by(1)
    end
  end
end

