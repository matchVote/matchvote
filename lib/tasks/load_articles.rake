namespace :articles do
  task load: :environment do
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
end
