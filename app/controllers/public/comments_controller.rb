class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    food = Food.find(params[:food_id])
    comment = current_customer.comments.new(comment_params)
    comment.food_id = food.id
    comment.customer_id = current_customer.id
    comment.save
    redirect_to food_path(params[:food_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :comment_genre_id)
  end

end
