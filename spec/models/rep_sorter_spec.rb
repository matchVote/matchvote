require "rails_helper"

describe RepSorter do
  let(:all_reps) { Representative.all }
  let(:some_reps) { Representative.where(party: "Democrat") }
  subject { described_class.new(some_reps) }

  before(:each) do
    10.times { create(:representative) }
  end

  describe "initializing with no reps" do
    it "defaults to all reps" do
      sorter = described_class.new
      expect(sorter.alphabetically.size).to eq all_reps.size
    end
  end

  describe "#alphabetically" do
    it "returns given reps sorted by last name, then first name" do
      expect(subject.alphabetically).to eq some_reps.order(:last_name, :first_name)
    end
  end

  describe ".popularity" do
    it "returns all reps ordered by name recognition" do
      expect(subject.popularity).to eq some_reps.order(name_recognition: :desc)
    end
  end

  describe ".similarity" do
    pending "not implemented"
  end

  describe ".difference" do
    pending "not implemented"
  end

  describe ".approval" do
    pending "not implemented"
  end

  describe ".seniority" do
    it "returns all reps sorted by seniority date" do
      expect(subject.seniority).to eq some_reps.order(:seniority_date, :slug)
    end
  end

  describe ".age" do
    it "returns all reps sorted by age" do
      expect(subject.age).to eq some_reps.order(birthday: :desc)
    end
  end

  describe ".state" do
    pending "not implemented"
  end
end

