class Public::CustomersController < ApplicationController
  def show
    @date = Date.today
    @breakfasts = current_customer.meals.where(date: Date.today, time: 0)
    @lunches = current_customer.meals.where(date: Date.today, time: 1)
    @dinners = current_customer.meals.where(date: Date.today, time: 2)
    @others = current_customer.meals.where(date: Date.today, time: 3)
    @recipes = current_customer.recipes
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0
    @total_price = 0
  end

  def edit
  end

  def update
  end


end
