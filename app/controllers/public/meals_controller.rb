class Public::MealsController < ApplicationController

  def create
    # 食材を追加した場合
    if params[:food_id]
      meal = current_customer.meals.find_by(food_id: meal_params[:food_id])
      # 既に記録されていた場合
      if meal
        # 送信した分量を追加する
        amount = meal_params[:amount].to_i
        meal.amount = amount += meal.amount
        meal.update(amount: meal.amount)
      # 記録されていなかった場合
      else
        # レシピを追加する
        @meal = Meal.new(meal_params)
        @meal.customer_id = current_customer.id
        @meal.save
      end
      
    # レシピを追加した場合
    elsif params[:recipe_id]
      meal = current_customer.meals.find_by(food_id: meal_params[:recipe_id])
      # 既に記録されていた場合
      if meal
        # 送信した分量を追加する
        amount = meal_params[:amount].to_f
        meal.amount = amount += meal.amount
        meal.update(amount: meal.amount)
      # 記録されていなかった場合
      else
        # レシピを追加する
        @meal = Meal.new(meal_params)
        @meal.customer_id = current_customer.id
        @meal.save
      end
      
    # 食材、レシピ以外が贈られた場合
    else
      flash[:notice] = ""
    end
    
    # 追加した日の日記に飛ぶ
    flash[:notice] = ""
    redirect_to meals_path
  end

  private

  def meal_params
    params.require(:meal).permit(:food_id, :recipe_id, :date, :time, :price, :energy, :protein, :fat, :carb, :salt_equivalent, :amount)
  end

end
