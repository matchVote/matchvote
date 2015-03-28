require "rails_helper"
require_relative "../../lib/congress_legislators_data_compiler"

describe CongressLegislatorsDataCompiler do
  subject { described_class }

  describe "#first_name_sanitized" do
    it "transliterates and downcases the rep's first name" do
      rep_data = { "name" => { "first" => "HeMélis" }, "terms" => [] }
      expect(subject.new(rep_data, []).first_name_sanitized).to eq "hemelis"
    end
  end

  describe "#last_name_sanitized" do
    it "transliterates and downcases the rep's last name" do
      rep_data = { "name" => { "last" => "gLoBáL" }, "terms" => [] }
      expect(subject.new(rep_data, []).last_name_sanitized).to eq "global"
    end
  end
end