require "spec_helper"
require "byebug"
require_relative "../../app/services/date_formatter"

describe DateFormatter do
  subject { described_class }

  describe "#datepicker_to_standard" do
    it "converts datepicker format to matchVote standard YYYY-MM-DD" do
      date = subject.new("02/13/1969").datepicker_to_standard
      expect(date).to eq "1969-02-13"
    end
  end

  describe "#datepicker_format" do
    it "converts standard dates to datepicker format DD/MM/YYYY" do
      date = subject.new("1969-02-13").datepicker_format
      expect(date).to eq "02/13/1969"
    end
  end
end

