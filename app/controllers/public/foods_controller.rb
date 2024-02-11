class Public::FoodsController < ApplicationController
  before_action :authenticate_customer!

  # 全食材一覧
  def index
    @foods = Food.all.page(params[:page])
    @food_genres = FoodGenre.all

    # ワード検索機能
    # #キーワードを受け取った場合、そのワードを含む食材データを取得する
    @foods = @foods.search(params[:keyword]) if params[:keyword]
    @keyword = params[:keyword]
  end

  # ジャンル検索
  def genre
    @food_genre = FoodGenre.find(params[:food_genre_id])
    @foods = @food_genre.foods.page(params[:page])
    @food_genres = FoodGenre.all
    # ワード検索機能
    # #キーワードを受け取った場合、そのワードを含む食材データを取得する
    @foods = @foods.search(params[:keyword]) if params[:keyword]
    @keyword = params[:keyword]
  end

  # 食材詳細
  def show
    @food = Food.find(params[:id])
    # ユーザーごとに登録した値段を取得
    @price = current_customer.prices.find_by(food_id: @food.id)
    @comment = Comment.new
    @comments = @food.comments
    @food_genres = FoodGenre.all
  end

  # 食材登録画面
  def new
    @food = Food.new
    @food_genres = FoodGenre.all
  end

  # 食事情報更新画面
  def edit
    @food = Food.find(params[:id])
    @food_genres = FoodGenre.all
  end

  # 食材登録
  def create
    @food = Food.new(food_params)
    @food_genres = FoodGenre.all
    if @food.save
      redirect_to foods_path
    else
      render :new
    end
  end

  # 食材情報更新
  def update
    @food = Food.find(params[:id])
    @food_genres = FoodGenre.all
    if @food.update(food_params)
      redirect_to food_path(params[:id])
    else
      render :edit
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :energy, :protein, :fat, :carb, :salt_equivalent, :food_genre_id, :image)
  end
end
