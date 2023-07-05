class Public::FavoritesController < ApplicationController

  def create
    @recipe_favorite = Favorite.new(customer_id: current_customer.id, recipe_id: params[:recipe_id])
    @recipe_favorite.save
    redirect_to recipe_path(params[:recipe_id])
  end

  def destroy
    @recipe_favorite = Favorite.find(customer_id: current_customer.id, recipe_id: params[:recipe_id])
    @recipe_favorite.destroy
    redirect_to recipe_path(params[:recipe_id])
  end
  
end
