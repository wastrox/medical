class NewsController < ApplicationController
  layout "startpage"
  skip_before_filter :require_login, :only => [:index, :show]


  def index
  	@defaultArticles = Article.where(state: "default").order("published_at desc")
  	@restArtcles = Article.where(state: "published").order("published_at desc")
  end

  def show
  	@article = Article.find_by_title(params[:id])
  end
end
