require "rails_helper"
require "support/civic_data_spec_helper"
require "#{Rails.root}/lib/civic_data/compiler"

describe CivicData::Compiler do
  let(:helper) { CivicDataSpecHelper }
  let(:mock_json) { helper.mock_alabama_json }
  subject { described_class.new(JSON.parse(mock_json)) }
end

