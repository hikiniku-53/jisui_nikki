class Public::FoodsController < ApplicationController
  before_action :authenticate_customer!


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
    @food = Food.new
    @genres = FoodGenre.all
  end

  def create
    @food = Food.new(food_params)
    @food.save
    redirect_to foods_path
  end

  def show
    @food = Food.find(params[:id])
    @price = current_customer.prices.where(food_id: @food.id)
    @comment = Comment.new
    @comments = @food.comments
  end

  def edit
  end

  def update
  end

  private

  def food_params
    params.require(:food).permit(:name, :energy, :protein, :fat, :carb, :salt_equivalent, :food_genre_id)
  end



end
