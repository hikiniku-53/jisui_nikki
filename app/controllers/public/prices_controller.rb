class Public::PricesController < ApplicationController
  def create
    food = Food.find(params[:food_id])
    @price = current_customer.prices.new(price_params)
    @price.food_id = food.id
    @price.customer_id = current_customer.id
    @price.save
    flash[:notice] = "値段を登録しました"
    redirect_to food_path(params[:food_id])
  end

  def update
     @price = Price.find(customer_id: current_customer.id, recipe_id: params[:food_id])
     @price.update(price_params)
  end

  private

  def price_params
    params.permit(:price)
  end
end
