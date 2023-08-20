class Public::RecipesController < ApplicationController
    before_action :authenticate_customer!

  def index
    @recipes = Recipe.all.where(is_published: 'true')
    @tag_list = Tag.all
    # キーワード検索時に@recipes更新
    if params[:keyword]
      @recipes = @recipes.search(params[:keyword])
    end
    @keyword= params[:keyword]
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_details
    @tag_list = Tag.all
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0
    @total_price = 0
    @price_calc = true
  end


  def new
    @cutting_board_foods = current_customer.cutting_board_foods
    @recipe = Recipe.new
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0
    @total_price = 0
    @price_calc = true
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

    tag_list = params[:recipe][:tag_name].split('、')

    if @recipe.save
      @recipe.save_tag(tag_list)

      # まな板の食材を削除する
      current_customer.cutting_board_foods.destroy_all

      # マイページへ飛ぶ
      redirect_to customer_path
      flash[:notice] = "レシピを投稿しました！"
    end
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.where(is_published: 'true')
    @keyword= params[:keyword]
  end


  private

  def recipe_params
    params.require(:recipe).permit(:name, :process, :comment, :is_published)
  end

  def tags_params
    params.require(:tag).permit(:tag_name)
  end

  def price_params
    params.require(:price).permit(:food_price)
  end

end
