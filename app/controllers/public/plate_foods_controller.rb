class Public::PlateFoodsController < ApplicationController

  def index
    @plate_foods = current_customer.plate_foods
    @total_energy = 0
  end

  # 食材をプレートに追加
  def create_plate_food
    plate_food = current_customer.plate_foods.find_by(food_id: plate_food_params[:food_id])
    if plate_food
      amount = plate_food_params[:amount].to_i
      plate_food.amount = amount += plate_food.amount
      plate_food.update(amount: plate_food.amount)
    else
      @plate_food = PlateFood.new(plate_food_params)
      @plate_food.customer_id = current_customer.id
      @plate_food.save
    end
    flash[:notice] = "まな板に食材を追加しました"
    redirect_to plate_foods_path
  end

  #レシピをプレートに追加
  def create_plate_recipe
    plate_food = current_customer.plate_foods.find_by(recipe_id: plate_food_params[:recipe_id])
    if plate_food
      amount = plate_food_params[:amount].to_f
      plate_food.amount = amount += plate_food.amount
      plate_food.update(amount: plate_food.amount)
    else
      @plate_food = PlateFood.new(plate_food_params)
      @plate_food.customer_id = current_customer.id
      @plate_food.save
    end
    flash[:notice] = "まな板に食材を追加しました"
    redirect_to plate_foods_path
  end


  def update
    plate_food = PlateFood.find(params[:id])
    plate_food.update(cutting_board_food_params)
    flash[:notice] = "分量を変更しました"
    redirect_to plate_foods_path
  end


end
