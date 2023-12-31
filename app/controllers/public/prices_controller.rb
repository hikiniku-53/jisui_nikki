class Public::PricesController < ApplicationController
  before_action :authenticate_customer!
  # 食材の値段を登録
  def create
    @price = Price.new(price_params)
    # binding.pry
    @price.customer_id = current_customer.id
    @price.save
    flash[:notice] = '値段を登録しました'
    redirect_to food_path(params[:food_id])
  end

  # 登録した値段の更新
  def update
    @price = current_customer.prices.where(food_id: params[:food_id])
    @price.update(price_params)
    flash[:notice] = '値段を更新しました'
    redirect_to food_path(params[:food_id])
  end

  private

  def price_params
    params.require(:price).permit(:food_price, :food_id)
  end

  def params_int(price_params)
    price_params.each do |key, value|
      price_params[key] = value.to_i if integer_string?(value)
    end
  end
end
