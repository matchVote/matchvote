require "#{Rails.root}/lib/civic_data/official_decorator"

module CivicData
  class Compiler
    attr_reader :office, :officials

    def initialize(office, office_officials)
      @office = office
      @officials = decorate(office_officials)
    end

    def each_official
      officials.each { |official| yield official }
    end

    private
      def decorate(office_officials)
        office["officialIndices"].map do |i|
          OfficialDecorator.new(office_officials[i])
        end
      end
  end
end

