class Public::HomesController < ApplicationController
  def top
    @foods = Food.all.last(3)
    @recipes = Recipe.all.last(3)
  end

  def about
  end
end
