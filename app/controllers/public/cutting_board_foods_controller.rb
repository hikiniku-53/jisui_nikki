class Public::CuttingBoardFoodsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @foods = Food.all
    @food_genres = FoodGenre.all
    @keyword= params[:keyword]
    if params[:keyword]
      @foods = @foods.search(params[:keyword])
    end
    @cutting_board_foods = current_customer.cutting_board_foods
    @total_energy = 0
  end

  def genre
    @food_genre = FoodGenre.find(params[:genre_id])
    @food_genres = FoodGenre.all
    @foods = @food_genre.foods
    @keyword= params[:keyword]
    @cutting_board_foods = current_customer.cutting_board_foods
    @foods = @food_genre.foods
  end

  def create
    cutting_board_food = current_customer.cutting_board_foods.find_by(food_id: cutting_board_food_params[:food_id])
    if cutting_board_food
      amount = cutting_board_food_params[:amount].to_i
      cutting_board_food.amount = amount += cutting_board_food.amount
      cutting_board_food.update(amount: cutting_board_food.amount)
    else
      @cutting_board_food = CuttingBoardFood.new(cutting_board_food_params)
      @cutting_board_food.customer_id = current_customer.id
      @cutting_board_food.save
    end
    flash[:notice] = "まな板に食材を追加しました"
    redirect_to cutting_board_foods_path
  end

  def update
    cutting_board_food = CuttingBoardFood.find(params[:id])
    cutting_board_food.update(cutting_board_food_params)
    flash[:notice] = "分量を変更しました"
    redirect_to cutting_board_foods_path
  end

  def destroy
    cutting_board_food = CuttingBoardFood.find(params[:id])
    cutting_board_food.destroy
    redirect_to cutting_board_foods_path
    flash[:notice] = "食材をを削除しました"
  end

  def destroy_all
    current_customer.cutting_board_foods.destroy_all
    redirect_to cutting_board_foods_path
  end

  private

  def cutting_board_food_params
    params.require(:cutting_board_food).permit(:food_id, :amount)
  end

end
