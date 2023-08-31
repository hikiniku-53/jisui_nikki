class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  # 投稿コメント一覧
  def index
    @comments = Comment.all
  end

  # コメント削除
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_food_path(@comment.food.id)
  end
end
