require "rails_helper"
require "#{Rails.root}/lib/legislators_data_compiler"

describe LegislatorsDataCompiler do
  subject { described_class }

  describe "#first_name_sanitized" do
    it "transliterates the rep's first name" do
      rep_data = { "name" => { "first" => "HeMélis" }, "terms" => [] }
      expect(subject.new(rep_data, []).first_name_sanitized).to eq "HeMelis"
    end
  end

  describe "#last_name_sanitized" do
    it "transliterates the rep's last name" do
      rep_data = { "name" => { "last" => "globál" }, "terms" => [] }
      expect(subject.new(rep_data, []).last_name_sanitized).to eq "global"
    end
  end

  describe "#generate_slug" do
    let(:rep_data) { { "terms" => [] } }
    subject { described_class }

    it "returns a string of first and last name joined by '-'" do
      rep_data.merge!("name" => { "first" => "MF", "last" => "Jones" })
      expect(subject.new(rep_data, []).generate_slug).to eq "mf-jones"
    end

    context "when rep has a nickname" do
      it "returns a string of nickname and last name joined by '-'" do
        rep_data.merge!("name" => { "nickname" => "Jon", "last" => "BonJovi" })
        expect(subject.new(rep_data, []).generate_slug).to eq "jon-bonjovi"
      end
    end
  end
end

