class Public::MealsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @meal = current_customer.meals.find_by(date: meal_params[:date], time: meal_params[:time], name: meal_params[:name])

    # 既に記録されていないか確認
    if @meal
      flash[:notice] = "既に記録されています"
    else
      ## 記録されている => 食事を追加する
      @meal = Meal.new(meal_params)
      @meal.customer_id = current_customer.id
      @meal.save!
      flash[:notice] = "食事を追加しました"
    end
    # 追加した日の日記に飛ぶ

    redirect_to customer_path
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to customer_path
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :date, :time, :price, :energy, :protein, :fat, :carb, :salt_equivalent, :amount, :is_food)
  end
end