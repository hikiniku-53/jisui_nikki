class Public::MealsController < ApplicationController
  before_action :authenticate_customer!

  def create
    meal_food = current_customer.meals.where(food_id: meal_params[:food_id], date: meal_params[:date], time: meal_params[:time])
    meal_recipe = current_customer.meals.where(recipe_id: meal_params[:recipe_id], date: meal_params[:date], time: meal_params[:time])
    # 既に記録されていないか確認
    if meal_food.exists?
      flash[:notice] = "既に記録されています"
    elsif meal_recipe.exists?
      flash[:notice] = "既に記録されています"
    else
      ## 記録されている => 食事を追加する
      @meal = Meal.new(meal_params)
      @meal.customer_id = current_customer.id
      @meal.save!
    end
    # 追加した日の日記に飛ぶ
    flash[:notice] = ""
    redirect_to customer_path
  end

  private

  def meal_params
    params.require(:meal).permit(:food_id, :recipe_id, :date, :time, :price, :energy, :protein, :fat, :carb, :salt_equivalent, :amount)
  end

end
