namespace :dev do
  desc "Creates records in DB to help with development"
  task load_fixtures: :environment do
    if Rails.env.development?
      [Article, Comment].each do |model|
        model.destroy_all
        type = model.name.downcase.pluralize
        articles = YAML.load_file("#{Rails.root}/spec/fixtures/#{type}.yml")
        articles.each do |data|
          model.create(data)
          model.connection.execute("SELECT nextval('#{type}_id_seq')")
        end
      end

      article = Article.first
      article.id = nil
      url = article.url[0...-1]
      (4..100).each do |num|
        article.url = url + num.to_s
        Article.create(article.attributes)
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
