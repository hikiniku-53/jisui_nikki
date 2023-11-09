class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :make_instance

  def show
    # 日記の日付指定があればその日を、なければ当日を指定
    @date = (params[:date] ? params[:date].to_date : Time.zone.today)

    ## 指定の日付の日記データ・各食事内容の取得
    @diary = current_customer.diaries.find_by(date: @date)
    @meals = current_customer.meals.where(date: @date)
    @breakfasts = current_customer.meals.where(date: @date, time: 0)
    @lunches = current_customer.meals.where(date: @date, time: 1)
    @dinners = current_customer.meals.where(date: @date, time: 2)
    @others = current_customer.meals.where(date: @date, time: 3)

    # 体重変化表示グラフ用のデータ取得
    ## 一週間の日記から各日付の体重データを取得(日記データがない場合は0を代入)

    @days = 7
    i = 0
    @body_weights = []
    while i < @days
      day = @date.ago((@days - 1 - i).days)
      diary = current_customer.diaries.find_by(date: day)
      @body_weights.push(diary ? diary.body_weight : 0)
      i += 1
    end

    # 自身の投稿レシピデータを取得
    @recipes = current_customer.recipes

    # 自身がいいねをつけたレシピデータを取得
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)
  end

  private

  # マイページでの日記の表示・作成・更新用
  def diary_params
    params.require(:diary).permit(:date, :body_weight, :body)
  end

  ## 一日の食事のエネルギー・栄養素の合計用インスタンス変数
  def make_instance
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0
  end
end
