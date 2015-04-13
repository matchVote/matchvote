require "#{Rails.root}/lib/civic_data/official_decorator"

module CivicData
  class Compiler
    attr_reader :office, :officials

    def initialize(office, all_officials)
      @office = office
      @officials = decorate(all_officials)
    end

    private
      def decorate(all_officials)
        office["official_indices"].map do |i|
          OfficialDecorator.new(all_officials[i])
        end
      end
  end
end

