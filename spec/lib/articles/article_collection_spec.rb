require 'rails_helper'
require "#{Rails.root}/lib/articles/article_collection"

describe ArticleCollection do
  subject { described_class }

  describe '#collect_articles' do
    before(:all) do
      Article.create(url: 'fake.com/1', publisher: 'XYZ')
    end

    it 'worked' do
      expect(Article.count).to eq 1
    end
  end
end
