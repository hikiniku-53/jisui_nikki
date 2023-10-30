class Public::RecipesController < ApplicationController
    before_action :authenticate_customer!

  # レシピ一覧
  def index
    @recipes = Recipe.all.where(is_published: 'true')
    @tag_list = Tag.all

    # ワード検索機能
    ##キーワードを受け取った場合、そのワードを含む食材データを取得する
    if params[:keyword]
      @recipes = @recipes.search(params[:keyword])
    end
    @keyword= params[:keyword]
  end

  # レシピ詳細
  def show
    @recipe = Recipe.find(params[:id])

    # 使用食材を取得
    @recipe_foods = @recipe.recipe_details

    # つけられたタグを取得
    @tag_list = Tag.all

    # 栄養素の合算用インスタンス変数
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0
    @total_price = 0

    # 値段の登録有無の判断用インスタンス変数
    @price_calc = true
  end

  # レシピ作成画面
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

  # レシピ作成
  def create
    @cutting_board_foods = current_customer.cutting_board_foods
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0
    @total_price = 0
    @price_calc = true
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save

      # まな板の食材をレシピに保存する
      current_customer.cutting_board_foods.each do |cutting_board_food|
        @recipe_detail = RecipeDetail.new
        @recipe_detail.recipe_id = @recipe.id
        @recipe_detail.food_id = cutting_board_food.food_id
        @recipe_detail.amount = cutting_board_food.amount
        @recipe_detail.save
      end

      # タグ欄に入力された内容を"、"で区切り、リスト化
      tag_list = params[:recipe][:tag_name].split('、')

      # 投稿したタグの数[tag_num]を取得
      tag_num = tag_list.count
      i = 0

      # i番目のタグとそれ以降のタグをi番目のタグと一致するか判定
      #   一致→そのタグを削除し、次のタグへ
      #   不一致→次のタグへ
      # iを増加させ、重複タグを全て削除する

      while i < tag_num - 1
        j = i + 1
        while j < tag_num
          if tag_list[i] == tag_list[j]
            binding.pry
            tag_list.delete_at(j)
            tag_num = tag_list.count
            next
          end
          j += 1
        end
        i += 1
      end

      # リスト化したタグをそれぞれ保存
      @recipe.save_tag(tag_list)

      # まな板の食材を削除する
      current_customer.cutting_board_foods.destroy_all

      # マイページへ飛ぶ
      redirect_to customer_path
    else
      render :new
    end
  end

  # レシピ編集
  def edit
    @recipe = Recipe.find(params[:id])
    @foods = Food.all
    # 使用食材を取得
    @recipe_foods = @recipe.recipe_details

    # ワード検索機能
    @keyword= params[:keyword]
    ##キーワードを受け取った場合、そのワードを含む食材データを取得する
    if params[:keyword]
      @foods = @foods.search(params[:keyword])
    end
    @keyword= params[:keyword]
  end

  def update_recipe_details
    recipe_detail = RecipeDetail.find(params[:id])
    recipe_detail.update(recipe_detail_params)
    flash[:notice] = "分量を変更しました"
    redirect_to edit_recipe_path(recipe_detail.recipe_id)
  end

  def update_recipes
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    flash[:notice] = "レシピを変更しました"
    redirect_to recipe_path(params[:id])
  end

  def create_recipe_detail
      recipe_detail = Recipe.find(params[:id]).recipe_details.find_by(food_id: recipe_detail_params[:food_id])

    if recipe_detail
      # ある→すでに乗っていた分量に送った分量を追加
      amount = recipe_detail_params[:amount].to_i
      recipe_detail.amount += amount
      if recipe_detail.update(amount: recipe_detail.amount)
        flash[:notice] = "食材を追加しました"
        redirect_to edit_recipe_path(params[:id])
      else
        render :edit
      end
    else

      @recipe_detail = RecipeDetail.new(recipe_detail_params)
      @recipe_detail.recipe_id = params[:id]
      if @recipe_detail.save
        flash[:notice] = "食材を追加しました"
        redirect_to edit_recipe_path(params[:id])
      else
        render :edit
      end
    end
  end

  def destroy_recipe_detail
    recipe_detail = RecipeDetail.find(params[:id])
    recipe_detail.destroy
    redirect_to edit_recipe_path(recipe_detail.recipe_id)
    flash[:notice] = "食材をを削除しました"
  end

  # レシピ削除
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  # タグ検索
  def search_tag
    @tag_list = Tag.all

    # 選択したタグを持つレシピを取得
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.where(is_published: 'true')
    @keyword= params[:keyword]
  end


  private

  def recipe_params
    params.require(:recipe).permit(:name, :process, :comment, :is_published, :image)
  end

  def recipe_detail_params
    params.require(:recipe_detail).permit(:food_id, :amount)
  end

  def tags_params
    params.require(:tag).permit(:tag_name)
  end

  def price_params
    params.require(:price).permit(:food_price)
  end

end
