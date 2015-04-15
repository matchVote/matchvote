require "#{Rails.root}/lib/slug"

module CivicData
  class OfficialDecorator < SimpleDelegator
    def generate_slug
      Slug.generate(first_name, last_name)
    end

    def first_name
      full_name.split.first
    end

    def last_name
      full_name.split.last
    end

    def full_name
      @full_name ||= fetch("name")
    end

    def contact
      ContactDecorator.new(self)
    end

    def to_hash
      { first_name: first_name,
        last_name: last_name,
        official_full_name: full_name,
        party: self["party"] }
    end
  end
end

