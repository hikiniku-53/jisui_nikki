class Admin::FoodsController < ApplicationController
  before_action :authenticate_admin!
  before_action :make_instance, except: [:index]

  def index
    @foods = Food.all
  end

  def show
    @comments = @food.comments
  end

  def edit
    @genres = FoodGenre.all
  end

  def update
    @food.update(food_params)
    redirect_to admin_foods_path
  end

  def destroy
    @food.destroy
    redirect_to admin_foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :energy, :protein, :fat, :carb, :salt_equivalent, :food_genre_id)
  end

  def make_instance
    @food = Food.find(params[:id])
  end

end
