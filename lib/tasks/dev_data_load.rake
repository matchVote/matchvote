namespace :dev do
  desc "Creates records in DB to help with development"
  task load_fixtures: :environment do
    if Rails.env.development?
      [Article, Comment].each do |model|
        model.destroy_all
        type = model.name.downcase.pluralize
        YAML.load_file("#{Rails.root}/spec/fixtures/#{type}.yml").each do |data|
          model.create(data)
        end
      end
    end
  end

  desc "Creates dummy users in DB from fixtures file"
  task load_users: :environment do
    if Rails.env.development?
      User.destroy_all
      YAML.load_file("#{Rails.root}/spec/fixtures/users.yml").each do |data|
        User.create(data)
      end
    end
  end
end
