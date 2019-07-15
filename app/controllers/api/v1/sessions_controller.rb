# frozen_string_literal: true

class Api::V1::SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      # flash[:success] = 'You have logged in'
      # redirect_to user_path(user)
      render json: user, status: 200
    else
      # flash.now[:danger] = 'There was something wrong with your login information'
      # render 'new'
      render json: { errors: 'Failed to Sign In' }, status: 404
    end
  end

  def destroy
    session[:user_id] = nil
    # flash[:success] = 'You have logged out'
    # redirect_to root_path
    render json: 'You have  logged out'
  end
end
