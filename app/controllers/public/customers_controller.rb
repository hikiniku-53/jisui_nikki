class Public::CustomersController < ApplicationController
  def show
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
