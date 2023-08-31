class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    

  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to admin_customers_path
  end

  def favorites
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:recipe_id)
    @favorite_foods = Recipe.find(favorites)
  end
end