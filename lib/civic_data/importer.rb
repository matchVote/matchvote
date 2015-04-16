require "#{Rails.root}/lib/civic_data/compiler"

module CivicData
  class Importer
    attr_reader :office, :officials

    def initialize(office, office_officials)
      @office = office
      @officials = compile(office_officials)
    end

    def import
      officials.each do |compiler|
        rep = Representative.find_or_create_by(slug: compiler.generate_slug)
        rep.update_attribute(:office, office)
        rep.update_attributes(compiler.official_hash)

        update_contact(rep, compiler.contact_hash)
        rep.external_credentials.merge!(compiler.external_credentials)
        rep.save
      end
    end

    def update_contact(rep, contact_hash)
    end

    private
      def compile(office_officials)
        office["officialIndices"].map do |i|
          Compiler.new(office_officials[i])
        end
      end
  end
end
