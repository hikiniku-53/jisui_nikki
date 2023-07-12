class Public::FavoritesController < ApplicationController
  before_action :recipe_params

  def create
    Favorite.create(customer_id: current_customer.id, recipe_id: params[:recipe_id])
  end

  def destroy
    Favorite.find_by(customer_id: current_customer.id, recipe_id: params[:recipe_id]).destroy
  end

  private

  def recipe_params
    @recipe = Recipe.find(params[:recipe_id])
  end

end
