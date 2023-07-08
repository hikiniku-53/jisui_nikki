class Public::PricesController < ApplicationController
  def create
    @price = Price.new(price_params)
        # binding.pry
    @price.customer_id = current_customer.id
    @price.save
    flash[:notice] = "値段を登録しました"
    redirect_to food_path(params[:food_id])
  end

  def update
     @price = Price.where(customer_id: current_customer.id)
     @price.update(price_params)
     flash[:notice] = "値段を更新しました"
    redirect_to food_path(params[:food_id])
  end

  private

  def price_params
    params.require(:price).permit(:food_price, :food_id)
  end

  def params_int(price_params)
    price_params.each do |key,value|
      if integer_string?(value)
        price_params[key]=value.to_i
      end
    end
  end
end
