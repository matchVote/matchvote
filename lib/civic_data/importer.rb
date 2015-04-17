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
        rep.update_attributes(compiler.official_hash)
        rep.update_attribute(:office, office)

        update_contact(rep, compiler.contact_hash)
        rep.update_credentials(compiler.external_credentials)
        rep.save
      end
    end

    def update_contact(rep, contact_hash)
      rep.update_or_create_contact(
        phone_numbers: contact_hash[:phones],
        postal_addresses: create_postal_addresses(contact_hash[:addresses]),
        website_url: contact_hash[:website_url].first)
    end

    private
      def compile(office_officials)
        office["officialIndices"].map do |i|
          Compiler.new(office_officials[i])
        end
      end

      def create_postal_addresses(addresses)
        addresses.map do |address|
          PostalAddress.create({
            line1: sanitize_line1(address["line1"]),
            line2: address["line2"],
            city: address["city"].split.map(&:capitalize).join(" "),
            state: address["state"].upcase,
            zip: address["zip"] })
        end
      end

      def sanitize_line1(street)
        street.split.map(&:capitalize).join(" ").sub(/hob/i, "House Office Building")
      end
  end
end

