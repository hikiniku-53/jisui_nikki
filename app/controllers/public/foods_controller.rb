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
    @food_genre = FoodGenre.find(params[:food_genre_id])
    @foods = @food_genre.foods
    @food_genres = FoodGenre.all
  end

  def new
    @food = Food.new
    @food_genres = FoodGenre.all
  end

  def create
    @food = Food.new(food_params)
    @food_genres = FoodGenre.all
    if @food.save
      redirect_to foods_path
    else
      render :new
    end
  end

  def show
    @food = Food.find(params[:id])
    @price = current_customer.prices.find_by(food_id: @food.id)
    @comment = Comment.new
    @comments = @food.comments
    @food_genres = FoodGenre.all
  end

  def edit
    @food = Food.find(params[:id])
     @food_genres = FoodGenre.all
  end

  def update
    @food = Food.find(params[:id])
    @food_genres = FoodGenre.all
    if @food.update(food_params)
      redirect_to food_path(params[:id])
    else
      render :edit
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :energy, :protein, :fat, :carb, :salt_equivalent, :food_genre_id, :image)
  end



end
