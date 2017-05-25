namespace :articles do
  task load: :environment do
    if Rails.env.development?
      articles = YAML.load_file("#{Rails.root}/spec/fixtures/articles.yml")
      articles.each do |article|
        Article.create(article)
      end
    end
  end
end
