class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @date = Date.today
    if params[:date]
      @date = params[:date]
    end

    @diary = current_customer.diaries.find_by(date: @date)
    if current_customer.meals.exists?
      @breakfasts = current_customer.meals.where(date: @date, time: 0)
      @lunches = current_customer.meals.where(date: @date, time: 1)
      @dinners = current_customer.meals.where(date: @date, time: 2)
      @others = current_customer.meals.where(date: @date, time: 3)
    else
      @breakfasts = []
      @lunches = []
      @dinners = []
      @others = []
    end

    @recipes = current_customer.recipes
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0
    @total_price = 0


    favorites = Favorite.where(customer_id: current_customer.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)



  end

  def edit
  end

  def update
  end

  private

  def diary_params
    params.require(:diary).permit(:body_weight, :body)
  end

end
