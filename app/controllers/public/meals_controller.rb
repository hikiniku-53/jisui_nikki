class Public::MealsController < ApplicationController

  def create

    if params[:food_id]
      meal = current_customer.meals.find_by(food_id: meal_params[:food_id])
      if meal
        amount = meal_params[:amount].to_i
        meal.amount = amount += meal.amount
        meal.update(amount: meal.amount)
      else
        @meal = Meal.new(meal_params)
        @meal.customer_id = current_customer.id
        @meal.save
      end
      flash[:notice] = ""
      redirect_to meals_path
    elsif params[:recipe_id]
      meal = current_customer.meals.find_by(food_id: meal_params[:recipe_id])
      if meal
        amount = meal_params[:amount].to_f
        meal.amount = amount += meal.amount
        meal.update(amount: meal.amount)
      else
        @meal = Meal.new(meal_params)
        @meal.customer_id = current_customer.id
        @meal.save
      end
      flash[:notice] = ""
      redirect_to meals_path
    else
      flash[:notice] = ""
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:food_id, :recipe_id, :date, :time, :price, :energy, :protein, :fat, :carb, :salt_equivalent, :amount)
  end

end
