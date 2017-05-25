class NewsController < ApplicationController
  def index
    @articles = Article.all.map { |a| ArticlePresenter.new(a) }
  end
end

