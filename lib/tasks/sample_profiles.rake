namespace :db do
  task create_president: :environment do
    Representative.create(
      type: "Representative",
      title: "Prez",
      first_name: "Barack",
      last_name: "Obama",
      government_role: "president",
      party: "democrat",
      email: ["bo@whitehouse.gob"],
      phone: ["123-123-1234"],
      biography: "Hey there",
      religion: "Atheist",
      birthday: "11-12-1958",
      gender: "male",
      external_credentials: { 
        thomas_id: "01763",
        govtrack_id: "400629"
      },
      contact: Contact.create(
        emails: ["one@gmail.com", "two@yahoo.com"],
        phone_numbers: ["123-123-1234"],
        postal_addresses: [PostalAddress.create(
          street_number: "123",
          street_name: "Boberry Lane",
          city: "Bogart",
          state: "XY",
          zip: "98765-1234"
        )]
      )
    )
  end

  task :create_profiles, [:number] => :environment do |task, args|
    args[:number].to_i.times do
      Representative.create(
        type: "Representative",
        title: Faker::Name.title,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        government_role: ["representative", "senator"].sample,
        party: ["democrat", "republican", "independent"].sample,
        email: [Faker::Internet.email],
        phone: ["123-123-1234"],
        biography: "Hey there",
        birthday: "11-12-#{Random.rand(10_000)-2000}",
        gender: "male",
        religion: "Atheist",
        external_credentials: { 
          thomas_id: "01763",
          govtrack_id: "400629"
        },
        contact: Contact.create(
          emails: ["one@gmail.com", "two@yahoo.com"],
          phone_numbers: ["123-123-1234"],
          postal_addresses: [PostalAddress.create(
            street_number: "123",
            street_name: "Boberry Lane",
            city: "Bogart",
            state: "XY",
            zip: "98765-1234"
          )]
        )
      )
    end
  end
end
