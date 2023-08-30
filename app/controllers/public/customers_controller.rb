class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show

    # 表示する日記の日付を指定(デフォルト→当日)
    @date = Date.today
    # 送られた日付を上書きする
    if params[:date]
      @date = params[:date]
    end

    # 食事の記録
    ## 一日の食事のエネルギー・栄養素の合計用インスタンス変数
    @total_energy = 0
    @total_protein = 0
    @total_fat = 0
    @total_carb = 0
    @total_salt_equivalent = 0

    ## 指定の日付の日記データ・各食事内容の取得
    @diary = current_customer.diaries.find_by(date: @date)
    @meals = current_customer.meals.where(date: @date)
    @breakfasts = current_customer.meals.where(date: @date, time: 0)
    @lunches = current_customer.meals.where(date: @date, time: 1)
    @dinners = current_customer.meals.where(date: @date, time: 2)
    @others = current_customer.meals.where(date: @date, time: 3)

    # 体重変化表示グラフ用のデータ取得
    ## 日記の日付6日前から当日までの一週間の日付を取得
    @day1 = @date.to_date.ago(6.days)
    @day2 = @date.to_date.ago(5.days)
    @day3 = @date.to_date.ago(4.days)
    @day4 = @date.to_date.ago(3.days)
    @day5 = @date.to_date.ago(2.days)
    @day6 = @date.to_date.ago(1.days)
    @day7 = @date.to_date

    ## 一週間の日記から各日付の体重データを取得(日記データがない場合はnilを代入)
    @diaries = current_customer.diaries
    if @diaries.find_by(date: @day1)
      @weight1 = @diaries.find_by(date: @day1).body_weight
    else
      @weight1 = nil
    end

    if @diaries.find_by(date: @day2)
      @weight2 = @diaries.find_by(date: @day2).body_weight
    else
      @weight2 = nil
    end

    if @diaries.find_by(date: @day3)
      @weight3 = @diaries.find_by(date: @day3).body_weight
    else
      @weight3 = nil
    end

    if @diaries.find_by(date: @day4)
      @weight4 = @diaries.find_by(date: @day4).body_weight
    else
      @weight4 = nil
    end

    if @diaries.find_by(date: @day5)
      @weight5 = @diaries.find_by(date: @day5).body_weight
    else
      @weight5 = nil
    end

    if @diaries.find_by(date: @day6)
      @weight6 = @diaries.find_by(date: @day6).body_weight
    else
      @weight6 = nil
    end

    if @diaries.find_by(date: @day7)
      @weight7 = @diaries.find_by(date: @day7).body_weight
    else
      @weight7 = nil
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
end