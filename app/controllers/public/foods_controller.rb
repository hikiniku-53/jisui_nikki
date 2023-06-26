class Public::FoodsController < ApplicationController
  def index
  end

  def genre_search
  end

  def new
  end

  def create
  end

  def show
    @food = Food.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
  end

  def edit
  end

  def update
  end

  private

  def food_params
    params.require(:food).permit(:name, :energy, :protein, :fat, :carb, :salt_equivalent)
  end

end
