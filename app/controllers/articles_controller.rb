# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  before_action :set_gravatar, only: %i[index]

  def set_article
    @article = Article.find(params[:id])
  end

  def set_gravatar
    articles = Article.all
    articles.each do |article|
      article.update(gravatar: article.user.gravatar)
    end
  end

  def new
    @article = Article.new
  end

  def index
    # @articles = Article.paginate(page: params[:page], per_page: 6)
    @articles = Article.search(params[:search])
    @articles = @articles.paginate(page: params[:page], per_page: 5)

    # render json: @articles
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def destroy
    if @article.user.username == current_user.username
      @article.destroy
      flash[:success] = 'Article was deleted'
    else
      flash[:danger] = 'Only the Article creator can delete the Post'
    end
    redirect_to articles_path
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was updated'
      redirect_to article_path(@article)
    else
      flash[:error] = 'Article was not updated'
      render 'edit'
    end
  end

  def show; end

  def edit
    unless @article.user == current_user
      redirect_to users_path
      flash[:danger] = 'Only the Article creator can edit the Post'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :private, :gravatar)
  end
end
