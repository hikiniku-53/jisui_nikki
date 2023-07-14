class Public::MealDetailsController < ApplicationController
  def 
  end
  
  
  
  private
  
  def meal_detail_params
    params.require(:meal_detail).permit(meal_id)
  end
  
end
