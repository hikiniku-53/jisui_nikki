class Public::HomesController < ApplicationController
  # トップ画面
  def top
    # 最新の食材データ三つ取得
    @foods = Food.last(3)

    # 最新のレシピ(公開設定)データ三つ取得
    @recipes = Recipe.where(is_published: 'true').last(3)

    # ユーザーログインしているか？
    return unless customer_signed_in?

    @date = Time.zone.today

    # している→当日の食事が一つでも登録されているか？
    if current_customer.meals.exists?

      # 登録あり→当日の各食事データ取得
      @breakfasts = current_customer.meals.where(date: @date, time: 0)
      @lunches = current_customer.meals.where(date: @date, time: 1)
      @dinners = current_customer.meals.where(date: @date, time: 2)
      @others = current_customer.meals.where(date: @date, time: 3)
    else

      # 登録なし→各食事に空の配列を代入
      @breakfasts = []
      @lunches = []
      @dinners = []
      @others = []
    end
  end
end
