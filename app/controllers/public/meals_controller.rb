class Public::MealsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @meal_food = current_customer.meals.where(date: meal_params[:date], time: meal_params[:time], food_id: meal_params[:food_id], recipe_id: nil)
    @meal_recipe = current_customer.meals.where(date: meal_params[:date], time: meal_params[:time], food_id: nil, recipe_id: meal_params[:recipe_id])
    # 既に記録されていないか確認
    if @meal_food.exists?
      flash[:notice] = "その食材は既に記録されています"
    elsif meal_recipe.exists?
      flash[:notice] = "そのレシピは既に記録されています"
    else
      ## 記録されている => 食事を追加する
      @meal = Meal.new(meal_params)
      @meal.customer_id = current_customer.id
      @meal.save!
      flash[:notice] = "食事を追加しました"
    end
    # 追加した日の日記に飛ぶ

    redirect_to customer_path
  end
  
  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to customer_path
  end

  private

  def meal_params
    params.require(:meal).permit(:food_id, :recipe_id, :date, :time, :price, :energy, :protein, :fat, :carb, :salt_equivalent, :amount)
  end

end
