class CalendarsController < ApplicationController

  # 1週間のカレンダーと予定が表示されるページ
  def index

    get_week

    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week

    wdays = ['(日)', '(月)', '(火)', '(水)', '(木)', '(金)', '(土)']
  

    @todays_date = Date.today
    @week_days = []
  
    plans = Plan.where(date: @todays_date..@todays_date + 6).group_by(&:date)
  
    7.times do |x|

      todays_date = @todays_date + x
      day_plans = plans[todays_date]&.map(&:plan) || []
  
      wday_num = (todays_date.wday) % 7
      @week_days << {
        month: todays_date.month,
        date: todays_date.day,
        wday: wdays[wday_num], 
        plans: day_plans
      }

    end
  end
end