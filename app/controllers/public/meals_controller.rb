class Public::MealsController < ApplicationController

  def create
    meal_food = current_customer.meals.find_by(food_id: meal_params[:food_id])
    meal_recipe = current_customer.meals.find_by(recipe_id: meal_params[:recipe_id])
    # 既に記録されていないか確認
    if meal_food || meal_recipe
      # 記録されている => 送信した分量を追加する
      amount = meal_params[:amount].to_f
      meal.amount = amount += meal.amount
      meal.update(amount: meal.amount)
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
