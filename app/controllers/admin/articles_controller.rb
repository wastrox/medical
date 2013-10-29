class Admin::ArticlesController < ApplicationController
  layout "admin"
  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"  

  skip_before_filter :require_login
  before_filter :initArticle, :only => [:new, :create]
  before_filter :allNews, :only => :index
  before_filter :findArticle, :only => [:edit, :update, :show, :review_index_page, :default_published_value, :archive]
  before_filter :default_published_value, :only => :edit

  def index
  end

  def new
  end

  def create
    respond_to do |format|
      if @article.save
        @article.defaultArticle(params[:default_published])
        format.html { redirect_to admin_articles_url}
        format.json { render :json => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        @article.defaultArticle(params[:default_published])
        format.html { redirect_to admin_articles_url }
        format.json { render :json => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @article = Article.find_by_id(params[:id])
    if @article.destroy
      respond_to do |format|
        format.html { redirect_to admin_articles_url }
        format.js
      end
    end
  end

  def archive
    if @article.archive
      respond_to do |format|
          format.html { redirect_to admin_articles_url }
          format.js
      end
    end
  end

  def review_index_page
  end

  protected

  def allNews
    @articles = Article.find(:all, :order => "created_at desc")
  end

  def initArticle
    @article = Article.new(params[:article])
    @article ||= Article.new
  end

  def findArticle
    @article ||= Article.find_by_title(params[:id])
  end

  def default_published_value
    @default_published_value = true ? @article.default? : @default_published_value = false
  end
end
