require "rails_helper"

describe Stance do
  let(:stance) { build(:stance) }

  describe "#agreeance_integer_value" do
    it "defaults to 0 when stance has no value" do
      stance.agreeance_value = nil
      expect(stance.agreeance_integer_value).to eq 0
    end

    it "returns the integer value of the enum" do
      stance.agreeance_value = "Agree"
      expect(stance.agreeance_integer_value).to eq 1
    end
  end

  describe "#importance_integer_value" do
    it "defaults to 2 when stance has no value" do
      stance.importance_value = nil
      expect(stance.importance_integer_value).to eq 2
    end

    it "returns the integer value of the enum" do
      stance.importance_value = "Extremely Important"
      expect(stance.importance_integer_value).to eq 4
    end
  end
end
