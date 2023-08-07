class Public::HomesController < ApplicationController
  def top
    @foods = Food.all.last(3)
    @recipes = Recipe.all.where(is_published: 'true').last(3)
    if customer_signed_in?
      @date = Date.today
      @breakfasts = current_customer.meals.where(date: @date, time: 0)
      @lunches = current_customer.meals.where(date: @date, time: 1)
      @dinners = current_customer.meals.where(date: @date, time: 2)
      @others = current_customer.meals.where(date: @date, time: 3)
      @total_energy = 0
      @total_protein = 0
      @total_fat = 0
      @total_carb = 0
      @total_salt_equivalent = 0
      @total_price = 0
    end
  end

  def about
  end
end
