# frozen_string_literal: true

class UsersController < ApplicationController
  # GET /users/new
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to my Blog #{@user.username}. Please Login to start using it"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
