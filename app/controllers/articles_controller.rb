class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  
  def index
    @articles = Article.only(params[:limit]).ordered_by(params[:order_by])

    #this works
    #articles_unlimited = Article.ordered_by(params[:order_by])
    #@articles = articles_unlimited.limit(params[:limit]) 
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    title = params[:article][:title]
    tag_list = params[:article][:tag_list]
    body = params[:article][:body]
    @article = Article.new()
    @article.title = title
    @article.tag_list = tag_list
    @article.body = body

    #@article = Article.new(params[:article])

    @article.save

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params[:article])

    flash[:message] = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end
end
