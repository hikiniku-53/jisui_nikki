class Public::DiariesController < ApplicationController
  before_action :authenticate_customer!

  # 日記の作成
  def create
    @diary = Diary.new(diary_params)
    @diary.customer_id = current_customer.id
    @date = Time.zone.today

    # 指定があれば日付の取得
    @date = params[:date] if params[:date]

    @diary.save
    # 当日の日記へ飛ぶ
    redirect_to customer_path
  end

  # 日記の更新
  def update
    @date = Time.zone.today
    @date = params[:date] if params[:date]
    @diary = current_customer.diaries.find_by(date: @date)
    @diary.update(diary_params)
    redirect_to customer_path
  end

  private

  def diary_params
    params.require(:diary).permit(:date, :body_weight, :body)
  end
end
