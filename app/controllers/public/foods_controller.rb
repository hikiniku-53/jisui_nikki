class Public::FoodsController < ApplicationController
  def index
    @foods = Food.all
    @food_genres = FoodGenre.all
    if params[:keyword]
      @foods = @foods.search(params[:keyword])
    end
    
    @keyword= params[:keyword]
      
  end

  def genre
    @food_genre = FoodGenre.find(params[:genre_id])
    @foods = @food_genre.foods
    @food_genres = FoodGenre.all
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
