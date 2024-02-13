class Public::DiariesController < ApplicationController
  before_action :authenticate_customer!

  # 日記の作成
  def create
    @diary = Diary.new(diary_params)
    @diary.customer_id = current_customer.id
    @date = Time.zone.today.to_date
    # binding.pry
    # 指定があれば日付の取得
    @date = params[:date].to_date if params[:date]

    @diary.save
    # binding.pry
    # 当日の日記へ飛ぶ
    if (controller_path == 'homes' && action_path == 'top' )
      redirect_to root_path
    else
      redirect_to customer_path
    end
  end

  # 日記の更新
  def update

    @diary = current_customer.diaries.find(params[:id])
    @diary.update(diary_params)
    # binding.pry
    if (controller_path == 'homes' && action_path == 'top' )
      redirect_to root_path
    else
      redirect_to customer_path
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:date, :body_weight, :body)
  end
end
