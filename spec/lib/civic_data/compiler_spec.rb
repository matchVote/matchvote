require "rails_helper"
require "support/civic_data_spec_helper"
require "#{Rails.root}/lib/civic_data/compiler"
require "#{Rails.root}/lib/civic_data/official_decorator"

describe CivicData::Compiler do
  let(:helper) { CivicDataSpecHelper }
  let(:parsed_json) { helper.mock_alabama_data }
  let(:office) { parsed_json["offices"].first }
  let(:officials) { parsed_json["officials"] }
  
  subject { described_class.new(office, officials) }

  describe "#each_official" do
    it "yields each of its decorated officials" do
      decorated_official = CivicData::OfficialDecorator.new(officials.first)
      expect { |b| subject.each_official(&b) }.to yield_with_args(decorated_official)
    end
  end
end

