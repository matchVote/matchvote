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
      external_credentials: { 
        thomas_id: "01763",
        govtrack_id: "400629"
      }
    )
  end

  task :create_profiles, [:number] => :environment do |task, args|
    args[:number].to_i.times do
      Representative.create(
        type: "Representative",
        title: Faker::Name.title,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        government_role: "president",
        party: "democrat",
        email: [Faker::Internet.email],
        phone: ["123-123-1234"],
        biography: "Hey there",
        religion: "Atheist",
        external_credentials: { 
          thomas_id: "01763",
          govtrack_id: "400629"
        }
      )
    end
  end
end
