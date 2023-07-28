class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_food_path(@comment.food.id)
  end
end
