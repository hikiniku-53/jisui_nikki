class Public::DiariesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @diary = Diary.new(diary_params)
    @diary.customer_id = current_customer.id
    @date = Date.today

    if params[:date]
      @date = params[:date]
    end

    if @diary.save
      redirect_to customer_path
    else
      render 'customers/new'
    end
  end

  def update
    @date = Date.today
    if params[:date]
      @date = params[:date]
    end
    @diary = current_customer.diaries.find_by(date: @date)
    if @diary.update(diary_params)
      redirect_to customer_path
    else
      render :'customers/edit'
    end
  end


  private

  def diary_params
    params.require(:diary).permit(:date, :body_weight, :body)
  end
end
