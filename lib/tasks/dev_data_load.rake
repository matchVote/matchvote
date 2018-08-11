namespace :dev do
  desc "Creates dummy users in DB from fixtures file"
  task create_users: :environment do
    if Rails.env.development?
      User.destroy_all
      YAML.load_file("#{Rails.root}/spec/fixtures/users.yml").each do |data|
        User.create(data)
      end
    end
  end

  desc "Creates records in DB to help with development"
  task reset_articles: :environment do
    if Rails.env.development?
      ARTICLE_COUNT = 100
      COMMENT_COUNT = 200
      Article.destroy_all
      Comment.destroy_all

      ARTICLE_COUNT.times do
        Article.create(
          url: Faker::Internet.url,
          title: Faker::Lorem.sentence,
          authors: [Faker::WorldOfWarcraft.hero, Faker::Lebowski.character],
          publisher: Faker::Company.name,
          date_published: DateTime.now,
          keywords: Faker::Coffee.notes.split(', '),
          summary: Faker::Lorem.paragraph(20),
          read_time: Random.rand(20),
          newsworthiness_count: Random.rand(3000),
          top_image_url: Faker::LoremFlickr.image('200x200', ['politics']),
        ).article_representatives.create(
          representative: Representative.order("RANDOM()").first
        )
      end
      days = 0
      Article.take(10).each do |a|
        a.update(date_published: DateTime.now - days)
        days += 1
      end

      COMMENT_COUNT.times do
        Comment.create(
          text: Faker::GameOfThrones.quote,
          user: User.order('RANDOM()').first,
          commentable: [Article, Comment][Random.rand(2)].order('RANDOM()').first
        )
      end
    end
  end
end
