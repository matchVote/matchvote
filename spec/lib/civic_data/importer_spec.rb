require "rails_helper"
require "support/civic_data_spec_helper"
require "#{Rails.root}/lib/civic_data/importer"
require "#{Rails.root}/lib/civic_data/compiler"

describe CivicData::Importer do
  let(:helper) { CivicDataSpecHelper }
  let(:parsed_json) { helper.mock_alabama_data }
  let(:office) { parsed_json["offices"].first }
  let(:officials) { parsed_json["officials"] }
  
  subject { described_class.new(office, officials) }

  describe "#import" do
    pending
  end

  describe "#update_contact" do
    pending
  end
end

