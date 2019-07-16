# frozen_string_literal: true

class MessagesController < ApplicationController
  # GET /users/new
  def new
    @message = Message.new
    @message.update(from: params[:from])
    @message.update(to: params[:to])
  end

  def create
    binding.pry
    @message = Article.new(message_params)
    if @message.save
      flash[:success] = 'Message was sent successfully'
      redirect_to friends_path
    else
      flash[:danger] = 'Message failed to send'
      redirect_to new_message_path
    end
  end

  def show; end

  def edit; end

  def index
    @messages = Message.all
    @messages = @messages.paginate(page: params[:page], per_page: 5)
  end

  def update
    binding.pry
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  private

  def user_params
    params.require(:user).permit(:to, :from, :body)
  end
end
