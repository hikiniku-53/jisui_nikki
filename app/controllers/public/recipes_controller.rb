class Public::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0
  end

  def confirmation
    @cutting_board_foods = current_customer.cutting_board_foods
    @recipe = Recipe.new(recipe_params)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    @recipe.save

    # まな板の食材をレシピに保存する
    current_customer.cutting_board_foods.each do |cutting_board_food|
      @recipe_detail = RecipeDetail.new
      @recipe_detail.recipe_id = @recipe.id
      @recipe_detail.food_id = cutting_board_food.food_id
      @recipe_detail.amount = cutting_board_food.amount
      # 異常発生時にロールバックする
      @recipe_detail.save!
    end


    tag_list = params[:recipe][:tag_name].split(',')

    if @recipe.save
      @recipe.save_tag(tag_list)

      # まな板の食材を削除する
      current_customer.cutting_board_foods.destroy_all

      # マイページへ飛ぶ
      redirect_to customer_path
      flash[:notice] = "レシピを投稿しました！"
    end

  end

  def index
  end

  def show
  end

  private

  def recipe_params
    prams.require(:recipe).permit(:name, :process, :comment, :is_published)
  end

end
