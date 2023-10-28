class Public::CuttingBoardFoodsController < ApplicationController
  before_action :authenticate_customer!

  # まな板の食材と追加用の食材一覧(全食材orキーワード検索)
  def index
    @foods = Food.all

    # 検索用ジャンルデータ取得
    @food_genres = FoodGenre.all

    # ワード検索機能
    @keyword= params[:keyword]
    ##キーワードを受け取った場合、そのワードを含む食材データを取得する
    if params[:keyword]
      @foods = @foods.search(params[:keyword])
    end
    @keyword= params[:keyword]

    # 現在のまな板上の食材データを取得
    @cutting_board_foods = current_customer.cutting_board_foods

    # まな板の食材エネルギー合算用インスタンス変数
    @total_energy = 0
  end

  # まな板の食材と追加用の食材一覧(ジャンル検索)
  def genre
    @food_genre = FoodGenre.find(params[:genre_id])
    @food_genres = FoodGenre.all
    @foods = @food_genre.foods
    @cutting_board_foods = current_customer.cutting_board_foods
    @foods = @food_genre.foods
  end

  # まな板に食材を追加(レシピに使う食材を追加)
  def create

    # 送られてきた食材が自分のまな板にすでに乗っているか？
    cutting_board_food = current_customer.cutting_board_foods.find_by(food_id: cutting_board_food_params[:food_id])
    if cutting_board_food

      # ある→すでに乗っていた分量に送った分量を追加
      amount = cutting_board_food_params[:amount].to_i
      cutting_board_food.amount += amount
      cutting_board_food.update(amount: cutting_board_food.amount)
    else

      # ない→まな板に食材を追加
      @cutting_board_food = CuttingBoardFood.new(cutting_board_food_params)
      @cutting_board_food.customer_id = current_customer.id
      @cutting_board_food.save
    end

    flash[:notice] = "まな板に食材を追加しました"
    redirect_to cutting_board_foods_path
  end

  # まな板の食材の分量を変更する
  def update
    cutting_board_food = CuttingBoardFood.find(params[:id])
    cutting_board_food.update(cutting_board_food_params)
    flash[:notice] = "分量を変更しました"
    redirect_to cutting_board_foods_path
  end

  # まな板上の指定の食材を削除する
  def destroy
    cutting_board_food = CuttingBoardFood.find(params[:id])
    cutting_board_food.destroy
    redirect_to cutting_board_foods_path
    flash[:notice] = "食材をを削除しました"
  end

  # 自分のまな板の食材を全削除する
  def destroy_all
    current_customer.cutting_board_foods.destroy_all
    redirect_to cutting_board_foods_path
  end

  private

  def cutting_board_food_params
    params.require(:cutting_board_food).permit(:food_id, :amount)
  end
end