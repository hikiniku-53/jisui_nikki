class Admin::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_food_path(@comment.food.id)
  end
end
