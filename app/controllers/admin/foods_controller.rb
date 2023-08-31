class Admin::FoodsController < ApplicationController
  before_action :authenticate_admin!
  before_action :make_instance, except: [:index]

  # 登録食材一覧
  def index
    @foods = Food.all
  end

  # 食材詳細
  def show
    # 食材についたコメント取得
    @comments = @food.comments
  end

  # 食材情報更新画面
  def edit
    @food_genres = FoodGenre.all
  end

  # 食材情報更新
  def update
    @food.update(food_params)
    redirect_to admin_food_path(params[:id])
  end

  # 食材削除
  def destroy
    @food.destroy
    redirect_to admin_foods_path
  end


  private

  def food_params
    params.require(:food).permit(:name, :energy, :protein, :fat, :carb, :salt_equivalent, :food_genre_id)
  end

  def make_instance
    @food = Food.find(params[:id])
  end

end
