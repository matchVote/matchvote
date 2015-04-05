require "rails_helper"

describe RepSorter do
  subject { described_class }

  describe ".default" do
    it "returns all reps unsorted" do
      expect(Representative).to receive(:all)
      subject.default
    end
  end

  describe ".alphabetically" do
    it "returns all reps sorted by last name, then first name" do
      expect(Representative).to receive(:order).with(:last_name, :first_name)
      subject.alphabetically
    end
  end

  describe ".popularity" do
    it "returns all reps ordered by name recognition" do
      expect(Representative).to receive(:order).with(:name_recognition)
      subject.popularity
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
      expect(Representative).to receive(:order).with(:seniority_date, :slug)
      subject.seniority
    end
  end

  describe ".age" do
    it "returns all reps sorted by age" do
      expect(Representative).to receive(:order).with(birthday: :desc)
      subject.age
    end
  end

  describe ".state" do
    pending "not implemented"
  end
end

